import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  //--- form key form register ---
  final formKeyEditProfile = GlobalKey<FormState>();

  //--- textediting controller ----
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  //--- style text ---
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 35.w),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              //--- foto profile ---
              Row(
                children: <Widget>[
                  Container(
                    width: 140.w,
                    height: 140.w,
                    child: Center(
                      child: Icon(
                        FeatherIcons.user,
                        color: Colors.white,
                        size: 70.w,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Text(
                    'Change photo',
                    style: TextStyle(
                      fontFamily: 'Nunito-Bold',
                      fontSize: 32.ssp,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),

              //-- form ---
              //-- name --
              SizedBox(height: 80.w),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                style: textStyle,
                cursorColor: kTextColor,
                validator: (value) => value.isEmpty ? 'Name can`t empty' : null,
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
              SizedBox(height: 20.w),
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
              SizedBox(height: 20.w),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: textStyle,
                cursorColor: kTextColor,
                validator: (value) =>
                    !value.contains('@') ? 'Invalid email format' : null,
                decoration: InputDecoration(
                  fillColor: kBgInputText,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle: textStyleHint,
                  contentPadding: paddingTextField,
                ),
              ),

              //-- phone --
              SizedBox(height: 20.w),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.number,
                style: textStyle,
                cursorColor: kTextColor,
                validator: (value) =>
                    value.isEmpty ? 'Mobile can`t empty' : null,
                decoration: InputDecoration(
                  fillColor: kBgInputText,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Mobile',
                  hintStyle: textStyleHint,
                  contentPadding: paddingTextField,
                ),
              ),

              //-- referral --
              SizedBox(height: 20.w),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.number,
                style: textStyle,
                cursorColor: kTextColor,
                decoration: InputDecoration(
                  fillColor: kBgInputText,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Referral',
                  hintStyle: textStyleHint,
                  contentPadding: paddingTextField,
                ),
              ),

              //---- button ---
              SizedBox(height: 80.w),
              Container(
                height: 80.w,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.3),
                    onTap: () {
                      if (formKeyEditProfile.currentState.validate()) {}
                    },
                    child: Center(
                      child: Text(
                        'Update Profile',
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        'Edit Profile',
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
