import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/func_global.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool showPassword = true;
  bool showConfirmPass = true;

  //--- form key form register ---
  final formKeyRegister = GlobalKey<FormState>();

  //--- textediting controller ----
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  //--- loading variabel ---
  bool isLoading = false;
  Future register(String name, String username, String email, String password,
      String referral) async {
    final String baseUrl = kBaseUrlApi + 'register';
    final response = await http.post(
      '$baseUrl',
      body: {
        'name': name,
        'username': username,
        'email': email,
        'passwd': password,
        'refferer': referral,
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
        return FunctionGlobal().showSuccessDialog(context, msg);
      } else {
        return FunctionGlobal().showErrorDialog(context, msg);
      }
    } else {
      throw Exception('Fail load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
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
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)))
          : SingleChildScrollView(
              child: Form(
                key: formKeyRegister,
                child: Column(
                  children: <Widget>[
                    //SizedBox(height: 80.w),
                    // //-- logo ---
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.,
                    //   children: <Widget>[
                    //     Image.asset(
                    //       "assets/images/logo.png",
                    //       width: 140.w,
                    //       height: 140.w,
                    //     ),
                    //     SizedBox(width: 10.w),
                    //     Text(
                    //       "Signal\nForex",
                    //       style: TextStyle(
                    //         fontFamily: "Fins-Regular",
                    //         fontSize: 50.ssp,
                    //         color: kTextColor,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    //--- name --
                    //SizedBox(height: 80.w),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 55.w, vertical: 60.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Create your account',
                            style: TextStyle(
                              fontFamily: 'Nunito-Semibold',
                              fontSize: 30.ssp,
                              color: kTextColor,
                            ),
                          ),

                          //-- name --
                          SizedBox(height: 30.w),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            cursorColor: kTextColor,
                            validator: (value) =>
                                value.isEmpty ? 'Name can`t empty' : null,
                            decoration: InputDecoration(
                              fillColor: kBgInputText,
                              filled: true,
                              border: InputBorder.none,
                              hintText: 'Name',
                              hintStyle: textStyleHint,
                              contentPadding: paddingTextField,
                            ),
                          ),

                          //-- username --
                          SizedBox(height: 15.w),
                          TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            cursorColor: kTextColor,
                            validator: (value) =>
                                value.isEmpty ? 'Username can`t empty' : null,
                            decoration: InputDecoration(
                              fillColor: kBgInputText,
                              filled: true,
                              border: InputBorder.none,
                              hintText: 'Username',
                              hintStyle: textStyleHint,
                              contentPadding: paddingTextField,
                            ),
                          ),

                          //-- email --
                          SizedBox(height: 15.w),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: textStyle,
                            cursorColor: kTextColor,
                            validator: (value) => !value.contains('@')
                                ? 'Invalid email format'
                                : null,
                            decoration: InputDecoration(
                              fillColor: kBgInputText,
                              filled: true,
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: textStyleHint,
                              contentPadding: paddingTextField,
                            ),
                          ),

                          //----- password ---
                          SizedBox(height: 15.w),
                          TextFormField(
                            controller: passwordController,
                            style: textStyle,
                            cursorColor: kTextColor,
                            obscureText: showPassword,
                            // ignore: missing_return
                            validator: (value) => value.isEmpty
                                ? 'Password can`t empty'
                                : (value.length < 6)
                                    ? 'minimum length of 6 characters'
                                    : (passwordController.text ==
                                            confPassController.text)
                                        ? null
                                        : 'Password and Confirm Password not same',

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

                          //----- confirm password ---
                          SizedBox(height: 15.w),
                          TextFormField(
                            controller: confPassController,
                            style: textStyle,
                            cursorColor: kTextColor,
                            obscureText: showConfirmPass,
                            validator: (value) => value.isEmpty
                                ? 'Confirm Password can`t empty'
                                : (value.length < 6)
                                    ? 'minimum length of 6 characters'
                                    : (passwordController.text ==
                                            confPassController.text)
                                        ? null
                                        : 'Password and Confirm Password not same',
                            decoration: InputDecoration(
                              fillColor: kBgInputText,
                              filled: true,
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              hintStyle: textStyleHint,
                              contentPadding: paddingTextField,
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    showConfirmPass = !showConfirmPass;
                                  });
                                },
                                icon: Icon(
                                  (showConfirmPass)
                                      ? FeatherIcons.eye
                                      : FeatherIcons.eyeOff,
                                  size: 30.w,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          //-- code referral --
                          SizedBox(height: 15.w),
                          TextFormField(
                            controller: referralController,
                            keyboardType: TextInputType.text,
                            style: textStyle,
                            cursorColor: kTextColor,
                            // validator: (value) => value.isEmpty
                            //     ? 'Code referral can`t empty'
                            //     : null,
                            decoration: InputDecoration(
                              fillColor: kBgInputText,
                              filled: true,
                              border: InputBorder.none,
                              hintText: 'Code Referral (Optional)',
                              hintStyle: textStyleHint,
                              contentPadding: paddingTextField,
                            ),
                          ),

                          //---- button ---
                          SizedBox(height: 50.w),
                          Container(
                            height: 80.w,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white.withOpacity(0.3),
                                onTap: () {
                                  if (formKeyRegister.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    register(
                                      nameController.text,
                                      usernameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      referralController.text,
                                    );
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 28.ssp,
                                      color: Colors.white,
                                    ),
                                  ),
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
                          SizedBox(height: 40.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
