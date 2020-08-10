import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forex_app/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class SignalPage extends StatefulWidget {
  SignalPageState createState() => SignalPageState();
}

class SignalPageState extends State<SignalPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          buildExpandableNotifier(),
          SizedBox(
            height: 20.w,
          ),
          buildExpandableNotifier(),
          SizedBox(
            height: 20.w,
          ),
          buildExpandableNotifier(),
        ],
      ),
    );
  }

  ExpandableNotifier buildExpandableNotifier() {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Card(
          //clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black.withOpacity(0.2),
          elevation: 25.w,
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "EUR USD",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 35.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "1.17649",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Buy",
                                style: TextStyle(
                                  fontFamily: "Nunito-Bold",
                                  fontSize: 25.ssp,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                FeatherIcons.trendingUp,
                                color: kPrimaryColor,
                                size: 30.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Aug 7, 2020 - 13.00",
                            style: TextStyle(
                              fontFamily: "Nunito-Light",
                              fontSize: 18.ssp,
                              color: kTextLightColor,
                            ),
                          ),
                          Text(
                            "ACTIVE",
                            style: TextStyle(
                              fontFamily: "Nunito-Bold",
                              fontSize: 20.ssp,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                expanded: Container(
                  padding: EdgeInsets.all(15.w),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 4.w,
                        color: kBackgroundColor,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Take Profit 1",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "1.17749",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Take Profit 2",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "1.17849",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Take Profit 3",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "1.17949",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Container(
                        height: 4.w,
                        color: kBackgroundColor,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Stop Loss",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "1.17549",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: Colors.red[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Trade Result",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Trade Close",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "-",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Last Update",
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            "Aug 7, 2020 - 13.00",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 25.ssp,
                              color: kTextLightColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kBackgroundColor,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      title: Text(
        "Signal",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
