import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/bottom_nav_page.dart';
import 'package:signalforex/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/widget/no_data_record.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/model/signal_model.dart';

class SignalPage extends StatefulWidget {
  final selectedPage;
  const SignalPage({Key key, this.selectedPage});
  SignalPageState createState() => SignalPageState();
}

class SignalPageState extends State<SignalPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int valueDropDownSummary = 1;

  @override
  void initState() {
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.selectedPage);
    super.initState();
  }

  Future getSignal() async {
    final String baseUrl = kBaseUrlApi + "signal/ListSignal";
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return Signal.fromJson(response.body);
    } else {
      throw Exception('Fail load data');
    }
  }

  Future refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: buildAppBar(context),
      body: TabBarView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 35.w),
            child: RefreshIndicator(
              onRefresh: refreshData,
              color: kPrimaryColor,
              child: FutureBuilder(
                future: getSignal(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something Wrong",
                        style:
                            TextStyle(fontFamily: "Nunito", fontSize: 27.ssp),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return buildSignalList(snapshot.data.data);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          //----------------------- History -----------------
          HistorySignal(),
          //-------------------------------------------------

          // ---------------------- summary ------------------
          buildSummary(),
          //------------------------------------
        ],
        controller: _tabController,
      ),
    );
  }

  Container buildSummary() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: DropdownButton(
              underline: SizedBox(),
              value: valueDropDownSummary,
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
                  valueDropDownSummary = value;
                });
                print(valueDropDownSummary);
              },
            ),
          ),
          //),
          SizedBox(height: 60.w),
          Align(
            alignment: Alignment.center,
            child: Text(
              '4892.0 pips',
              style: TextStyle(
                fontFamily: 'Nunito-Bold',
                fontSize: 60.ssp,
                color: kPrimaryColor,
              ),
            ),
          ),

          //-------------- Profit lose ---------------------
          SizedBox(height: 80.w),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //---------- profit ------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Profit',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 25.ssp,
                        color: kTextLightColor,
                      ),
                    ),
                    SizedBox(height: 8.w),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 60.w,
                          height: 60.w,
                          child: Center(
                            child: Icon(
                              FeatherIcons.arrowUpCircle,
                              color: kPrimaryColor,
                              size: 35.w,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '+5492.0 pips',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 30.ssp,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //--------------lose --------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Lose',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 25.ssp,
                        color: kTextLightColor,
                      ),
                    ),
                    SizedBox(height: 8.w),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 60.w,
                          height: 60.w,
                          child: Center(
                            child: Icon(
                              FeatherIcons.arrowDownCircle,
                              color: Colors.red,
                              size: 35.w,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '-600.0 pips',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 30.ssp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //----------- Detail profit lose ----------------
          SizedBox(height: 40.w),
          Text(
            "Detail",
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 25.ssp,
              color: kTextLightColor,
            ),
          ),
          SizedBox(height: 8.w),
          Container(
            padding: EdgeInsets.all(15.w),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/eurusd.svg',
                      width: 75.w,
                      height: 35.w,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'EURUSD',
                          style: TextStyle(
                            fontFamily: "Nunito-ExtraBold",
                            fontSize: 25.ssp,
                            color: kTextColor,
                          ),
                        ),
                        Text(
                          'EURO vs US Dollar',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 22.ssp,
                            color: kTextLightColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '+160.0 pips',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      '-160.0 pips',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  offset: Offset(8.w, 21.w),
                  blurRadius: 35.w,
                  color: Colors.black.withOpacity(0.01),
                ),
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BottomNavPage()));
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
            child: Center(
              child: Text(
                "History",
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
                "Summary",
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
}

class HistorySignal extends StatefulWidget {
  @override
  HistorySignalState createState() => HistorySignalState();
}

class HistorySignalState extends State<HistorySignal> {
  int valueDropDownHistory = 1;
  String dateStartHistory;
  String dateEndHistory;
  DateTime timeCurrent;

  @override
  void initState() {
    super.initState();
    timeCurrent = DateTime.now();
    dateStartHistory =
        timeCurrent.subtract(Duration(days: 7)).toString().substring(0, 10);
    dateEndHistory = timeCurrent.toString().substring(0, 10);
  }

  Future refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  Future getHistory() async {
    final String baseUrl = kBaseUrlApi + "signal/HisSignal";
    final response = await http.post("$baseUrl", body: {
      'dateStart': dateStartHistory,
      'dateEnd': dateEndHistory,
    });
    if (response.statusCode == 200) {
      return Signal.fromJson(response.body);
    } else {
      throw Exception('Fail load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Select Time Range",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 25.ssp,
                    color: kTextLightColor,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: valueDropDownHistory,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "ToDay",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 25.ssp,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "Last Week",
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
                        "Last Month",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 25.ssp,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text(
                        "Last 3 Month",
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
                      valueDropDownHistory = value;
                    });
                    // print(_valueDropDownHistory);
                    if (valueDropDownHistory == 0) {
                      //to day
                      dateStartHistory = timeCurrent
                          .toString()
                          .substring(0, 10); //hanya ambil tahun bln dan tgl
                      dateEndHistory = timeCurrent.toString().substring(0, 10);
                    } else if (valueDropDownHistory == 1) {
                      //last week
                      dateStartHistory = timeCurrent
                          .subtract(Duration(days: 7))
                          .toString()
                          .substring(0, 10);
                      dateEndHistory = timeCurrent.toString().substring(0, 10);
                    } else if (valueDropDownHistory == 2) {
                      //last month
                      dateStartHistory =
                          timeCurrent.subtract(Duration(days: 30)).toString();
                      dateEndHistory = timeCurrent.toString().substring(0, 10);
                    } else if (valueDropDownHistory == 3) {
                      //last 3 month
                      dateStartHistory =
                          timeCurrent.subtract(Duration(days: 90)).toString();
                      dateEndHistory = timeCurrent.toString().substring(0, 10);
                    }
                  },
                ),
              ],
            ),
          ),

          //---------future
          RefreshIndicator(
            onRefresh: refreshData,
            child: FutureBuilder(
              future: getHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Something Wrong",
                      style: TextStyle(
                          fontFamily: "Nunito-Bold", fontSize: 30.ssp),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return buildSignalList(snapshot.data.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

buildSignalList(List<DataSignal> dataSignalList) {
  if (dataSignalList.length == 0) {
    return NoDataRecord();
  } else {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: dataSignalList.length,
      itemBuilder: (context, index) {
        DataSignal dataSignal = dataSignalList[index];
        var textTitle = TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 25.ssp,
          color: kTextColor,
        );
        return ExpandableNotifier(
          child: ScrollOnExpand(
            child: Card(
              //clipBehavior: Clip.antiAlias,
              shadowColor: Colors.black.withOpacity(0.2),
              elevation: 25.w,
              margin: EdgeInsets.only(left: 35.w, right: 35.w, bottom: 15.w),
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
                              Row(
                                children: <Widget>[
                                  SvgPicture.network(
                                    kMasterUrl +
                                        "img/pairs/" +
                                        dataSignal.pairimg,
                                    height: 35.w,
                                    width: 70.w,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    dataSignal.pairname,
                                    style: TextStyle(
                                      fontFamily: "Nunito-ExtraBold",
                                      fontSize: 25.ssp,
                                      color: kTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                dataSignal.price,
                                style: TextStyle(
                                  fontFamily: "Nunito-ExtraBold",
                                  fontSize: 25.ssp,
                                  color: kTextColor,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    dataSignal.ordertype,
                                    style: TextStyle(
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 25.ssp,
                                      color: (dataSignal.ordertype == 'BUY')
                                          ? kPrimaryColor
                                          : Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    (dataSignal.ordertype == 'BUY')
                                        ? FeatherIcons.trendingUp
                                        : FeatherIcons.trendingDown,
                                    color: (dataSignal.ordertype == 'BUY')
                                        ? kPrimaryColor
                                        : Colors.red,
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
                                dataSignal.timeopen.toString().substring(0, 19),
                                style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 18.ssp,
                                  color: kTextLightColor,
                                ),
                              ),
                              Text(
                                (dataSignal.status == 8) //8 = code active
                                    ? "Active"
                                    : "Expired",
                                style: TextStyle(
                                  fontFamily: "Nunito-Bold",
                                  fontSize: 20.ssp,
                                  color: (dataSignal.status == 8)
                                      ? kPrimaryColor
                                      : Colors.red,
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
                                style: textTitle,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    dataSignal.tp1,
                                    style: TextStyle(
                                      fontFamily: "Nunito-ExtraBold",
                                      fontSize: 25.ssp,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  if (dataSignal.statusfloating ==
                                      1) // 1 = signal hit TP 1
                                    Container(
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: Icon(
                                        FeatherIcons.checkCircle,
                                        size: 25.w,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                ],
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
                                style: textTitle,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    dataSignal.tp2,
                                    style: TextStyle(
                                      fontFamily: "Nunito-ExtraBold",
                                      fontSize: 25.ssp,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  if (dataSignal.statusfloating ==
                                      2) // 2 = signal hit TP 2
                                    Container(
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: Icon(
                                        FeatherIcons.checkCircle,
                                        size: 25.w,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                ],
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
                                style: textTitle,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    dataSignal.tp3,
                                    style: TextStyle(
                                      fontFamily: "Nunito-ExtraBold",
                                      fontSize: 25.ssp,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  if (dataSignal.statusfloating ==
                                      3) // 3 = signal hit TP 3
                                    Container(
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: Icon(
                                        FeatherIcons.checkCircle,
                                        size: 25.w,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                ],
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
                              Row(
                                children: <Widget>[
                                  Text(
                                    dataSignal.sl,
                                    style: TextStyle(
                                      fontFamily: "Nunito-ExtraBold",
                                      fontSize: 25.ssp,
                                      color: Colors.red,
                                    ),
                                  ),
                                  if (dataSignal.statusfloating ==
                                      -1) // -1 = signal hit SL -1
                                    Container(
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: Icon(
                                        FeatherIcons.checkCircle,
                                        size: 25.w,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
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
                                (dataSignal.result.contains("-"))
                                    ? dataSignal.result
                                    : (dataSignal.result == "0.0")
                                        ? "-"
                                        : "+" + dataSignal.result,
                                style: TextStyle(
                                  fontFamily: "Nunito-ExtraBold",
                                  fontSize: 25.ssp,
                                  color: (dataSignal.result.contains("-"))
                                      ? Colors.red
                                      : (dataSignal.result == "0.0")
                                          ? kTextColor
                                          : kPrimaryColor,
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
                                (dataSignal.close.contains("0.000"))
                                    ? "-"
                                    : dataSignal.close,
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
                                dataSignal.timeclose
                                    .toString()
                                    .substring(0, 19),
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
      },
    );
  }
}
