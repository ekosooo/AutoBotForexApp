import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  bool showCurrPass = true;
  bool showNewPass = true;
  bool showConfNewPass = true;

  //--- form key change Password ---
  final formKeyChangePassword = GlobalKey<FormState>();

  //--- texteding controller ----
  TextEditingController emailController = TextEditingController();
  TextEditingController currPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confNewPassControler = TextEditingController();

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
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 35.w),
          child: Form(
            key: formKeyChangePassword,
            child: Column(
              children: <Widget>[
                //-- email --
                SizedBox(height: 30.w),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: textStyle,
                  cursorColor: kTextColor,
                  validator: (value) =>
                      value.isEmpty ? 'Email can`t empty' : null,
                  decoration: InputDecoration(
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                  ),
                ),

                //----- Curr password ---
                SizedBox(height: 15.w),
                TextFormField(
                  controller: currPassController,
                  style: textStyle,
                  cursorColor: kTextColor,
                  obscureText: showCurrPass,
                  // ignore: missing_return
                  validator: (value) => value.isEmpty
                      ? 'Current Password can`t empty'
                      : (value.length < 6)
                          ? 'minimum length of 6 characters'
                          : null,
                  decoration: InputDecoration(
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Current Password',
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          showCurrPass = !showCurrPass;
                        });
                      },
                      icon: Icon(
                        (showCurrPass) ? FeatherIcons.eye : FeatherIcons.eyeOff,
                        size: 30.w,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                //----- New password ---
                SizedBox(height: 15.w),
                TextFormField(
                  controller: newPassController,
                  style: textStyle,
                  cursorColor: kTextColor,
                  obscureText: showNewPass,
                  // ignore: missing_return
                  validator: (value) => value.isEmpty
                      ? 'New Password can`t empty'
                      : (value.length < 6)
                          ? 'Minimum length of 6 characters'
                          : (confNewPassControler.text ==
                                  newPassController.text)
                              ? null
                              : 'New Password and Confirm New Password not same',
                  decoration: InputDecoration(
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'New Password',
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          showNewPass = !showNewPass;
                        });
                      },
                      icon: Icon(
                        (showCurrPass) ? FeatherIcons.eye : FeatherIcons.eyeOff,
                        size: 30.w,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.w),
                TextFormField(
                  controller: confNewPassControler,
                  style: textStyle,
                  cursorColor: kTextColor,
                  obscureText: showConfNewPass,
                  // ignore: missing_return
                  validator: (value) => value.isEmpty
                      ? 'Confirm New Password can`t empty'
                      : (value.length < 6)
                          ? 'Minimum length of 6 characters'
                          : (confNewPassControler.text ==
                                  newPassController.text)
                              ? null
                              : 'New Password and Confirm New Password not same',
                  decoration: InputDecoration(
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Confirm New Password',
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          showConfNewPass = !showConfNewPass;
                        });
                      },
                      icon: Icon(
                        (showCurrPass) ? FeatherIcons.eye : FeatherIcons.eyeOff,
                        size: 30.w,
                        color: Colors.grey,
                      ),
                    ),
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
                        if (formKeyChangePassword.currentState.validate()) {}
                      },
                      child: Center(
                        child: Text(
                          'Change Password',
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
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        'Change Password',
        style: TextStyle(
          fontFamily: 'Nunito-ExtraBold',
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kTextColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
