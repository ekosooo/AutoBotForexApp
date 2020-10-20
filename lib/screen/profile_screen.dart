import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/bottom_nav_page.dart';
import 'package:signalforex/constants.dart';
import 'package:signalforex/screen/change_password_screen.dart';
import 'package:signalforex/screen/edit_profile.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:signalforex/screen/signal_notif_setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  //-- shared preferences --
  SharedPreferences sharedPreferences;

  String name = '';
  String email = '';
  String referral = '';

  //-- share link --
  Future<void> shareReferral() async {
    await FlutterShare.share(
      title: 'Signal Forex',
      text:
          'Yuk.. gabung bersama kami untuk hasil trading yang lebih baik dalam genggaman',
      linkUrl: kMasterUrl + 'register/' + referral,
      chooserTitle: 'Example Chooser Tittle',
    );
  }

  @override
  void initState() {
    getDataSharedPref();
    super.initState();
  }

  getDataSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
      email = sharedPreferences.getString('email');
      referral = sharedPreferences.getString('referral');
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    var textStyleTitle = TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      fontSize: 32.ssp,
      color: kTextColor,
    );
    var textStyleMenu = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 28.ssp,
      color: kTextColor,
    );
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          buildFotoNameEmail(context, textStyleTitle),
          SizedBox(height: 30.w),
          buildMenuAccount(context, textStyleTitle, textStyleMenu),
          SizedBox(height: 30.w),
          buildMenuSecurity(context, textStyleTitle, textStyleMenu),
          SizedBox(height: 30.w),
          buildMenuSetting(context, textStyleTitle, textStyleMenu),
          SizedBox(height: 30.w),
          buildMenuAbout(context, textStyleTitle, textStyleMenu),
          buildButtonSignOut(),
        ],
      ),
    );
  }

  Container buildButtonSignOut() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 60.w),
      height: 80.w,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            sharedPreferences.setBool('isLogin', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavPage(
                  index: 4,
                ),
              ),
            );
          },
          splashColor: Colors.white.withOpacity(0.3),
          child: Container(
            child: Center(
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 28.ssp,
                  color: Colors.white,
                ),
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
    );
  }

  Container buildMenuAccount(
      BuildContext context, TextStyle textStyleTitle, TextStyle textStyleMenu) {
    return Container(
      padding: EdgeInsets.only(right: 35.w, left: 35.w, top: 30.w),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Account',
            style: textStyleTitle,
          ),
          SizedBox(height: 10.w),
          buildItemMenu(
              context, 'Edit Profile', FeatherIcons.user, textStyleMenu),
          Container(
            height: 3.w,
            color: kBackgroundColor,
          ),
          buildItemMenu(
              context, 'Trading Account', FeatherIcons.user, textStyleMenu),
          Container(
            height: 3.w,
            color: kBackgroundColor,
          ),
          buildItemMenu(
              context, 'Invite Friends', FeatherIcons.userPlus, textStyleMenu),
        ],
      ),
    );
  }

  Container buildMenuSetting(
      BuildContext context, TextStyle textStyleTitle, TextStyle textStyleMenu) {
    return Container(
      padding: EdgeInsets.only(right: 35.w, left: 35.w, top: 30.w),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Setting',
            style: textStyleTitle,
          ),
          SizedBox(height: 10.w),
          buildItemMenu(context, 'Signal Notification', FeatherIcons.trendingUp,
              textStyleMenu),
        ],
      ),
    );
  }

  Container buildMenuSecurity(
      BuildContext context, TextStyle textStyleTitle, TextStyle textStyleMenu) {
    return Container(
      padding: EdgeInsets.only(right: 35.w, left: 35.w, top: 30.w),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Security',
            style: textStyleTitle,
          ),
          SizedBox(height: 10.w),
          buildItemMenu(
              context, 'Change Password', FeatherIcons.lock, textStyleMenu),
        ],
      ),
    );
  }

  Container buildMenuAbout(
      BuildContext context, TextStyle textStyleTitle, TextStyle textStyleMenu) {
    return Container(
      padding: EdgeInsets.only(right: 35.w, left: 35.w, top: 30.w),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'About',
            style: textStyleTitle,
          ),
          SizedBox(height: 10.w),
          buildItemMenu(context, 'Term and Condition', FeatherIcons.fileText,
              textStyleMenu),
          Container(
            height: 3.w,
            color: kBackgroundColor,
          ),
          buildItemMenu(
              context, 'Help Center', FeatherIcons.helpCircle, textStyleMenu),
        ],
      ),
    );
  }

  Material buildItemMenu(BuildContext context, String titleItem,
      IconData iconItem, TextStyle textStyleMenu) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black.withOpacity(0.3),
        onTap: () {
          // print(titleItem);
          if (titleItem.toLowerCase() == 'edit profile') {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditProfilePage(),
              ),
            );
          } else if (titleItem.toLowerCase() == 'invite friends') {
            shareReferral();
          } else if (titleItem.toLowerCase() == 'account trading') {
            print('masuk account trading');
          } else if (titleItem.toLowerCase() == 'signal notification') {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => SignalNotifSettingPage(),
              ),
            );
          } else if (titleItem.toLowerCase() == 'change password') {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangePasswordPage(),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.only(top: 30.w, bottom: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      iconItem,
                      color: kPrimaryColor,
                      size: 37.w,
                    ),
                    SizedBox(width: 30.w),
                    Text(
                      titleItem,
                      style: textStyleMenu,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[300],
                size: 35.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildFotoNameEmail(BuildContext context, TextStyle textStyleTitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 50.w),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 150.w,
            height: 150.w,
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
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: textStyleTitle,
              ),
              Text(
                email,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 28.ssp,
                  color: kTextLightColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        'Profile',
        style: TextStyle(
          fontFamily: 'Nunito-ExtraBold',
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
