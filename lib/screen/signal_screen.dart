import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:signalforex/model/summary_model.dart';
import 'package:signalforex/widget/no_data_record.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/model/signal_model.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:showcaseview/showcaseview.dart';

class SignalPage extends StatefulWidget {
  final selectedPage;
  const SignalPage({Key key, this.selectedPage});
  SignalPageState createState() => SignalPageState();
}

class SignalPageState extends State<SignalPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int valueDropDownHistory = 0;
  String dateStartHistory;
  String dateEndHistory;
  int valueDropDownSummary = 1;
  String dateStartSummary;
  String dateEndSummary;
  DataSumSignal dataSumSignal;
  DateTime timeCurrent;

  //---------- variabel showcaseview --------
  BuildContext myContext;

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  //---------- end variabel showcaseview --------

  @override
  void initState() {
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.selectedPage);

    //---- history -------
    timeCurrent = DateTime.now();
    // dateStartHistory =
    //     timeCurrent.subtract(Duration(days: 7)).toString().substring(0, 10);
    // dateEndHistory = timeCurrent.toString().substring(0, 10);
    //to day
    dateStartHistory =
        timeCurrent.toString().substring(0, 10); //hanya ambil tahun bln dan tgl
    dateEndHistory = timeCurrent.toString().substring(0, 10);

    //--- summary ---
    dateStartSummary =
        timeCurrent.subtract(Duration(days: 7)).toString().substring(0, 10);
    dateEndSummary = timeCurrent.toString().substring(0, 10);
    // //------- init showcaseview -------
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(
    //       Duration(seconds: 1),
    //       () =>
    //           ShowCaseWidget.of(myContext).startShowCase([_one, _two, _three]));
    // });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future getSignal() async {
    final String baseUrl = kBaseUrlApi + "signal/list";
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return Signal.fromJson(response.body);
    } else {
      throw Exception('Fail load data');
    }
  }

  Future getHistory() async {
    final String baseUrl = kBaseUrlApi + "signal/history";
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

  Future getSummary() async {
    final String baseUrl = kBaseUrlApi + "signal/summary";
    final response = await http.post("$baseUrl", body: {
      'dateStart': dateStartSummary,
      'dateEnd': dateEndSummary,
    });
    if (response.statusCode == 200) {
      return SummarySignals.fromJson(response.body);
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
    // return ShowCaseWidget(
    //     builder: (Builder(builder: (context) {
    //   myContext = context;
    return Scaffold(
      appBar: buildAppBar(context),
      body: TabBarView(
        controller: _tabController,
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
                      child: SomethingWrong(textColor: 'black'),
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
          buildHistorySignal(),
          //-------------------------------------------------

          // ---------------------- summary ------------------
          buildSummary(),
          //--------------------------------------------------
        ],
      ),
    );
    //})));
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
    var textStyle = TextStyle(
      fontFamily: "Nunito-ExtraBold",
      fontSize: 25.ssp,
      color: kTextColor,
    );
    return TabBar(
      indicatorColor: kPrimaryColor,
      tabs: [
        // Showcase(
        //   key: _one,
        //   description: 'click this',
        //   child:
        Tab(
          child: Container(
            child: Center(
              child: Text(
                "Signal",
                style: textStyle,
              ),
            ),
          ),
        ),
        //),
        // Showcase(
        //   key: _two,
        //   description: 'click this',
        //   child:
        Tab(
          child: Container(
            child: Center(
              child: Text(
                "History",
                style: textStyle,
              ),
            ),
          ),
        ),
        //),
        // Showcase(
        //   key: _three,
        //   description: 'click this',
        //   child:
        Tab(
          child: Container(
            margin: EdgeInsets.only(left: 6.w, right: 6.w),
            child: Center(
              child: Text(
                "Summary",
                style: textStyle,
              ),
            ),
          ),
        ),
        //),
      ],
      controller: _tabController,
    );
  }

  //--------- History Signal ----------------
  buildHistorySignal() {
    return RefreshIndicator(
      onRefresh: refreshData,
      color: kPrimaryColor,
      child: SingleChildScrollView(
        child: Column(
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
                          "Today",
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
                        dateEndHistory =
                            timeCurrent.toString().substring(0, 10);
                      } else if (valueDropDownHistory == 1) {
                        //last week
                        dateStartHistory = timeCurrent
                            .subtract(Duration(days: 7))
                            .toString()
                            .substring(0, 10);
                        dateEndHistory =
                            timeCurrent.toString().substring(0, 10);
                      } else if (valueDropDownHistory == 2) {
                        //last month
                        dateStartHistory =
                            timeCurrent.subtract(Duration(days: 30)).toString();
                        dateEndHistory =
                            timeCurrent.toString().substring(0, 10);
                      } else if (valueDropDownHistory == 3) {
                        //last 3 month
                        dateStartHistory =
                            timeCurrent.subtract(Duration(days: 90)).toString();
                        dateEndHistory =
                            timeCurrent.toString().substring(0, 10);
                      }
                    },
                  ),
                ],
              ),
            ),

            //---------future

            FutureBuilder(
              future: getHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: SomethingWrong(textColor: 'black'),
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
          ],
        ),
      ),
    );
  }

  //----------- summary -------
  buildSummary() {
    return RefreshIndicator(
      onRefresh: refreshData,
      color: kPrimaryColor,
      child: SingleChildScrollView(
        child: Container(
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
                      value: 0,
                      child: Text(
                        "Today",
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
                      valueDropDownSummary = value;
                    });
                    // print(_valueDropDownHistory);
                    if (valueDropDownSummary == 0) {
                      //to day
                      dateStartSummary = timeCurrent
                          .toString()
                          .substring(0, 10); //hanya ambil tahun bln dan tgl
                      dateEndSummary = timeCurrent.toString().substring(0, 10);
                    } else if (valueDropDownSummary == 1) {
                      //last week
                      dateStartSummary = timeCurrent
                          .subtract(Duration(days: 7))
                          .toString()
                          .substring(0, 10);
                      dateEndSummary = timeCurrent.toString().substring(0, 10);
                    } else if (valueDropDownSummary == 2) {
                      //last month
                      dateStartSummary =
                          timeCurrent.subtract(Duration(days: 30)).toString();
                      dateEndSummary = timeCurrent.toString().substring(0, 10);
                    } else if (valueDropDownSummary == 3) {
                      //last 3 month
                      dateStartSummary =
                          timeCurrent.subtract(Duration(days: 90)).toString();
                      dateEndSummary = timeCurrent.toString().substring(0, 10);
                    }
                  },
                ),
              ),

              //----------- Detail profit / lose ----------------
              FutureBuilder(
                future: getSummary(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: NoDataRecord(),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return buildSummaryList(snapshot.data.data.dataSignal,
                        snapshot.data.data.dataSummary);
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
            ],
          ),
        ),
      ),
    );
  }
}

buildSummaryList(List<DataSumSignal> dataSumSignalList, DataSummary summary) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 60.w),
      Align(
        alignment: Alignment.center,
        child: Text(
          summary.sumDifference + " pips",
          style: TextStyle(
            fontFamily: 'Nunito-Bold',
            fontSize: 60.ssp,
            color: (summary.sumDifference.contains('-'))
                ? Colors.red
                : kPrimaryColor,
          ),
        ),
      ),

      //-------------- Profit loss ---------------------
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
                      "+" + summary.sumProfit + " pips",
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

            //--------------loss --------------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Loss',
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
                      summary.sumLoss + " pips",
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
      SizedBox(height: 40.w),
      Text(
        "Detail",
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 25.ssp,
          color: kTextLightColor,
        ),
      ),

      //----------- list detail pair ---------
      (dataSumSignalList.length == 0)
          ? NoDataRecord()
          : ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataSumSignalList.length,
              itemBuilder: (BuildContext contex, int index) {
                DataSumSignal dataSumSignal = dataSumSignalList[index];
                return Column(
                  children: <Widget>[
                    SizedBox(height: 8.w),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.w),
                      padding: EdgeInsets.all(15.w),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SvgPicture.network(
                                kMasterUrl + "img/pairs/" + dataSumSignal.img,
                                width: 75.w,
                                height: 35.w,
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    dataSumSignal.pairname,
                                    style: TextStyle(
                                      fontFamily: "Nunito-ExtraBold",
                                      fontSize: 25.ssp,
                                      color: kTextColor,
                                    ),
                                  ),
                                  Text(
                                    dataSumSignal.desc,
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "+" + dataSumSignal.sumProfit + " pips",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 22.ssp,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Text(
                                dataSumSignal.sumLoss + " pips",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 22.ssp,
                                  color: Colors.grey[400],
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
                );
              },
            ),
    ],
  );
}

buildSignalList(List<DataSignal> dataSignalList) {
  if (dataSignalList.length == 0) {
    return NoDataRecord();
  } else {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
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
              shadowColor: Colors.black.withOpacity(0.1),
              elevation: 35.w,
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
                                (dataSignal.status == "8") //8 = code active
                                    ? "Active"
                                    : "Expired",
                                style: TextStyle(
                                  fontFamily: "Nunito-Bold",
                                  fontSize: 20.ssp,
                                  color: (dataSignal.status == "8")
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
                                      "1") // 1 = signal hit TP 1
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
                                      "2") // 2 = signal hit TP 2
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
                                      "3") // 3 = signal hit TP 3
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
                                      "-1") // -1 = signal hit SL -1
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
