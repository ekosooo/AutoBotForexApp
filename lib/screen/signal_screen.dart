import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forex_app/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:forex_app/widget/profit_chart.dart';

class SignalPage extends StatefulWidget {
  SignalPageState createState() => SignalPageState();
}

class SignalPageState extends State<SignalPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _valueDropDown = 1;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: buildAppBar(context),
      body: TabBarView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.w),
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                buildExpandableNotifier(),
                SizedBox(height: 20.w),
                buildExpandableNotifier(),
                SizedBox(height: 20.w),
                buildExpandableNotifier(),
              ],
            ),
          ),

          // ---------------------- profit weekly
          buildProfit(),
          //------------------------------------
        ],
        controller: _tabController,
      ),
    );
  }

  Container buildProfit() {
    var textStyle = TextStyle(
      fontFamily: "Nunito-SemiBold",
      fontSize: 20.ssp,
      color: kTextLightColor,
    );
    return Container(
      margin: EdgeInsets.all(25.w),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.w),
              boxShadow: [
                BoxShadow(
                  offset: Offset(8.w, 21.w),
                  blurRadius: 53.w,
                  color: Colors.black.withOpacity(0.05),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Profit",
                      style: TextStyle(
                        fontFamily: "Nunito-SemiBold",
                        fontSize: 25.ssp,
                        color: kTextLightColor,
                      ),
                    ),
                    DropdownButton(
                      underline: SizedBox(),
                      value: _valueDropDown,
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            "Weekly",
                            style: TextStyle(
                              fontFamily: "Nunito-Bold",
                              fontSize: 25.ssp,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                              fontFamily: "Nunito-Bold",
                              fontSize: 25.ssp,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _valueDropDown = value;
                        });
                        print(_valueDropDown);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.w,
                ),
                Text(
                  "+91230 Pips",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    fontSize: 55.ssp,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                Text(
                  "Profit per pair",
                  style: TextStyle(
                    fontFamily: "Nunito-SemiBold",
                    fontSize: 25.ssp,
                    color: kTextLightColor,
                  ),
                ),
                SizedBox(
                  height: 25.w,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ProfitChart(),
                ),
                SizedBox(
                  height: 30.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "+70023 Pips",
                          style: TextStyle(
                            fontFamily: "Nunito-Bold",
                            fontSize: 30.ssp,
                            color: kPrimaryColor,
                          ),
                        ),
                        _valueDropDown == 1
                            ? Text(
                                "Profit Last Week",
                                style: textStyle,
                              )
                            : Text(
                                "Profit Last Month",
                                style: textStyle,
                              ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "-250 Pips",
                          style: TextStyle(
                            fontFamily: "Nunito-Bold",
                            fontSize: 30.ssp,
                            color: Colors.red[600],
                          ),
                        ),
                        _valueDropDown == 1
                            ? Text(
                                "Loss This Week",
                                style: textStyle,
                              )
                            : Text(
                                "Loss This Month",
                                style: textStyle,
                              ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
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
      bottom: buildTabBar(),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      indicatorColor: kPrimaryColor,
      tabs: [
        Tab(
          child: Container(
            child: Center(
              child: Text(
                "Signal",
                style: TextStyle(
                  fontFamily: "Nunito-ExtraBold",
                  fontSize: 25.ssp,
                  color: kTextColor,
                ),
              ),
            ),
          ),
        ),
        Tab(
          child: Container(
            margin: EdgeInsets.only(left: 6.w, right: 6.w),
            child: Center(
              child: Text(
                "Profit",
                style: TextStyle(
                  fontFamily: "Nunito-ExtraBold",
                  fontSize: 25.ssp,
                  color: kTextColor,
                ),
              ),
            ),
          ),
        ),
      ],
      controller: _tabController,
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
                        height: 10.w,
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
}
