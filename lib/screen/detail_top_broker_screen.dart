import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/model/top_broker_model.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailTopBrokerPage extends StatelessWidget {
  final broker;
  const DetailTopBrokerPage({Key key, this.broker}) : super(key: key);

  Future getDetailBroker() async {
    final String baseUrl = "http://192.168.100.5:8000/api/broker/detail";
    final response = await http.post("$baseUrl", body: {"brokerID": broker});
    if (response.statusCode == 200) {
      return TopBroker.fromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  launchURL(String url) async {
    //const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: FutureBuilder(
          future: getDetailBroker(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: SomethingWrong(
                    textColor: 'black',
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<DataBroker> dataBroker = snapshot.data.data;
              return buildContent(dataBroker);
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  ),
                ),
              );
            }
          }),
    );
  }

  Container buildContent(List<DataBroker> dataBroker) {
    var textStyleTitle = TextStyle(
      fontFamily: "Nunito-ExtraBold",
      fontSize: 27.ssp,
      color: kTextColor,
    );
    var textStyleContent = TextStyle(
      fontFamily: "Nunito",
      fontSize: 25.ssp,
      color: kTextLightColor,
    );
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(left: 35.w, right: 35.w, bottom: 15.w),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          //------------------ logo broker and rating ----------------
          Container(
            padding: EdgeInsets.symmetric(vertical: 40.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //color: Colors.amber,
                    width: 100.w,
                    height: 100.w,
                    child: Image.network(
                      'http://192.168.100.5:8000/images/broker/' +
                          dataBroker[0].brokerImg,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    dataBroker[0].brokerName,
                    style: TextStyle(
                      fontFamily: "Nunito-ExtraBold",
                      fontSize: 30.ssp,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RatingBar(
                        itemSize: 35.w,
                        onRatingUpdate: null,
                        initialRating: dataBroker[0].brokerRate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        dataBroker[0].brokerRate.toString(),
                        style: TextStyle(
                          fontFamily: "Nunito-ExtraBold",
                          fontSize: 25.ssp,
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      launchURL(dataBroker[0].brokerAffiliate);
                    },
                    elevation: 0.0,
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontFamily: "Nunito-ExtraBold",
                        fontSize: 22.ssp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //----------------------- indroduction -----------
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Introduction",
                  style: textStyleTitle,
                ),
                SizedBox(height: 10.w),
                Text(
                  dataBroker[0].brokerIntro,
                  textAlign: TextAlign.justify,
                  style: textStyleContent,
                ),
              ],
            ),
          ),

          //------------------- regulation and brokerage model --------------
          Container(
            margin: EdgeInsets.only(top: 30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Regulation",
                        style: textStyleTitle,
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        dataBroker[0].brokerRegulation,
                        style: textStyleContent,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Brokerage Model",
                        style: textStyleTitle,
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        dataBroker[0].brokerModel,
                        style: textStyleContent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //--------------- Demo Account ----------------------
          Container(
            margin: EdgeInsets.only(top: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Demo Account",
                  style: textStyleTitle,
                ),
                SizedBox(height: 10.w),
                Text(
                  dataBroker[0].brokerDemo,
                  style: textStyleContent,
                ),
              ],
            ),
          ),

          //------------ Deposit minimal & Founding Methods ---------
          Container(
            margin: EdgeInsets.only(top: 30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Min Deposit",
                        style: textStyleTitle,
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        dataBroker[0].brokerMinDepo,
                        style: textStyleContent,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Founding Methods",
                        style: textStyleTitle,
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        dataBroker[0].brokerFound,
                        style: textStyleContent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //--------------- pros --------------
          Container(
            margin: EdgeInsets.only(top: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Pros",
                  style: textStyleTitle,
                ),
                SizedBox(height: 10.w),
                Text(
                  dataBroker[0].brokerPros,
                  style: textStyleContent,
                ),
              ],
            ),
          ),

          //------------- Cros -----------------
          Container(
            margin: EdgeInsets.only(top: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cros",
                  style: textStyleTitle,
                ),
                SizedBox(height: 10.w),
                Text(
                  dataBroker[0].brokerCros,
                  style: textStyleContent,
                ),
              ],
            ),
          ),
        ],
      ),
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
    );
  }
  //Container(
  //   padding: EdgeInsets.all(20.w),
  //   margin: EdgeInsets.only(left: 35.w, right: 35.w, bottom: 15.w),
  //   child:
  //   ListView(
  //     shrinkWrap: true,
  //     children: <Widget>[
  //       //------------------ logo broker and rating ----------------
  //       Container(
  //         padding: EdgeInsets.symmetric(vertical: 40.w),
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Container(
  //                 //color: Colors.amber,
  //                 width: 100.w,
  //                 height: 100.w,
  //                 child: Image.asset(
  //                   'assets/images/fbs.jpg',
  //                   fit: BoxFit.fitWidth,
  //                 ),
  //               ),
  //               SizedBox(height: 10.w),
  //               Text(
  //                 "FBS",
  //                 style: TextStyle(
  //                   fontFamily: "Nunito-ExtraBold",
  //                   fontSize: 30.ssp,
  //                 ),
  //               ),
  //               SizedBox(height: 10.w),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   RatingBar(
  //                     itemSize: 35.w,
  //                     onRatingUpdate: null,
  //                     initialRating: 4.5,
  //                     minRating: 1,
  //                     direction: Axis.horizontal,
  //                     allowHalfRating: true,
  //                     itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
  //                     itemBuilder: (context, _) => Icon(
  //                       Icons.star,
  //                       color: kPrimaryColor,
  //                     ),
  //                   ),
  //                   SizedBox(width: 10.w),
  //                   Text(
  //                     "4.5",
  //                     style: TextStyle(
  //                       fontFamily: "Nunito-ExtraBold",
  //                       fontSize: 25.ssp,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       //----------------------- indroduction -----------
  //       Container(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "Introduction",
  //               style: textStyleTitle,
  //             ),
  //             SizedBox(height: 10.w),
  //             Text(
  //               "FBS Markets Incorporated Ltd didirikan pada tahun 2011 dan mengkhususkan diri dalam menawarkan Forex dan CFD untuk perdagangan melalui gudang platform perdagangan yang komprehensif, yang meliputi platform MT4, MT5 dan cTrader. \n\nFBS adalah nama perdagangan dari FBS Markets. Pialang menggunakan model pialang hibrid karena bertindak dalam kapasitasnya sebagai Pembuat Pasar tetapi memiliki kemampuan untuk mengirim perdagangan ke tempat STP untuk tujuan lindung nilai.\n\nPenawaran produk dari FBS termasuk Spot FX, CFD pada Logam Spot, Komoditas, Indeks Ekuitas, dan Cryptocurrency. OctaFX terkenal dengan penawaran spread yang ketat dan kecepatan eksekusinya yang sangat cepat.",
  //               textAlign: TextAlign.justify,
  //               style: textStyleContent,
  //             ),
  //           ],
  //         ),
  //       ),

  //       //------------------- regulation and brokerage model --------------
  //       Container(
  //         margin: EdgeInsets.only(top: 30.w),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     "Regulation",
  //                     style: textStyleTitle,
  //                   ),
  //                   SizedBox(height: 10.w),
  //                   Text(
  //                     "-   CySEC(Siprus)",
  //                     style: textStyleContent,
  //                   ),
  //                   Text(
  //                     "-   FSA (St. Vincent & Grenadines)",
  //                     style: textStyleContent,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     "Brokerage Model",
  //                     style: textStyleTitle,
  //                   ),
  //                   SizedBox(height: 10.w),
  //                   Text(
  //                     "-   Market Maker (DOA)",
  //                     style: textStyleContent,
  //                   ),
  //                   Text(
  //                     "-   Straight-Through Processing (RTE)",
  //                     style: textStyleContent,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),

  //       //--------------- Demo Account ----------------------
  //       Container(
  //         margin: EdgeInsets.only(top: 30.w),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "Demo Account",
  //               style: textStyleTitle,
  //             ),
  //             SizedBox(height: 10.w),
  //             Text(
  //               "-  Yes",
  //               style: textStyleContent,
  //             ),
  //           ],
  //         ),
  //       ),

  //       //------------ Deposit minimal & Founding Methods ---------
  //       Container(
  //         margin: EdgeInsets.only(top: 30.w),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     "Min Deposit",
  //                     style: textStyleTitle,
  //                   ),
  //                   SizedBox(height: 10.w),
  //                   Text(
  //                     "-   \$5",
  //                     style: textStyleContent,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     "Founding Methods",
  //                     style: textStyleTitle,
  //                   ),
  //                   SizedBox(height: 10.w),
  //                   Text(
  //                     "-   Bank Wire Transfer",
  //                     style: textStyleContent,
  //                   ),
  //                   Text(
  //                     "-   Credit cards",
  //                     style: textStyleContent,
  //                   ),
  //                   Text(
  //                     "-   E-wallet",
  //                     style: textStyleContent,
  //                   ),
  //                   Text(
  //                     "-   Crypto",
  //                     style: textStyleContent,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),

  //       //--------------- pros --------------
  //       Container(
  //         margin: EdgeInsets.only(top: 30.w),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "Pros",
  //               style: textStyleTitle,
  //             ),
  //             SizedBox(height: 10.w),
  //             Text(
  //               "-   Menawarkan berbagai pilihan platform perdagangan yang mencakup MT4, MT5, cTrader, Web, dan Aplikasi Seluler.",
  //               style: textStyleContent,
  //             ),
  //           ],
  //         ),
  //       ),

  //       //------------- Cros -----------------
  //       Container(
  //         margin: EdgeInsets.only(top: 30.w),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "Cros",
  //               style: textStyleTitle,
  //             ),
  //             SizedBox(height: 10.w),
  //             Text(
  //               "-   Tidak adanya beberapa Peraturan Tier-1 (hanya dilisensikan oleh CySEC)",
  //               style: textStyleContent,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.circular(10.w),
  //     boxShadow: [
  //       BoxShadow(
  //         offset: Offset(8.w, 21.w),
  //         blurRadius: 53.w,
  //         color: Colors.black.withOpacity(0.05),
  //       ),
  //     ],
  //   ),
  // ),

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
        "Detail Broker",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
