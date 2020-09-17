import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/analysis_detail_signal_model.dart';

class DetailAnalysisSignalPage extends StatefulWidget {
  final String pairID;
  final String pairName;
  const DetailAnalysisSignalPage(this.pairID, this.pairName);

  DetailAnalysisSignalPageState createState() =>
      DetailAnalysisSignalPageState();
}

class DetailAnalysisSignalPageState extends State<DetailAnalysisSignalPage> {
  List<Price> priceList = [];
  List<Bb> bolingerBandList = [];
  List<Rsi> rsiList = [];
  List<Ichimoku> ichimokuList = [];
  List<Ma> maList = [];
  List<Envelope> envelopeList = [];
  List<Stochastic> stochasticList = [];
  List<Wpr> wprList = [];
  List<Adr> adrList = [];
  SumSignal sumSignal;

  bool m5Clicked = false;
  bool m15Clicked = false;
  bool m30Clicked = false;
  bool h1Clicked = true;
  bool h4Clicked = false;
  bool d1Clicked = false;

  String tf = "60";
  String summary = "";

  Future getAnalysisSignal() async {
    final String baseUrl = kBaseUrlApi + "analisys/DetailSignal";
    final response =
        await http.post("$baseUrl", body: {"pair": widget.pairID, "TF": tf});
    if (response.statusCode == 200) {
      return DetailAnalysisSignal.fromJson(response.body);
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
  var textStyleTitleValue =
      TextStyle(fontFamily: "Nunito", fontSize: 22.ssp, color: kTextLightColor);
  var textStyleValue =
      TextStyle(fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kTextColor);
  var boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.w),
    boxShadow: [
      BoxShadow(
        offset: Offset(8.w, 21.w),
        blurRadius: 53.w,
        color: Colors.black.withOpacity(0.05),
      ),
    ],
  );

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
            buildTimeFrameLayout(),
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
                    priceList = snapshot.data.data.price;
                    envelopeList = snapshot.data.data.indicator.envelopes;
                    stochasticList = snapshot.data.data.indicator.stochastic;
                    wprList = snapshot.data.data.indicator.wpr;
                    adrList = snapshot.data.data.adr;
                    sumSignal = snapshot.data.data.indicator.sumSignal;
                    summary = sumSignal.sumAll;
                    return buildMainLayout();
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

  Column buildMainLayout() {
    return Column(
      children: <Widget>[
        (priceList.length != 0) ? buildContainerPrice() : Container(),

        (adrList.length != 0) ? buildContainerADR() : Container(),
        buildSummaryIndicator(),
        (maList.length != 0)
            ? buildMasterExpanded(
                "Moving Averages", sumSignal.ma, buildMovingAverages())
            : Container(),

        (bolingerBandList.length != 0)
            ? buildMasterExpanded(
                "Bolinger Bands", sumSignal.bb, buildBolingerBands())
            : Container(),

        (rsiList.length != 0)
            ? buildMasterExpanded("RSI", sumSignal.rsi, buildRSI())
            : Container(),

        (envelopeList.length != 0)
            ? buildMasterExpanded(
                "Envelopes", sumSignal.envelopes, buildEnvelopes())
            : Container(),

        (ichimokuList.length != 0)
            ? buildMasterExpanded("Ichimoku",
                ichimokuList[0].iMokuSignal.toString(), buildIchimoku())
            : Container(),

        (stochasticList.length != 0)
            ? buildMasterExpanded("Stochastic",
                stochasticList[0].iStochsigStoch.toString(), buildStochastic())
            : Container(),

        (wprList.length != 0)
            ? buildMasterExpanded(
                "William`s Percent Range", sumSignal.wpr, buildWPR())
            : Container(),

        SizedBox(height: 20.w),
        // buildMasterExpanded("PivotPoint", "", buildPivotPoint()),
        // SizedBox(height: 20.w),
      ],
    );
  }

  Container buildSummaryIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w, left: 20.w, right: 20.w),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Analysis Indicator",
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
                "Summary Indicator : ",
                style: TextStyle(
                  fontFamily: "Nunito-Bold",
                  fontSize: 25.ssp,
                  color: kTextColor,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                summary == "0" ? "BUY" : summary == "1" ? "SELL" : "NEUTRAL",
                style: summary == "0"
                    ? textStyleBuy
                    : summary == "1" ? textStyleSell : textStylePrice,
              ),
              // buildIconDirection(int.parse(summary)),
            ],
          ),
        ],
      ),
      decoration: boxDecoration,
    );
  }

  //---------------------- master build expands layout -----------------------
  ExpandableNotifier buildMasterExpanded(
      String _titleExpands, String _summary, Container _indicator) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Card(
          //clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black.withOpacity(0.2),
          elevation: 25.w,
          margin: EdgeInsets.only(bottom: 20.w, left: 20.w, right: 20.w),
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
                                _summary == "0"
                                    ? "BUY"
                                    : _summary == "1" ? "SELL" : "NEUTRAL",
                                style: _summary == "0"
                                    ? textStyleBuy
                                    : _summary == "1"
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

  // -------------------- build envelopes ------------------------------------
  Container buildWPR() {
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
            itemCount: wprList.length,
            itemBuilder: (context, index) {
              Wpr wpr = wprList[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Divider(thickness: 3.w, color: Colors.grey[100]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        buildPeriod(wpr.iWprPeriod.toString()),
                        buildPrice(wpr.iWprValue),
                        buildCommandSignal(wpr.iWprSignal),
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
  // -------------------- end build envelopes --------------------------------

  // ------------------- build stochastic ------------------------------------
  Container buildStochastic() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildHeader("Value"),
              buildHeader("Signal Value"),
              buildHeader("Signal"),
            ],
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: stochasticList.length,
            itemBuilder: (context, index) {
              Stochastic stochastic = stochasticList[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Divider(thickness: 3.w, color: Colors.grey[100]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        buildPeriod(stochastic.iStochValue),
                        buildPrice(stochastic.iStochsigValue.toString()),
                        buildCommandSignal(stochastic.iStochsigStoch),
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
  // ------------------- end build stochastic --------------------------------

  // -------------------- build envelopes ------------------------------------
  Container buildEnvelopes() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildHeader("Period"),
              buildHeader("Lower"),
              buildHeader("Upper"),
              buildHeader("Signal"),
            ],
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: envelopeList.length,
            itemBuilder: (context, index) {
              Envelope envelopes = envelopeList[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Divider(thickness: 3.w, color: Colors.grey[100]),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        buildPeriod(envelopes.iEnvPeriod.toString()),
                        buildPrice(envelopes.iEnvLower),
                        buildPrice(envelopes.iEnvUpper),
                        buildCommandSignal(envelopes.iEnvSignal),
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
  // -------------------- end build envelopes --------------------------------

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
                        buildPeriod(bolingerBands.iBbPeriod.toString()),
                        buildPrice(bolingerBands.iBbTop.toString()),
                        buildPrice(bolingerBands.iBbMid.toString()),
                        buildPrice(bolingerBands.iBbBottom.toString()),
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
                  //   getValPrice(
                  //       widget.pairName, ichimokuList[0].iMokuTenkan.toString()),
                  style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Kijun-sen (26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuKijun.toString(),
                  // getValPrice(
                  //     widget.pairName, ichimokuList[0].iMokuKijun.toString()),
                  style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("SenkouSpanA (26)", style: textStylePrice),
              Text(
                ichimokuList[0].iMokuSsa.toString(),
                // getValPrice(
                //     widget.pairName, ichimokuList[0].iMokuSsa.toString()),
                style: textStylePrice,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("SenkouSpanB (52, 26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuSsb.toString(),
                  // getValPrice(
                  //     widget.pairName, ichimokuList[0].iMokuSsb.toString()),
                  style: textStylePrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Chikouspan (26)", style: textStylePrice),
              Text(ichimokuList[0].iMokuChikou.toString(),
                  // getValPrice(
                  //     widget.pairName, ichimokuList[0].iMokuChikou.toString()),
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
                        buildPeriod(rsi.iRsiPeriod.toString()),
                        buildPrice(rsi.iRsiValue.toString()),
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

  Expanded buildPeriod(String period) {
    return Expanded(
      child: Container(
        child: Text(
          period,
          style: textStylePrice,
        ),
      ),
    );
  }

  Expanded buildPrice(String price) {
    return Expanded(
      child: Container(
        child: Text(
          price,
          //getValPrice(widget.pairName, price),
          style: textStylePrice,
        ),
      ),
    );
  }

  Expanded buildCommandSignal(String _signal) {
    return Expanded(
      child: Container(
        child: Text(
          _signal == '0' ? "BUY" : _signal == '1' ? "SELL" : "NEUTRAL",
          style: _signal == '0'
              ? textStyleBuy
              : _signal == '1' ? textStyleSell : textStylePrice,
        ),
      ),
    );
  }
  //----------------------- end bolinger bands ---------------------------

  //------------------------- buildlist MA -------------------------------
  buildMovingAverages() {
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
                        buildPeriod(ma.iMaPeriod.toString()),
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

  Text buildSignalMA(String _signal) {
    return Text(
      _signal == '0' ? "BUY" : _signal == '1' ? "SELL" : "NEUTRAL",
      style: _signal == '0'
          ? textStyleBuy
          : _signal == '1' ? textStyleSell : textStylePrice,
    );
  }

  Text buildMethodMA(String _value) {
    return Text(
      _value,
      //getValPrice(widget.pairName, _value),
      style: textStylePrice,
    );
  }

  //------------------------ end buildlist MA ----------------------------

  //-------------------------- build Time Frame  ------

  Container buildTimeFrameLayout() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10.w, left: 10, bottom: 10.w),
            decoration: boxDecoration,
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
                      "TimeFrame : ",
                      style: TextStyle(
                        fontFamily: "Nunito-Bold",
                        fontSize: 25.ssp,
                        color: kTextColor,
                      ),
                    ),
                    // Text(
                    //   summary == "0"
                    //       ? "BUY"
                    //       : summary == "1" ? "SELL" : "NEUTRAL",
                    //   style: summary == "0"
                    //       ? textStyleBuy
                    //       : summary == "1" ? textStyleSell : textStylePrice,
                    // ),
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
                tf = "5";
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
                tf = "15";
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
                tf = "30";
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
                tf = "60";
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
                tf = "240";
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
                tf = "1440";
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
    return Container(
      margin: EdgeInsets.only(bottom: 20.w, left: 20.w, right: 20.w),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            decoration: boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
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
                          "Open : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          priceList[0].iPriceOpen.toString(),
                          // getValPrice(widget.pairName,
                          //     priceList[0].iPriceOpen.toString()),
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
                          priceList[0].iPriceLow.toString(),
                          // getValPrice(widget.pairName,
                          //     priceList[0].iPriceLow.toString()),
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
                          priceList[0].iPriceClose.toString(),
                          // getValPrice(widget.pairName,
                          //     priceList[0].iPriceClose.toString()),
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
                          priceList[0].iPriceHigh.toString(),
                          //getValPrice(widget.pairName,
                          // priceList[0].iPriceHigh.toString()),
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

  // -------------------------------- CONTENT ADR ------------------------------
  Container buildContainerADR() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w, left: 20.w, right: 20.w),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            decoration: boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                Text(
                  "Average Dialy Range",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    fontSize: 25.ssp,
                    color: kTextLightColor,
                  ),
                ),
                //     Text(
                //       adrList[0].iAdrRange,
                //       style: TextStyle(
                //         fontFamily: "Nunito-Bold",
                //         fontSize: 30.ssp,
                //         color: kTextColor,
                //       ),
                //     ),
                //   ],
                // ),
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
                          "Today Range  : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          adrList[0].iAdrRange,
                          //getValPrice(widget.pairName, adrList[0].iAdrRange),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Percentage : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          "(" + adrList[0].iAdrPersen + "%)",
                          style: textStyleValue,
                        ),
                        SizedBox(width: 10.w),
                        buildIconDirection(adrList[0].iAdrDirection),
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
                          "Upper Limit    : ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          adrList[0].iAdrUpper,
                          //getValPrice(widget.pairName, adrList[0].iAdrUpper),
                          style: textStyleValue,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Lower Limit  :          ",
                          style: textStyleTitleValue,
                        ),
                        Text(
                          adrList[0].iAdrLower,
                          //getValPrice(widget.pairName, adrList[0].iAdrLower),
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
  //--------------------------------- END CONTENT ADR --------------------------

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
        widget.pairName,
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }

  Icon buildIconDirection(String adrDirection) {
    if (adrDirection == '0') {
      return Icon(
        FeatherIcons.trendingUp,
        color: kPrimaryColor,
        size: 30.w,
      );
    } else {
      return Icon(
        FeatherIcons.trendingDown,
        color: Colors.red,
        size: 30.w,
      );
    }
  }
}
