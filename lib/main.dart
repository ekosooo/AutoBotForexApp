import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signalforex/bottom_nav_page.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: BottomNavPage(),
      home: SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  //----- fcm ---
  // FirebaseMessaging fm = FirebaseMessaging();
  // String token = '';

  @override
  void initState() {
    // fm.configure(onMessage: (Map<String, dynamic> message) async {
    //   //debugPrint('onMessage : $message');
    //   this.directPageNotif(message['data']['screen']);
    // }, onResume: (Map<String, dynamic> message) async {
    //   //debugPrint('onResume : $message');
    //   this.directPageNotif(message['data']['screen']);
    // }, onLaunch: (Map<String, dynamic> message) async {
    //   this.directPageNotif(message['data']['screen']);
    //   //debugPrint('onLunch : $message');
    // });

    // fm.getToken().then((token) => setState(() {
    //       this.token = token;
    //     }));

    // fm.subscribeToTopic('signal');
    super.initState();
    this.startSplashScreen();
  }

  // directPageNotif(String screenPage) async {
  //   switch (screenPage) {
  //     case "SIGNAL_PAGE":
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => SignalPage(
  //             selectedPage: 0,
  //           ),
  //         ),
  //       );
  //       break;
  //     default:
  //       break;
  //   }
  // }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return BottomNavPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint('token : $token');
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                width: 200.w,
                height: 200.w,
              ),
              SizedBox(width: 10.w),
              Text(
                "Signal\nForex",
                style: TextStyle(
                  fontFamily: "Fins-Regular",
                  fontSize: 70.ssp,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 25.w),
          Text(
            "Beta Version",
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 25.ssp,
              color: kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
