import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/screen/register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Initially password is obscure
  bool showPassword = true;

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
      body: Center(
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 55.w, vertical: 60.w),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 244, 244, 1),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: textStyle,
                        cursorColor: kTextColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: textStyleHint,
                          contentPadding: paddingTextField,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w),

                    //----- password ---
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 244, 244, 1),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Center(
                        child: TextField(
                          style: textStyle,
                          cursorColor: kTextColor,
                          obscureText: showPassword,
                          decoration: InputDecoration(
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
                      ),
                    ),

                    //---- button ---
                    SizedBox(height: 50.w),
                    GestureDetector(
                      onTap: () {
                        print('tombol');
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
                                    builder: (context) => RegisterPage()));
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
            ],
          ),
        ),
      ),
    );
  }
}
