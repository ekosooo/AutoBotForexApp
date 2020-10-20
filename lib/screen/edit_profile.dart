import 'dart:io';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalforex/func_global.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  //-- variabel image --
  File image;

  String name = '';
  String email = '';
  String username = '';
  String mobile = '';
  String referral = '';

  //--- sharedprefrence ---
  SharedPreferences sharedPreferences;

  //--- form key form register ---
  final formKeyEditProfile = GlobalKey<FormState>();

  //--- textediting controller ----
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

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
  void initState() {
    this.getDataSharedPref();
    super.initState();
  }

  imgFromCamera() async {
    // ignore: deprecated_member_use
    File imageResult = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      image = imageResult;
    });
  }

  imgFromGallery() async {
    // ignore: deprecated_member_use
    File imageResult = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      image = imageResult;
    });
  }

  getDataSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(
      () {
        name = sharedPreferences.getString('name');
        email = sharedPreferences.getString('email');
        username = sharedPreferences.getString('username');
        mobile = sharedPreferences.getString('mobile');
        referral = sharedPreferences.getString('referral');

        //-- control textfield
        nameController.text = FunctionGlobal().capitalizeFirstLetter(name);
        emailController.text = FunctionGlobal().capitalizeFirstLetter(email);
        usernameController.text =
            FunctionGlobal().capitalizeFirstLetter(username);
        referralController.text = referral;
        mobileController.text = mobile;
      },
    );
  }

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
          child: Form(
            key: formKeyEditProfile,
            child: Column(
              children: <Widget>[
                //--- foto profile ---
                Row(
                  children: <Widget>[
                    image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(80.w),
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                              width: 140.w,
                              height: 140.w,
                            ),
                          )
                        : Container(
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
                    GestureDetector(
                      onTap: () {
                        showImagePicker(context);
                      },
                      child: Text(
                        'Change photo',
                        style: TextStyle(
                          fontFamily: 'Nunito-Bold',
                          fontSize: 32.ssp,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                //-- form ---
                //-- name --
                SizedBox(height: 80.w),
                TextFormField(
                  readOnly: true,
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  style: textStyle,
                  cursorColor: kTextColor,
                  validator: (value) =>
                      value.isEmpty ? 'Name can`t empty' : null,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: kTextLightColor,
                    ),
                    labelText: 'Name',
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
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
                    labelStyle: TextStyle(
                      color: kTextLightColor,
                    ),
                    labelText: 'username',
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                  ),
                ),

                //-- email --
                SizedBox(height: 20.w),
                TextFormField(
                  readOnly: true,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: textStyle,
                  cursorColor: kTextColor,
                  validator: (value) =>
                      !value.contains('@') ? 'Invalid email format' : null,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: kTextLightColor,
                    ),
                    labelText: 'email',
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                  ),
                ),

                //-- phone --
                SizedBox(height: 20.w),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  cursorColor: kTextColor,
                  validator: (value) =>
                      value.isEmpty ? 'Mobile can`t empty' : null,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: kTextLightColor,
                    ),
                    labelText: 'Mobile Phone',
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
                    hintStyle: textStyleHint,
                    contentPadding: paddingTextField,
                  ),
                ),

                //-- referral --
                SizedBox(height: 20.w),
                TextFormField(
                  controller: referralController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  cursorColor: kTextColor,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: kTextLightColor,
                    ),
                    labelText: 'Referral Code',
                    fillColor: kBgInputText,
                    filled: true,
                    border: InputBorder.none,
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

  showImagePicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Camera',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 28.ssp,
                      color: kTextColor,
                    ),
                  ),
                  leading: Icon(
                    FeatherIcons.camera,
                    color: kPrimaryColor,
                  ),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text(
                    'Gallery',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 28.ssp,
                      color: kTextColor,
                    ),
                  ),
                  leading: Icon(
                    FeatherIcons.image,
                    color: kPrimaryColor,
                  ),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
