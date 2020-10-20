import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/constants.dart';
import 'package:signalforex/func_global.dart';
import 'package:signalforex/model/tools_detail_model.dart';
import 'package:signalforex/screen/ea_forex_detail_screen.dart';
import 'package:signalforex/screen/form_subscribe_ea_screen.dart';
import 'package:signalforex/widget/detial_image_from_url.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:signalforex/widget/no_data_record.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IndicatorDetailPage extends StatefulWidget {
  final String toolsID;
  const IndicatorDetailPage(this.toolsID);
  @override
  IndicatorDetailPageState createState() => IndicatorDetailPageState();
}

class IndicatorDetailPageState extends State<IndicatorDetailPage> {
  Future getDetailINDI() async {
    final String baseUrl = kBaseUrlApi + 'tools/detail';
    final response = await http.post(
      '$baseUrl',
      body: {
        'idTools': widget.toolsID,
        'catTools': 'INDI',
      },
    );

    if (response.statusCode == 200) {
      return DetailTools.fromJson(response.body);
    } else {
      throw Exception('Fail load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(23, 40, 59, 1),
      appBar: buildAppBar(context),
      body: FutureBuilder(
        future: getDetailINDI(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SomethingWrong(textColor: 'white'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.status == 'success') {
              return buildDetailEA(context, snapshot.data.data);
            } else {
              return SomethingWrong(textColor: 'white');
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  buildDetailEA(
      BuildContext context, List<DataDetailTools> dataDetailToolsList) {
    if (dataDetailToolsList.length == 0) {
      return NoDataRecord();
    } else {
      var textContentStyle = TextStyle(
        fontFamily: 'Nunito',
        fontSize: 26.ssp,
        color: kTextLightColor,
      );
      var textTitleStyle = TextStyle(
        fontFamily: 'Nunito-ExtraBold',
        fontSize: 30.ssp,
        color: kTextColor,
      );

      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // -------- container content --------
                Container(
                  margin: EdgeInsets.only(top: 390.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.w),
                      topRight: Radius.circular(45.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //------- Container introduction ------------------
                      SizedBox(height: 170.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Text(
                          dataDetailToolsList[0].desc,
                          textAlign: TextAlign.justify,
                          style: textContentStyle,
                        ),
                      ),

                      //------ Container text fitur --------------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Fitur",
                              style: textTitleStyle,
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              dataDetailToolsList[0].fitur,
                              style: textContentStyle,
                            ),
                          ],
                        ),
                      ),

                      //------ Container text fitur --------------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Recommendation",
                              style: textTitleStyle,
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              dataDetailToolsList[0].recom,
                              style: textContentStyle,
                            ),
                          ],
                        ),
                      ),

                      //------------ backtest titlel ---------
                      SizedBox(height: 30.w),
                      (dataDetailToolsList[0].backtest.length == 0)
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(left: 35.w),
                              child: Text(
                                'Backtest',
                                style: textTitleStyle,
                              ),
                            ),

                      //---------- backtest -----------
                      SizedBox(height: 10.w),
                      (dataDetailToolsList[0].backtest.length == 0)
                          ? Container()
                          : Container(
                              height: 300.w,
                              margin: EdgeInsets.only(left: 35.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    dataDetailToolsList[0].backtest.length,

                                // ignore: missing_return
                                itemBuilder: (BuildContext context, int index) {
                                  String idVideo = YoutubePlayer.convertUrlToId(
                                      dataDetailToolsList[0]
                                          .backtest[index]
                                          .url);
                                  //-- untuk return video
                                  if (dataDetailToolsList[0]
                                          .backtest[index]
                                          .cat ==
                                      'VIDEO') {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PlayVideo(
                                              title: 'Backtest EA ' +
                                                  dataDetailToolsList[0].name,
                                              idVideo: idVideo,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.w),
                                        width: 550.w,
                                        child: Center(
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.w),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              dataDetailToolsList[0]
                                                  .backtest[0]
                                                  .thumbnail,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (dataDetailToolsList[0]
                                          .backtest[index]
                                          .cat ==
                                      'IMG') {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailImage(
                                                url: dataDetailToolsList[0]
                                                    .backtest[index]
                                                    .url),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: dataDetailToolsList[0]
                                            .backtest[index]
                                            .url,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 20.w),
                                          width: 550.w,
                                          child: Image.network(
                                            dataDetailToolsList[0]
                                                .backtest[index]
                                                .url,
                                            fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            //color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8.w),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),

                      //------------ screenshoot title ----------

                      (dataDetailToolsList[0].ss.length == 0)
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(left: 35.w, top: 30.w),
                              child: Text(
                                'Screenshot',
                                style: textTitleStyle,
                              ),
                            ),

                      //------ screenshot item ----------
                      (dataDetailToolsList[0].ss.length == 0)
                          ? Container()
                          : Container(
                              height: 400.w,
                              margin: EdgeInsets.only(left: 35.w, top: 10.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: dataDetailToolsList[0].ss.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: Hero(
                                      tag: index,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.w),
                                        width: 300.w,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: Text(
                                            '$index',
                                            style: textTitleStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) {
                                      //       //return DetailImage(index);
                                      //     },
                                      //   ),
                                      // );
                                    },
                                  );
                                },
                              ),
                            ),

                      //------ button ---------------
                      SizedBox(height: 80.w),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 35.w),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Container(
                      //         width: 100.w,
                      //         height: 100.w,
                      //         child: Material(
                      //           color: Colors.transparent,
                      //           child: InkWell(
                      //             splashColor: Colors.black.withOpacity(0.1),
                      //             onTap: () {
                      //               FunctionGlobal().launchURL(
                      //                   'https://t.me/SignalForex889');
                      //             },
                      //             child: Center(
                      //               child: Icon(
                      //                 FeatherIcons.send,
                      //                 size: 35.w,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: kPrimaryColor,
                      //           borderRadius: BorderRadius.circular(18.w),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               offset: Offset(0, 21.w),
                      //               blurRadius: 35.w,
                      //               color: kPrimaryColor.withOpacity(0.25),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(width: 30.w),
                      //       Expanded(
                      //         child: Container(
                      //           height: 100.w,
                      //           child: Material(
                      //             color: Colors.transparent,
                      //             child: InkWell(
                      //               splashColor: Colors.black.withOpacity(0.1),
                      //               onTap: () {
                      //                 // showDialogForm(
                      //                 //     context,
                      //                 //     dataDetailEAList[0].product,
                      //                 //     widget.idEA);
                      //                 Navigator.push(
                      //                   context,
                      //                   CupertinoPageRoute(
                      //                     builder: (context) =>
                      //                         FormSubscribeEAPage(
                      //                       toolsID: widget.toolsID,
                      //                       toolsName:
                      //                           dataDetailToolsList[0].name,
                      //                       toolsRate:
                      //                           dataDetailToolsList[0].rate,
                      //                       toolsUrlImg:
                      //                           dataDetailToolsList[0].img,
                      //                       productList:
                      //                           dataDetailToolsList[0].product,
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //               child: Center(
                      //                 child: Text(
                      //                   'Subscribe',
                      //                   style: TextStyle(
                      //                     fontFamily: 'Nunito',
                      //                     fontSize: 28.ssp,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           decoration: BoxDecoration(
                      //             color: kPrimaryColor,
                      //             borderRadius: BorderRadius.circular(18.w),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 offset: Offset(0, 21.w),
                      //                 blurRadius: 35.w,
                      //                 color: kPrimaryColor.withOpacity(0.25),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // --------- bottom margin -----
                      SizedBox(height: 60.w),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.w, right: 110.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //----- text product
                      Text(
                        'INDICATOR',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 30.ssp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        dataDetailToolsList[0].name,
                        style: TextStyle(
                          fontFamily: 'Nunito-ExtraBold',
                          fontSize: 55.ssp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 38.w,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            dataDetailToolsList[0].rate,
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 32.ssp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // ------- price product ------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20.w),
                              Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 30.ssp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontFamily: 'Nunito-Bold',
                                  fontSize: 40.ssp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '*for affiliate',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 20.ssp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // ------- img product ------
                          Container(
                            width: 250.w,
                            height: 350.w,
                            child: Hero(
                              tag: widget.toolsID,
                              child: Image.network(
                                dataDetailToolsList[0].img,
                                fit: BoxFit.fill,
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(10.w, 21.w),
                                  blurRadius: 30.w,
                                  color: Colors.black.withOpacity(0.08),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      // actions: <Widget>[
      //   Padding(
      //     padding: EdgeInsets.only(right: 35.w),
      //     child: Icon(
      //       FeatherIcons.heart,
      //       color: kTextColor,
      //     ),
      //   ),
      // ],
    );
  }
}
