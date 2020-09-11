import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/screen/home_screen.dart';
import 'package:signalforex/screen/analysis_screen.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class BottomNavPage extends StatefulWidget {
  @override
  BottomNavPageState createState() => BottomNavPageState();
}

class BottomNavPageState extends State<BottomNavPage> {
  // //----- fcm ---
  // FirebaseMessaging fm = FirebaseMessaging();
  // String token = '';

  // @override
  // void initState() {
  //   super.initState();
  // }
  // //----- end fcm ---

  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      HomePage(),
      Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(fontFamily: 'Nunito-Bold', fontSize: 30.0),
        ),
      ),
      AnalysisPage(),
      Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(fontFamily: 'Nunito-Bold', fontSize: 30.0),
        ),
      ),
      Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(fontFamily: 'Nunito-Bold', fontSize: 30.0),
        ),
      ),
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
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _listPage[_selectedTabIndex],
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
