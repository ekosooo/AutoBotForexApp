import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signalforex/bottom_nav_page.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/func_global.dart';
import 'package:signalforex/screen/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //-- sharedpreferences ---
  SharedPreferences sharedPreferences;

  //-- Initially password is obscure
  bool showPassword = true;
  bool isLoading = false;

  //--- code send email ---
  String verifycode = '';

  //--- form key login ----
  final formKeyLogin = GlobalKey<FormState>();

  //--- textediting controller ----
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login(String email, String password) async {
    final String baseUrl = kBaseUrlApi + 'login';
    final response = await http.post(
      '$baseUrl',
      body: {
        'user': email,
        'passwd': password,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> map = json.decode(response.body);
      String status = map['status'];
      String msg = map['message'];
      String catError = map['data']['cat'];
      verifycode = map['data']['code'];
      if (status == 'success') {
        sharedPreferences = await SharedPreferences.getInstance();
        setState(() {
          sharedPreferences.setBool('isLogin', true);
          sharedPreferences.setString('id', map['data']['id']);
          sharedPreferences.setString('email', map['data']['email']);
          sharedPreferences.setString('username', map['data']['username']);
          sharedPreferences.setString('name', map['data']['name']);
          sharedPreferences.setString('mobile', map['data']['mobile']);
          sharedPreferences.setString('referral', map['data']['refferer']);
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavPage(index: 4),
          ),
        );
      } else {
        if (catError == 'verify') {
          showErrorDialogVerify(context, msg);
        } else if (catError == 'auth') {
          FunctionGlobal().showErrorDialog(context, msg);
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Fail load data');
    }
  }

  Future sendEmailVerify() async {
    final baseUrl = kBaseUrlApi + 'resend';
    final response = await http.post(
      baseUrl,
      body: {
        'verifycode': verifycode,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> map = json.decode(response.body);
      String status = map['status'];
      String msg = map['message'];
      if (status == 'success') {
        FunctionGlobal().showSuccessDialog(context, msg);
      } else {
        FunctionGlobal().showErrorDialog(context, msg);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Fail load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    var textStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 30.ssp,
      color: kTextColor,
    );
    var paddingTextField = EdgeInsets.symmetric(
      vertical: 15.w,
      horizontal: 15.w,
    );
    var textStyleHint = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 30.ssp,
      color: kTextLightColor,
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBackgroundColor,
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)))
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/logo.png",
                          width: 140.w,
                          height: 140.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Signal\nForex",
                          style: TextStyle(
                            fontFamily: "Fins-Regular",
                            fontSize: 50.ssp,
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80.w),
                    Form(
                      key: formKeyLogin,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 55.w, vertical: 60.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Login to your Account',
                              style: TextStyle(
                                fontFamily: 'Nunito-Semibold',
                                fontSize: 30.ssp,
                                color: kTextColor,
                              ),
                            ),
                            SizedBox(height: 30.w),

                            //-- email --
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: textStyle,
                              cursorColor: kTextColor,
                              validator: (value) => value.isEmpty
                                  ? 'Email / username can`t empty'
                                  : null,
                              decoration: InputDecoration(
                                fillColor: kBgInputText,
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Email / Username',
                                hintStyle: textStyleHint,
                                contentPadding: paddingTextField,
                              ),
                            ),

                            SizedBox(height: 20.w),

                            //----- password ---
                            TextFormField(
                              controller: passwordController,
                              style: textStyle,
                              cursorColor: kTextColor,
                              obscureText: showPassword,
                              validator: (value) =>
                                  value.isEmpty ? 'Password can`t empty' : null,
                              decoration: InputDecoration(
                                fillColor: kBgInputText,
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: textStyleHint,
                                contentPadding: paddingTextField,
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    (showPassword)
                                        ? FeatherIcons.eye
                                        : FeatherIcons.eyeOff,
                                    size: 30.w,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),

                            //---- button ---
                            SizedBox(height: 50.w),
                            GestureDetector(
                              onTap: () {
                                if (formKeyLogin.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                              child: Container(
                                height: 80.w,
                                child: Center(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 28.ssp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(5.w),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 21.w),
                                      blurRadius: 51.w,
                                      color: kPrimaryColor.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //--- sign up ---
                            SizedBox(height: 100.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Don`t have an account ?',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 26.ssp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontFamily: 'Nunito-Bold',
                                      fontSize: 26.ssp,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  showErrorDialogVerify(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/error.svg',
            height: 200.w,
            width: 300.w,
          ),
          SizedBox(height: 40.w),
          Text(
            'Error',
            style: TextStyle(
              fontFamily: 'Nunito-Bold',
              fontSize: 40.ssp,
              color: Colors.red[400],
            ),
          ),
          SizedBox(height: 20.w),
          Text(
            message + '. ignore if you already get email from signal forex',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 30.ssp,
              color: kTextLightColor,
            ),
          ),
          SizedBox(height: 40.w),
          Container(
            height: 80.w,
            width: 400.w,
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(50.w),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.1),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    isLoading = true;
                  });
                  sendEmailVerify();
                },
                child: Center(
                  child: Text(
                    'Send Email Verification',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 30.ssp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.w),
          Container(
            height: 80.w,
            width: 400.w,
            decoration: BoxDecoration(
              //color: Colors.red[400],
              borderRadius: BorderRadius.circular(50.w),
              border: Border.all(color: kPrimaryColor),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.1),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 30.ssp,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
