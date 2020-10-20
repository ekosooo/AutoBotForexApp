import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalforex/model/tools_list_model.dart';

import 'package:signalforex/screen/ea_forex_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/widget/no_data_record.dart';
import 'package:signalforex/widget/something_wrong.dart';

class EAForexPage extends StatefulWidget {
  EAForexPageState createState() => EAForexPageState();
}

class EAForexPageState extends State<EAForexPage> {
  Future getListEA() async {
    final String baseUrl = kBaseUrlApi + 'tools/list';
    final response = await http.post(
      '$baseUrl',
      body: {
        'cat': 'EA',
      },
    );
    if (response.statusCode == 200) {
      return ToolsList.fromJson(response.body);
    } else {
      throw Exception('Fail load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334.w);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: FutureBuilder(
        future: getListEA(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SomethingWrong(textColor: 'black'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.status == 'success') {
              return buildListEA(snapshot.data.data);
            } else {
              return SomethingWrong(textColor: 'black');
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            );
          }
        },
      ),
    );
  }

  buildListEA(List<DataTools> toolsList) {
    if (toolsList.length == 0) {
      return NoDataRecord();
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 35.w),
        child: NotificationListener<OverscrollIndicatorNotification>(
          // ignore: missing_return
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: toolsList.length,
            itemBuilder: (BuildContext contex, int index) {
              DataTools dataTools = toolsList[index];
              return Container(
                margin: EdgeInsets.only(top: 20.w),
                height: 215.w,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EAForexDetailPage(dataTools.id),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: double.infinity,
                          height: 160.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.w),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.w, horizontal: 30.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //-- title ea --
                                      Text(
                                        dataTools.name,
                                        style: TextStyle(
                                          fontFamily: "Nunito-ExtraBold",
                                          fontSize: 28.ssp,
                                          color: kTextColor,
                                        ),
                                      ),

                                      //-- desc ea --
                                      SizedBox(height: 10.w),
                                      Text(
                                        dataTools.desc,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 22.ssp,
                                          height: 2.w,
                                          color: kTextLightColor,
                                        ),
                                      ),

                                      //--- rating ea ---
                                      SizedBox(height: 5.w),
                                      Row(
                                        children: <Widget>[
                                          RatingBar(
                                            itemSize: 25.w,
                                            onRatingUpdate: null,
                                            initialRating:
                                                double.parse(dataTools.rate),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            dataTools.rate,
                                            style: TextStyle(
                                              fontFamily: "Nunito-ExtraBold",
                                              fontSize: 22.ssp,
                                              color: kTextColor,
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
                        ),
                      ),

                      //-- img product --
                      Positioned(
                        top: 0,
                        left: 20.w,
                        child: Container(
                          height: 190.w,
                          width: 135.w,
                          child: Hero(
                            tag: dataTools.id,
                            child: Image.network(
                              dataTools.img,
                              fit: BoxFit.fill,
                            ),
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(8.w, 21.w),
                                blurRadius: 25.w,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      title: Text(
        "EA Forex",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
