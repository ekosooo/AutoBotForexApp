import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/screen/home_screen.dart';
import 'package:signalforex/screen/analysis_screen.dart';
import 'package:signalforex/screen/login_screen.dart';
import 'package:signalforex/screen/profile_screen.dart';
import 'package:signalforex/widget/coming_soon.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class BottomNavPage extends StatefulWidget {
  final int index;
  BottomNavPage({Key key, this.index}) : super(key: key);
  @override
  BottomNavPageState createState() => BottomNavPageState();
}

class BottomNavPageState extends State<BottomNavPage> {
  //-- shared preferences ---
  SharedPreferences sharedPreferences;

  bool isLogin = false;

  int _selectedTabIndex;
  @override
  void initState() {
    _selectedTabIndex = widget.index;
    initialSharedPref();
    super.initState();
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  initialSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var checkSharedPreferencesLogin = sharedPreferences.getBool('isLogin');
    print(checkSharedPreferencesLogin);
    if (checkSharedPreferencesLogin == null) {
      setState(() {
        isLogin = false;
      });
    } else {
      if (sharedPreferences.getBool('isLogin')) {
        setState(() {
          isLogin = true;
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    }
  }

  // getLoginStatus() {
  //   var checkSharedPreferencesLogin = sharedPreferences.getBool('isLogin');
  //   if (checkSharedPreferencesLogin == null) {
  //     return false;
  //   } else {
  //     if (sharedPreferences.getBool('isLogin')) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      HomePage(),
      ComingSoon(),
      AnalysisPage(),
      ComingSoon(),
      (isLogin) ? ProfilePage() : LoginPage(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      // ----- home
      BottomNavigationBarItem(
          icon: Icon(FeatherIcons.home),
          title: Text(
            "Home",
            style: TextStyle(fontFamily: "Nunito"),
          )),

      // ----- News
      BottomNavigationBarItem(
        icon: Icon(FeatherIcons.monitor),
        title: Text(
          "News",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ),

      // ------ Analysis
      BottomNavigationBarItem(
        icon: Icon(FeatherIcons.activity),
        title: Text(
          "Analysis",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ),

      // ----- Services
      BottomNavigationBarItem(
        icon: Icon(FeatherIcons.voicemail),
        title: Text(
          "Services",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ),

      // ----- Profile
      BottomNavigationBarItem(
        icon: Icon(FeatherIcons.user),
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      onTap: _onNavBarTapped,
      unselectedItemColor: Colors.grey,
      selectedItemColor: kPrimaryColor,
      elevation: 0.0,
      backgroundColor: kBackgroundColor,
    );

    return Scaffold(
      body: _listPage[_selectedTabIndex],
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
