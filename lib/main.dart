import 'package:flutter/material.dart';
import 'package:forex_app/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:forex_app/screen/calendar_screen.dart';
import 'package:forex_app/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavPage(),
    );
  }
}

class BottomNavPage extends StatefulWidget {
  @override
  BottomNavPageState createState() => BottomNavPageState();
}

class BottomNavPageState extends State<BottomNavPage> {
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
        child: Text("News"),
      ),
      Center(
        child: Text("Analysis"),
      ),
      Center(
        child: Text("Services"),
      ),
      Center(
        child: Text("Profile"),
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
