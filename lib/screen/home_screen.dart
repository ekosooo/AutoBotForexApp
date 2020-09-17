import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/model/markethours_model.dart';
import 'package:signalforex/screen/ea_forex_screen.dart';
import 'package:signalforex/screen/indicator_screen.dart';
import 'package:signalforex/screen/signal_screen.dart';
import 'package:signalforex/widget/market_card.dart';
import 'package:flutter/cupertino.dart';
import 'calendar_screen.dart';
import 'signal_screen.dart';
import 'education_screen.dart';
import 'top_broker_screen.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/model/banner_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signalforex/func_global.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  static final List<String> imgSlider = ['promo.jpg', 'promo.jpg', 'promo.jpg'];

  //----- fcm ---
  FirebaseMessaging fm = FirebaseMessaging();
  String token = '';

  @override
  void initState() {
    fm.configure(onMessage: (Map<String, dynamic> message) async {
      //debugPrint('onMessage : $message');
      this.directPageNotif(message['data']['screen']);
    }, onResume: (Map<String, dynamic> message) async {
      //debugPrint('onResume : $message');
      this.directPageNotif(message['data']['screen']);
    }, onLaunch: (Map<String, dynamic> message) async {
      this.directPageNotif(message['data']['screen']);
      //debugPrint('onLunch : $message');
    });

    fm.getToken().then((token) => setState(() {
          this.token = token;
        }));

    fm.subscribeToTopic('signal');
    super.initState();
    this.getBanner();
    this.getMarketHours();
  }

  directPageNotif(String screenPage) async {
    switch (screenPage) {
      case "SIGNAL_SCREEN":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignalPage(
              selectedPage: 0,
            ),
          ),
        );
        break;
      case "HISSIGNAL_SCREEN":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignalPage(
              selectedPage: 1,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  Future getBanner() async {
    final String baseUrl = kBaseUrlApi + "banner";
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return Banners.fromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  Future getMarketHours() async {
    final String baseUrl = kBaseUrlApi + "markethours";
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return MarketHours.fromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  timeZone() {
    String strTimeZone = FunctionGlobal().getGMTbySystem().toString();
    String timeZone = "";
    if (strTimeZone.contains("-")) {
      timeZone = strTimeZone;
    } else {
      timeZone = "+" + strTimeZone;
    }

    return timeZone;
  }

  Future refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  valTimeMarket(int open, int close) {
    var time = DateTime.now();
    String strTime = time.toString().substring(11, 13);
    String statusMarket = "";
    if (open < close &&
        open <= int.parse(strTime) &&
        int.parse(strTime) < close) {
      statusMarket = "Open";
    } else if (open > close &&
        (open <= int.parse(strTime) || int.parse(strTime) < close)) {
      statusMarket = "Open";
    } else {
      statusMarket = "Close";
    }
    return statusMarket;
  }

  void buildSnackBar() {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text("Coming Soon !"),
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
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: kPrimaryColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildCarouselSliderFuture(),
              SizedBox(height: 60.w),
              buildFrameMenu(),
              SizedBox(height: 60.w),
              //buildMarketHours(),
              buildMarketHoursFuture(),
              SizedBox(height: 25.w),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder buildMarketHoursFuture() {
    return FutureBuilder(
      future: getMarketHours(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something Wrong",
              style: TextStyle(fontFamily: "Nunito", fontSize: 27.ssp),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return buildMarketHours(snapshot.data.data);
        } else {
          return Center(
            child: shimmerMarketHours(),
          );
        }
      },
    );
  }

  Container buildMarketHours(List<DataMarketHours> marketHoursList) {
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
              for (var i = 0; i < marketHoursList.length; i++)
                MarketHoursCard(
                  location: marketHoursList[i].center,
                  open: marketHoursList[i].open.toString().substring(11, 16) +
                      " UTC" +
                      timeZone(),
                  close: marketHoursList[i]
                          .close
                          .toString()
                          .substring(11, 16) + // substr ambil jam dan menit
                      " UTC" +
                      timeZone(),
                  statusMarket: valTimeMarket(
                    int.parse(marketHoursList[i]
                        .open
                        .toString()
                        .substring(11, 13)), // substr hanya ambil jam
                    int.parse(marketHoursList[i]
                        .close
                        .toString()
                        .substring(11, 13)), // substr hanya ambil jam
                  ),
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
              buildMenu("Signal", FeatherIcons.trendingUp),
              buildMenu("Top Broker", FeatherIcons.award),
              buildMenu("Education", FeatherIcons.book),
              buildMenu("EA Forex", FeatherIcons.gitlab),
              buildMenu("Indicator", FeatherIcons.thermometer),
              buildMenu("Tools", FeatherIcons.settings),
              buildMenu("More", FeatherIcons.moreHorizontal)
            ],
          ),
        ),
      ],
    );
  }

  FutureBuilder buildCarouselSliderFuture() {
    return FutureBuilder(
      future: getBanner(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something Wrong",
              style: TextStyle(fontFamily: "Nunito", fontSize: 24.ssp),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return buildCarouselSlider(snapshot.data.data);
        } else {
          return Center(
            child: shimmerBanner(),
          );
        }
      },
    );
  }

  CarouselSlider buildCarouselSlider(List<DataBanner> dataBannerList) {
    return CarouselSlider(
      items: <Widget>[
        for (var i = 0; i < dataBannerList.length; i++)
          GestureDetector(
            onTap: () {
              FunctionGlobal().launchURL(dataBannerList[i].link);
            },
            child: Container(
              //height: 450.w,
              // margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                child: Image.network(
                  kMasterUrl + "img/banner/" + dataBannerList[i].img,
                  width: 650.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
      ],
      options: CarouselOptions(
        height: 450.w,
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
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => IndicatorPage()));
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

  SizedBox shimmerBanner() {
    return SizedBox(
      width: 670.w,
      height: 400.w,
      child: Shimmer.fromColors(
        child: Container(
          height: 400.w,
          width: 670.w,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[300],
      ),
    );
  }

  SizedBox shimmerMarketHours() {
    return SizedBox(
      width: 670.w,
      height: 400.w,
      child: Shimmer.fromColors(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 140.w,
                  width: 320.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
                Container(
                  height: 140.w,
                  width: 320.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 140.w,
                  width: 320.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
                Container(
                  height: 140.w,
                  width: 320.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
              ],
            ),
          ],
        ),
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[300],
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
