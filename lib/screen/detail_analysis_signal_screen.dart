import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forex_app/constants.dart';
import 'package:expandable/expandable.dart';

class DetailAnalysisSignalPage extends StatefulWidget {
  DetailAnalysisSignalPageState createState() =>
      DetailAnalysisSignalPageState();
}

class DetailAnalysisSignalPageState extends State<DetailAnalysisSignalPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          buildContainerPrice(),
          SizedBox(height: 20.w),
          buildSummaryAndTimeFrame(),
          SizedBox(height: 20.w),
          buildContainerMAandIndicators(),
          SizedBox(height: 20.w),
          buildListViewMovingAverages(),
        ],
      ),
    );
  }

  //------------------------- buildlist MA -------------------------------
  ExpandableNotifier buildListViewMovingAverages() {
    var textStyleHeaderTable = TextStyle(
        fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kTextLightColor);

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
                            "Moving Averages",
                            style: TextStyle(
                              fontFamily: "Nunito-Bold",
                              fontSize: 25.ssp,
                              color: kTextColor,
                            ),
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
                      SizedBox(height: 4.w),
                    ],
                  ),
                ),
                expanded: Container(
                  margin: EdgeInsets.only(bottom: 15.w),
                  color: Colors.white,
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text("Period", style: textStyleHeaderTable)),
                      DataColumn(
                          label: Text("Simple", style: textStyleHeaderTable)),
                      DataColumn(
                          label:
                              Text("Exponential", style: textStyleHeaderTable)),
                      DataColumn(
                          label: Text("Smoothed", style: textStyleHeaderTable)),
                    ],
                    rows: <DataRow>[
                      buildDataRowTableMA("MA5", "1.1811", "SELL", "1.1811",
                          "SELL", "1.1811", "SELL"),
                      buildDataRowTableMA("MA10", "1.1811", "SELL", "1.1811",
                          "SELL", "1.1811", "SELL"),
                      buildDataRowTableMA("MA20", "1.1811", "SELL", "1.1811",
                          "SELL", "1.1811", "SELL"),
                      buildDataRowTableMA("MA50", "1.1811", "BUY", "1.1811",
                          "BUY", "1.1811", "BUY"),
                      buildDataRowTableMA("MA100", "1.1811", "BUY", "1.1811",
                          "BUY", "1.1811", "BUY"),
                      buildDataRowTableMA("MA200", "1.1811", "BUY", "1.1811",
                          "BUY", "1.1811", "BUY"),
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

  DataRow buildDataRowTableMA(
      String _period,
      String _simplePrice,
      String _simpleConfirm,
      String _exponentialPrice,
      String _exponentialConfirm,
      String _smoothedPrice,
      String _smoothedConfirm) {
    var textStylePrice = TextStyle(
        fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kTextColor);
    var textStyleSell = TextStyle(
        fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: Colors.red);
    var textStyleBuy = TextStyle(
        fontFamily: "Nunito-Bold", fontSize: 22.ssp, color: kPrimaryColor);
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(_period, style: textStylePrice)),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_simplePrice, style: textStylePrice),
              Text(_simpleConfirm,
                  style: _simpleConfirm == "BUY" ? textStyleBuy : textStyleSell)
            ],
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_exponentialPrice, style: textStylePrice),
              Text(_exponentialConfirm,
                  style: _exponentialConfirm == "BUY"
                      ? textStyleBuy
                      : textStyleSell)
            ],
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_smoothedPrice, style: textStylePrice),
              Text(_smoothedConfirm,
                  style:
                      _smoothedConfirm == "BUY" ? textStyleBuy : textStyleSell)
            ],
          ),
        ),
      ],
    );
  }
  //------------------------ end buildlist MA ----------------------------

  //-------------------------- build MA and Indicators count sell buy ------

  Container buildContainerMAandIndicators() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            // padding: EdgeInsets.only(top: 10.w, left: 10, bottom: 10.w),
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
              children: <Widget>[
                buildMAandIndicator("MA"),
                Divider(height: 1.w, color: Colors.grey[100], thickness: 3.w),
                buildMAandIndicator("Indicators"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IntrinsicHeight buildMAandIndicator(String _title) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
              child: Container(
                child: Text(
                  _title,
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    fontSize: 25.ssp,
                    height: 2.w,
                  ),
                ),
              ),
            ),
          ),
          VerticalDivider(width: 1.w, color: Colors.grey[100], thickness: 3.w),
          buildCountSellBuyTechnical("Neutral"),
          VerticalDivider(width: 1.w, color: Colors.grey[100], thickness: 3.w),
          buildCountSellBuyTechnical("Buy(9)"),
          VerticalDivider(width: 1.w, color: Colors.grey[100], thickness: 3.w),
          buildCountSellBuyTechnical("Sell(3)"),
        ],
      ),
    );
  }

  Expanded buildCountSellBuyTechnical(String _data) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
        child: Center(
          child: Text(
            _data,
            style: TextStyle(
              fontFamily: "Nunito-Bold",
              fontSize: 25.ssp,
              height: 2.w,
            ),
          ),
        ),
      ),
    );
  }

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
                    fontFamily: "Nunito-ExtraBold",
                    fontSize: 25.ssp,
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
                      "Neutral",
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
    return Expanded(
      child: Container(
        height: 45.w,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 80.w,
              child: Center(
                child: Text(
                  "M5",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    color: kTextColor,
                    fontSize: 25.ssp,
                  ),
                ),
              ),
              decoration: boxNotSelected,
            ),
            SizedBox(width: 5.w),
            Container(
              width: 80.w,
              child: Center(
                child: Text(
                  "M15",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    color: kTextColor,
                    fontSize: 25.ssp,
                  ),
                ),
              ),
              decoration: boxNotSelected,
            ),
            SizedBox(width: 5.w),
            Container(
              width: 80.w,
              child: Center(
                child: Text(
                  "M30",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    color: kTextColor,
                    fontSize: 25.ssp,
                  ),
                ),
              ),
              decoration: boxNotSelected,
            ),
            SizedBox(width: 5.w),
            Container(
              width: 80.w,
              child: Center(
                child: Text(
                  "H1",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    color: Colors.white,
                    fontSize: 25.ssp,
                  ),
                ),
              ),
              decoration: boxSelected,
            ),
            SizedBox(width: 5.w),
            Container(
              width: 80.w,
              child: Center(
                child: Text(
                  "H4",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    color: kTextColor,
                    fontSize: 25.ssp,
                  ),
                ),
              ),
              decoration: boxNotSelected,
            ),
            SizedBox(width: 5.w),
            Container(
              width: 80.w,
              child: Center(
                child: Text(
                  "D1",
                  style: TextStyle(
                    fontFamily: "Nunito-Bold",
                    color: kTextColor,
                    fontSize: 25.ssp,
                  ),
                ),
              ),
              decoration: boxNotSelected,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  //-------------------- end build MA and Indicators count sell buy ------

//---------------------------------- CONTENT PRICE ---------------------------

  Container buildContainerPrice() {
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Price : 1.185",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kTextMediumColor,
                      ),
                    ),
                    Text(
                      "ADR : -0.004(-0.04%)",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kTextMediumColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Open : 1.185",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kTextMediumColor,
                      ),
                    ),
                    Text(
                      "Low : 1.185",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kTextMediumColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Close : 1.185",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kTextMediumColor,
                      ),
                    ),
                    Text(
                      "High : 1.185",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 22.ssp,
                        color: kTextMediumColor,
                      ),
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
        "EUR/USD",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
