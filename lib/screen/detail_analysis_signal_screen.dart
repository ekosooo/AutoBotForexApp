import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/analysis_signal_model.dart';

// Future<AnalysisSignal> getAnalysisSignal() async {
//   final String baseUrl = "http://192.168.100.5:8000/api/analysis/signal";
//   final response =
//       await http.post("$baseUrl", body: {"pair": "EURUSD", "TF": "240"});
//   if (response.statusCode == 200) {
//     return AnalysisSignal.fromJson(response.body);
//   } else {
//     return null;
//   }
// }

class DetailAnalysisSignalPage extends StatefulWidget {
  final String pair;
  const DetailAnalysisSignalPage(this.pair);

  DetailAnalysisSignalPageState createState() =>
      DetailAnalysisSignalPageState();
}

class DetailAnalysisSignalPageState extends State<DetailAnalysisSignalPage> {
  List<Bb> bolingerBandList = [];
  List<Rsi> rsiList = [];
  List<Ichimoku> ichimokuList = [];
  List<Ma> maList = [];
  Price price;

  bool m5Clicked = false;
  bool m15Clicked = false;
  bool m30Clicked = false;
  bool h1Clicked = true;
  bool h4Clicked = false;
  bool d1Clicked = false;

  Future getAnalysisSignal() async {
    final String baseUrl = "http://192.168.100.5:8000/api/analysis/signal";
    final response =
        await http.post("$baseUrl", body: {"pair": widget.pair, "TF": "240"});
    if (response.statusCode == 200) {
      return AnalysisSignal.fromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  Future refreshData() async {
    bolingerBandList.clear();
    rsiList.clear();
    ichimokuList.clear();
    maList.clear();
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  var textStyleHeaderTable = TextStyle(
      fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kTextLightColor);
  var textStylePrice =
      TextStyle(fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kTextColor);
  var textStyleSell =
      TextStyle(fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: Colors.red);
  var textStyleBuy = TextStyle(
      fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kPrimaryColor);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: refreshData,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            buildSummaryAndTimeFrame(),
            SizedBox(height: 20.w),
            Container(
              child: FutureBuilder(
                future: getAnalysisSignal(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        child: Text("Terjadi Kesalahan"),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    bolingerBandList = snapshot.data.data.indicator.bb;
                    rsiList = snapshot.data.data.indicator.rsi;
                    ichimokuList = snapshot.data.data.indicator.ichimoku;
                    maList = snapshot.data.data.indicator.ma;
                    price = snapshot.data.data.price;
                    return buildMasterIndicator();
                  } else {
                    return Container(
                      margin: EdgeInsets.only(top: 40.w),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildMasterIndicator() {
    return Column(
      children: <Widget>[
        buildContainerPrice(),
        SizedBox(height: 20.w),
        buildMasterExpanded("Moving Averages", 0, buildMovingAverages()),
        SizedBox(height: 20.w),
        buildMasterExpanded("Bolinger Bands", 0, buildBolingerBands()),
        SizedBox(height: 20.w),
        buildMasterExpanded("RSI", -1, buildRSI()),
        SizedBox(height: 20.w),
        buildMasterExpanded(
            "Ichimoku", ichimokuList[0].iMokuSignal, buildIchimoku()),
        SizedBox(height: 20.w),
        // buildMasterExpanded("PivotPoint", "", buildPivotPoint()),
        // SizedBox(height: 20.w),
      ],
    );
  }

  //---------------------- master build expands layout -----------------------
  ExpandableNotifier buildMasterExpanded(
      String _titleExpands, int _summary, Container _indicator) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Card(
          //clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black.withOpacity(0.2),
          elevation: 25.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                            _titleExpands,
                            style: TextStyle(
                              fontFamily: "Nunito-Bold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                _summary == 0
                                    ? "BUY"
                                    : _summary == 1 ? "SELL" : "NEUTRAL",
                                style: _summary == 0
                                    ? textStyleBuy
                                    : _summary == 1
                                        ? textStyleSell
                                        : textStylePrice,
                              ),
                              ExpandableIcon(
                                theme: const ExpandableThemeData(
                                  expandIcon: Icons.arrow_right,
                                  collapseIcon: Icons.arrow_drop_down,
                                  iconColor: kPrimaryColor,
                                  iconSize: 28.0,
                                  iconRotationAngle: math.pi / 2,
                                  iconPadding: EdgeInsets.only(right: 5),
                                  hasIcon: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4.w),
                    ],
                  ),
                ),
                expanded: _indicator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //---------------------- end master build expands layout -------------------

  //--------------------- build bolinger bands -------------------------------
  Container buildBolingerBands() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildHeader("Period"),
              buildHeader("Top"),
              buildHeader("Middle"),
              buildHeader("Bottom"),
              buildHeader("Signal"),
            ],
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: bolingerBandList.length,
            itemBuilder: (context, index) {
              Bb bolingerBands = bolingerBandList[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Divider(thickness: 3.w, color: Colors.grey[100]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        buildPeriodAndPrice(bolingerBands.iBbPeriod.toString()),
                        buildPeriodAndPrice(bolingerBands.iBbTop.toString()),
                        buildPeriodAndPrice(bolingerBands.iBbMid.toString()),
                        buildPeriodAndPrice(bolingerBands.iBbBottom.toString()),
                        buildCommandSignal(bolingerBands.iBbSignal),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  //--------------------- end build bolinger bands ---------------------------

  //--------------------- build bolinger bands -------------------------------
  Container buildIchimoku() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: <Widget>[
          Divider(thickness: 3.w, color: Colors.grey[100]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Tenkan-sen (9)", style: textStylePrice),
              Text(ichimokuList[0].iMokuTenkan.toString(),
                  style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Kijun-sen (26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuKijun.toString(),
                  style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("SenkouSpanA (26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuSsa.toString(), style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("SenkouSpanB (52, 26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuSsb.toString(), style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Chikouspan (26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuChikou.toString(),
                  style: textStylePrice),
            ],
          ),
        ],
      ),
    );
  }
  //--------------------- end build bolinger bands ---------------------------

  //--------------------- build bolinger bands -------------------------------
  Container buildRSI() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildHeader("Period"),
              buildHeader("Value"),
              buildHeader("Signal"),
            ],
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: rsiList.length,
            itemBuilder: (context, index) {
              Rsi rsi = rsiList[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Divider(thickness: 3.w, color: Colors.grey[100]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        buildPeriodAndPrice(rsi.iRsiPeriod.toString()),
                        buildPeriodAndPrice(rsi.iRsiValue.toString()),
                        buildCommandSignal(rsi.iRsiSignal),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  //--------------------- end build bolinger bands ---------------------------

  Expanded buildHeader(String _titleHeader) {
    return Expanded(
      child: Container(
        child: Text(
          _titleHeader,
          style: textStyleHeaderTable,
        ),
      ),
    );
  }

  Expanded buildPeriodAndPrice(String _price) {
    return Expanded(
      child: Container(
        child: Text(
          _price,
          style: textStylePrice,
        ),
      ),
    );
  }

  Expanded buildCommandSignal(int _signal) {
    return Expanded(
      child: Container(
        child: Text(
          _signal == 0 ? "BUY" : _signal == 1 ? "SELL" : "NEUTRAL",
          style: _signal == 0
              ? textStyleBuy
              : _signal == 1 ? textStyleSell : textStylePrice,
        ),
      ),
    );
  }
  //----------------------- end bolinger bands ---------------------------

  //------------------------- buildlist MA -------------------------------
  Container buildMovingAverages() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Period",
                  style: textStyleHeaderTable,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Simple",
                    style: textStyleHeaderTable,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Smoothed",
                    style: textStyleHeaderTable,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Exponential",
                    style: textStyleHeaderTable,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "LW",
                    style: textStyleHeaderTable,
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: maList.length,
            itemBuilder: (context, index) {
              Ma ma = maList[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Divider(thickness: 3.w, color: Colors.grey[100]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        buildPeriodAndPrice(ma.iMaPeriod),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildMethodMA(ma.iMaSimple),
                              buildSignalMA(ma.iMaSigSimple),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              buildMethodMA(ma.iMaSmoothed),
                              buildSignalMA(ma.iMaSigSmoothed),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              buildMethodMA(ma.iMaExponential),
                              buildSignalMA(ma.iMaSigExponential),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              buildMethodMA(ma.iMalw),
                              buildSignalMA(ma.iMaSigLw),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Text buildSignalMA(int _signal) {
    return Text(
      _signal == 0 ? "BUY" : _signal == 1 ? "SELL" : "NEUTRAL",
      style: _signal == 0
          ? textStyleBuy
          : _signal == 1 ? textStyleSell : textStylePrice,
    );
  }

  Text buildMethodMA(double _value) {
    return Text(
      _value.toString(),
      style: textStylePrice,
    );
  }

  //------------------------ end buildlist MA ----------------------------

  //-------------------------- build Time Frame  ------

  Container buildSummaryAndTimeFrame() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10.w, left: 10, bottom: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  offset: Offset(8.w, 21.w),
                  blurRadius: 53.w,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Technical Analysis",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    fontSize: 25.ssp,
                    color: kTextLightColor,
                  ),
                ),
                Divider(
                  thickness: 3.w,
                  color: Colors.grey[100],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Summary : ",
                      style: TextStyle(
                        fontFamily: "Nunito-Bold",
                        fontSize: 25.ssp,
                        color: kTextColor,
                      ),
                    ),
                    Text(
                      "BUY",
                      style: TextStyle(
                        fontFamily: "Nunito-Bold",
                        fontSize: 25.ssp,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    buildTimeFrame(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildTimeFrame() {
    var boxNotSelected = BoxDecoration(
      border: Border.all(
        width: 3.w,
        color: Colors.grey[100],
      ),
      borderRadius: BorderRadius.circular(6.w),
    );
    var boxSelected = BoxDecoration(
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(6.w),
    );
    var textStyleNotSelected = TextStyle(
      fontFamily: "Nunito-Bold",
      color: kTextColor,
      fontSize: 25.ssp,
    );
    var textStyleSelected = TextStyle(
      fontFamily: "Nunito-Bold",
      color: Colors.white,
      fontSize: 25.ssp,
    );
    return Expanded(
      child: Container(
        height: 45.w,
        child: ListView(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  if (m5Clicked) {
                    m5Clicked = false;
                  } else {
                    m5Clicked = true;
                    m15Clicked = false;
                    m30Clicked = false;
                    h1Clicked = false;
                    h4Clicked = false;
                    d1Clicked = false;
                  }
                });
              },
              child: Container(
                width: 80.w,
                child: Center(
                  child: Text(
                    "M5",
                    style:
                        (m5Clicked) ? textStyleSelected : textStyleNotSelected,
                  ),
                ),
                decoration: (m5Clicked) ? boxSelected : boxNotSelected,
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (m15Clicked) {
                    m15Clicked = false;
                  } else {
                    m5Clicked = false;
                    m15Clicked = true;
                    m30Clicked = false;
                    h1Clicked = false;
                    h4Clicked = false;
                    d1Clicked = false;
                  }
                });
              },
              child: Container(
                width: 80.w,
                child: Center(
                  child: Text(
                    "M15",
                    style:
                        (m15Clicked) ? textStyleSelected : textStyleNotSelected,
                  ),
                ),
                decoration: (m15Clicked) ? boxSelected : boxNotSelected,
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (m30Clicked) {
                    m30Clicked = false;
                  } else {
                    m5Clicked = false;
                    m15Clicked = false;
                    m30Clicked = true;
                    h1Clicked = false;
                    h4Clicked = false;
                    d1Clicked = false;
                  }
                });
              },
              child: Container(
                width: 80.w,
                child: Center(
                  child: Text(
                    "M30",
                    style:
                        (m30Clicked) ? textStyleSelected : textStyleNotSelected,
                  ),
                ),
                decoration: (m30Clicked) ? boxSelected : boxNotSelected,
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (h1Clicked) {
                    h1Clicked = false;
                  } else {
                    m5Clicked = false;
                    m15Clicked = false;
                    m30Clicked = false;
                    h1Clicked = true;
                    h4Clicked = false;
                    d1Clicked = false;
                  }
                });
              },
              child: Container(
                width: 80.w,
                child: Center(
                  child: Text(
                    "H1",
                    style:
                        (h1Clicked) ? textStyleSelected : textStyleNotSelected,
                  ),
                ),
                decoration: (h1Clicked) ? boxSelected : boxNotSelected,
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (h4Clicked) {
                    h4Clicked = false;
                  } else {
                    m5Clicked = false;
                    m15Clicked = false;
                    m30Clicked = false;
                    h1Clicked = false;
                    h4Clicked = true;
                    d1Clicked = false;
                  }
                });
              },
              child: Container(
                width: 80.w,
                child: Center(
                  child: Text(
                    "H4",
                    style:
                        (h4Clicked) ? textStyleSelected : textStyleNotSelected,
                  ),
                ),
                decoration: (h4Clicked) ? boxSelected : boxNotSelected,
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (d1Clicked) {
                    d1Clicked = false;
                  } else {
                    m5Clicked = false;
                    m15Clicked = false;
                    m30Clicked = false;
                    h1Clicked = false;
                    h4Clicked = false;
                    d1Clicked = true;
                  }
                });
              },
              child: Container(
                width: 80.w,
                child: Center(
                  child: Text(
                    "D1",
                    style:
                        (d1Clicked) ? textStyleSelected : textStyleNotSelected,
                  ),
                ),
                decoration: (d1Clicked) ? boxSelected : boxNotSelected,
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  //--------------------------- END TIME FRAME--------------------------------

//----------------------------- CONTENT PRICE --------------------------------

  Container buildContainerPrice() {
    var textStyleTitleValue = TextStyle(
      fontFamily: "Nunito",
      fontSize: 22.ssp,
      color: kTextMediumColor,
    );
    var textStyleValue = TextStyle(
      fontFamily: "Nunito-Bold",
      fontSize: 22.ssp,
      color: kTextColor,
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  offset: Offset(8.w, 21.w),
                  blurRadius: 53.w,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Price Market",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    fontSize: 25.ssp,
                    color: kTextLightColor,
                  ),
                ),
                Divider(
                  thickness: 3.w,
                  color: Colors.grey[100],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Now  : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          price.now.toString(),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "ADR  : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          "-0.004(-0.04%)",
                          style: textStyleValue,
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          FeatherIcons.trendingDown,
                          color: Colors.red,
                          size: 30.w,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Open : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          price.open.toString(),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Low  : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          price.low.toString(),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Close : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          price.close.toString(),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "High  : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          price.high.toString(),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //----------------------------------END CONTENT PRICE ------------------------

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
        },
      ),
      title: Text(
        widget.pair,
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
