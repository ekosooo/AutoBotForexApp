import 'package:flutter/material.dart';
import 'package:forex_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

import 'detail_analysis_signal_screen.dart';

class AnalysisPage extends StatefulWidget {
  AnalysisPageState createState() => AnalysisPageState();
}

class AnalysisPageState extends State<AnalysisPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildTabBar(),
          body: TabBarView(
            children: <Widget>[
              ListView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 20.w),
                  buildListPair(),
                  SizedBox(height: 20.w),
                  buildListPair(),
                  SizedBox(height: 20.w),
                  buildListPair(),
                  SizedBox(height: 20.w),
                  buildListPair(),
                  SizedBox(height: 20.w),
                  buildListPair(),
                  SizedBox(height: 20.w),
                  buildListPair(),
                ],
              ),

              //Text("ini AA"),
              Text("ini BB"),
            ],
          ),
        ),
      ),
    );
  }

  Container buildListPair() {
    var textStyleLowPrice = TextStyle(
      fontSize: 18.ssp,
      fontFamily: "Nunito-Bold",
      color: kTextLightColor,
    );
    return Container(
      margin: EdgeInsets.only(left: 25.w, right: 25.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => DetailAnalysisSignalPage()));
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.w),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(8.w, 21.w),
                    blurRadius: 53.w,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/eurusd.svg',
                            height: 35.w,
                            width: 70.w,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "EUR/USD",
                                style: TextStyle(
                                  fontFamily: "Nunito-Bold",
                                  fontSize: 25.ssp,
                                ),
                              ),
                              Text(
                                "Euro vs US Dollar",
                                style: textStyleLowPrice,
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "1.1824",
                            style: TextStyle(
                              fontSize: 30.ssp,
                              fontFamily: "Nunito-ExtraBold",
                              color: kPrimaryColor,
                            ),
                          ),
                          Text(
                            "+0.0047(+0.40%)",
                            style: textStyleLowPrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                  //--------------- row open price dan low price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Open  : 1.1794",
                            style: textStyleLowPrice,
                          ),
                          Text(
                            "Close  : 1.1781",
                            style: textStyleLowPrice,
                          ),
                        ],
                      ),
                      SizedBox(width: 30.w),
                      Column(
                        children: <Widget>[
                          Text(
                            "Low  : 1.1781",
                            style: textStyleLowPrice,
                          ),
                          Text(
                            "High : 1.1841",
                            style: textStyleLowPrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize buildTabBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        color: kBackgroundColor,
        child: SafeArea(
          top: true,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBar(indicatorColor: kPrimaryColor, tabs: [
                  Text(
                    "Signal",
                    style: TextStyle(
                      fontFamily: "Nunito-ExtraBold",
                      fontSize: 25.ssp,
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    "Patterns",
                    style: TextStyle(
                      fontFamily: "Nunito-ExtraBold",
                      fontSize: 25.ssp,
                      color: kTextColor,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
