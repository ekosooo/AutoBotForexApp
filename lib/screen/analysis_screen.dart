import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalforex/model/analysis_list_signal_model.dart';
import 'package:signalforex/screen/detail_patterns_signal.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/widget/no_data_record.dart';
import 'package:signalforex/widget/something_wrong.dart';

import 'detail_analysis_signal_screen.dart';

class AnalysisPage extends StatefulWidget {
  AnalysisPageState createState() => AnalysisPageState();
}

class AnalysisPageState extends State<AnalysisPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<DataPair> dataPairList = [];

  Future getListPair() async {
    final String baseUrl = kBaseUrlApi + "analysis/list";
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return ListAnalysisSignal.fromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future refreshData() async {
    dataPairList.clear();
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

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
              RefreshIndicator(
                onRefresh: refreshData,
                color: kPrimaryColor,
                child: FutureBuilder(
                  future: getListPair(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: SomethingWrong(
                          textColor: "black",
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      dataPairList = snapshot.data.data;
                      return buildListPair(dataPairList);
                    } else {
                      return Container(
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
              // ------------------ Patterns ----------------------
              ListView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 10.w),
                  buildListPatterns(),
                  buildListPatterns(),
                  buildListPatterns(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildListPatterns() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(8.w, 21.w),
            blurRadius: 53.w,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => DetailPatternsPage()));
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 300.w,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.w),
                  topRight: Radius.circular(15.w),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.w),
                  bottomRight: Radius.circular(15.w),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Asscending Triangle",
                    style: TextStyle(
                      fontFamily: "Nunito-ExtraBold",
                      fontSize: 33.ssp,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    "Segitiga naik adalah jenis pola grafik segitiga yang terjadi ketika ada level resistensi dan kemiringan dari posisi terendah yang lebih tinggi. Apa yang terjadi selama ini adalah bahwa ada tingkat tertentu yang tampaknya tidak dapat dilampaui oleh pembeli. Namun, mereka secara bertahap mulai mendorong harga naik sebagaimana dibuktikan dengan posisi terendah yang lebih tinggi.",
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 25.ssp,
                      color: kTextMediumColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListPair(List<DataPair> dataPairList) {
    var textStyleLight = TextStyle(
      fontSize: 22.ssp,
      fontFamily: "Nunito",
      color: kTextLightColor,
    );

    var textStylePrice = TextStyle(
      fontSize: 22.ssp,
      fontFamily: "Nunito-Bold",
      color: kTextLightColor,
    );

    if (dataPairList.length == 0) {
      return NoDataRecord();
    } else {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: dataPairList.length,
          itemBuilder: (context, index) {
            DataPair dataPair = dataPairList[index];
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 12.w,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DetailAnalysisSignalPage(
                                  dataPair.pairId, dataPair.pairName)));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 18.w),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SvgPicture.network(
                                        kMasterUrl +
                                            "/img/pairs/" +
                                            dataPair.pairImg,
                                        height: 35.w,
                                        width: 70.w,
                                      ),
                                      SizedBox(width: 15.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            dataPair.pairName,
                                            style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              fontSize: 25.ssp,
                                            ),
                                          ),
                                          SizedBox(height: 2.w),
                                          Text(
                                            dataPair.pairDesc,
                                            style: textStyleLight,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        getValPrice(dataPair.pairName,
                                            dataPair.iPriceClose),
                                        style: TextStyle(
                                          fontSize: 28.ssp,
                                          fontFamily: "Nunito-ExtraBold",
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "(" + dataPair.iAdrPersen + "%)",
                                            style: textStyleLight,
                                          ),
                                          SizedBox(width: 10.w),
                                          buildIconAdrDirection(
                                              dataPair.iAdrDirection),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //--------------- row open price dan low price
                              Container(
                                margin: EdgeInsets.only(left: 73.w, top: 5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "O  : " +
                                          getValPrice(dataPair.pairName,
                                              dataPair.iPriceOpen),
                                      style: textStyleLight,
                                    ),
                                    Text(
                                      "C  : " +
                                          getValPrice(dataPair.pairName,
                                              dataPair.iPriceClose),
                                      style: textStyleLight,
                                    ),
                                    Text(
                                      "H  : " +
                                          getValPrice(dataPair.pairName,
                                              dataPair.iPriceHigh),
                                      style: textStyleLight,
                                    ),
                                    Text(
                                      "L  : " +
                                          getValPrice(dataPair.pairName,
                                              dataPair.iPriceLow),
                                      style: textStyleLight,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  Icon buildIconAdrDirection(String adrDirection) {
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
                    "Signal Analysis",
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

  String getValPrice(String pairName, String price) {
    var posDot = price.indexOf(".");
    var posAfterDot;
    if (pairName.contains("JPY") || pairName.contains("XAU")) {
      posAfterDot = 3;
    } else {
      posAfterDot = 5;
    }
    String str1 = price.substring(0, posDot + 1);
    String str2 = price.substring(posDot + 1, posDot + 1 + posAfterDot);

    return str1 + str2;
  }
}
