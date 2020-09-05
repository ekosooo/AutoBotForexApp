import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/screen/ea_forex_screen.dart';
import 'package:signalforex/screen/signal_screen.dart';
import 'package:signalforex/widget/market_card.dart';
import 'package:flutter/cupertino.dart';
import 'calendar_screen.dart';
import 'signal_screen.dart';
import 'education_screen.dart';
import 'top_broker_screen.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  static final List<String> imgSlider = ['promo.jpg', 'promo.jpg', 'promo.jpg'];

  void buildSnackBar() {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text("Comming Soon !"),
        action: SnackBarAction(
            label: 'Close',
            textColor: kPrimaryColor,
            onPressed: () {
              scaffoldState.currentState.hideCurrentSnackBar();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      key: scaffoldState,
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCarouselSlider(),
            SizedBox(height: 60.w),
            buildFrameMenu(),
            SizedBox(height: 60.w),
            buildMarketHours(),
            SizedBox(height: 25.w),
          ],
        ),
      ),
    );
  }

  Container buildMarketHours() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Market Hours",
            style: TextStyle(
                fontFamily: "Nunito-ExtraBold",
                fontSize: 35.ssp,
                color: kTextColor),
          ),
          SizedBox(
            height: 15.w,
          ),
          Wrap(
            spacing: 20.w,
            runSpacing: 20.w,
            children: <Widget>[
              MarketHoursCard(
                location: "London",
                open: "01.00 WIB",
                close: "10.00 WIB",
              ),
              MarketHoursCard(
                location: "Sydney",
                open: "05.00 WIB",
                close: "14.00 WIB",
              ),
              MarketHoursCard(
                location: "Tokyo",
                open: "07.00 WIB",
                close: "16.00 WIB",
              ),
              MarketHoursCard(
                location: "New York",
                open: "20.00 WIB",
                close: "05.00 WIB",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildFrameMenu() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 35.w),
          padding: EdgeInsets.only(top: 45.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.w),
            boxShadow: [
              BoxShadow(
                offset: Offset(8.w, 21.w),
                blurRadius: 53.w,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              buildMenu("Calendar", FeatherIcons.calendar),
              buildMenu("Education", FeatherIcons.book),
              buildMenu("Signal", FeatherIcons.trendingUp),
              buildMenu("EA Forex", FeatherIcons.gitlab),
              buildMenu("Tools", FeatherIcons.settings),
              buildMenu("Indicator", FeatherIcons.thermometer),
              buildMenu("Top Broker", FeatherIcons.award),
              buildMenu("More", FeatherIcons.moreHorizontal)
            ],
          ),
        ),
      ],
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      items: imgSlider.map((fileImage) {
        return Container(
          height: 450.w,
          // margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              'assets/images/$fileImage',
              width: 650.w,
              fit: BoxFit.fill,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        //height: 650,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
      ),
    );
  }

  Container buildMenu(String _titleMenu, IconData _icon) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_titleMenu == "Calendar") {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => CalendarPage()));
              } else if (_titleMenu == "Signal") {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SignalPage(
                              selectedPage: 0,
                            )));
              } else if (_titleMenu == "EA Forex") {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => EAForexPage()));
              } else if (_titleMenu == "Education") {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => EducationPage()));
              } else if (_titleMenu == "Tools") {
                buildSnackBar();
              } else if (_titleMenu == "Indicator") {
                buildSnackBar();
              } else if (_titleMenu == "Top Broker") {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => TopBrokerPage()));
              } else if (_titleMenu == "More") {
                buildSnackBar();
              }
            },
            child: Container(
              height: 80.w,
              width: 80.w,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Center(
                child: Icon(
                  _icon,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            _titleMenu,
            style: TextStyle(fontFamily: "Nunito", fontSize: 22.ssp),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            FeatherIcons.bell,
            color: kPrimaryColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
