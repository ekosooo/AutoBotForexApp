import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool showPassword = true;
  bool showConfirmPass = true;

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
      resizeToAvoidBottomPadding: false,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 80.w),
            //-- logo ---
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

            //--- name --
            SizedBox(height: 80.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 55.w, vertical: 60.w),
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
                        hintText: 'Name',
                        hintStyle: textStyleHint,
                        contentPadding: paddingTextField,
                      ),
                    ),
                  ),

                  //-- email --
                  SizedBox(height: 15.w),
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

                  //----- password ---
                  SizedBox(height: 15.w),
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

                  //----- confirm password ---
                  SizedBox(height: 15.w),
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
                          hintText: 'Confirm Password',
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
                          'Sign up',
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
                  SizedBox(height: 40.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
