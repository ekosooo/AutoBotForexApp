import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:signalforex/func_global.dart';

class EAForexDetailPage extends StatefulWidget {
  final String idEA;
  const EAForexDetailPage(this.idEA);
  EAForexDetailPageState createState() => EAForexDetailPageState();
}

class EAForexDetailPageState extends State<EAForexDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    var textContentStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 25.ssp,
      color: kTextLightColor,
    );
    var textTitleStyle = TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      fontSize: 30.ssp,
      color: kTextColor,
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(23, 40, 59, 1),
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // -------- container content --------
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
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
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
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
                            for (var i = 0; i < 5; i++)
                              Text(
                                '-  Lorem Ipsum is simply dummy text',
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
                              "Rule",
                              style: textTitleStyle,
                            ),
                            SizedBox(height: 10.w),
                            for (var i = 0; i < 5; i++)
                              Text(
                                '-  Lorem Ipsum is simply dummy text',
                                style: textContentStyle,
                              ),
                          ],
                        ),
                      ),

                      //------------ back test --------------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.only(left: 35.w),
                        child: Text(
                          'Back Test Result',
                          style: textTitleStyle,
                        ),
                      ),

                      //---------- backtest item -----------
                      SizedBox(height: 10.w),
                      Container(
                        height: 300.w,
                        margin: EdgeInsets.only(left: 35.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(right: 20.w),
                              width: 500.w,
                              color: Colors.grey[300],
                              child: Center(
                                child: Text(
                                  '$index',
                                  style: textTitleStyle,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      //------------ screenshoot title ----------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.only(left: 35.w),
                        child: Text(
                          'Screenshot',
                          style: textTitleStyle,
                        ),
                      ),

                      //------ screenshot item ----------
                      SizedBox(height: 10.w),
                      Container(
                        height: 400.w,
                        margin: EdgeInsets.only(left: 35.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return DetailImage(index);
                                }));
                              },
                            );
                          },
                        ),
                      ),

                      //------ button ---------------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Row(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 50.w,
                              height: 80.w,
                              buttonColor: kPrimaryColor,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                                color: kPrimaryColor,
                                onPressed: () {
                                  // launchURL("https://t.me/ekosooo");
                                },
                                child: Icon(
                                  FeatherIcons.send,
                                  size: 40.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ButtonTheme(
                                height: 80.w,
                                child: RaisedButton(
                                  color: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
                                  onPressed: () {
                                    // launchURL("https://t.me/ekosooo");
                                  },
                                  child: Text(
                                    'BUY',
                                    style: TextStyle(
                                      fontFamily: 'Nunito-SemiBold',
                                      fontSize: 30.ssp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // --------- bottom margin -----
                      SizedBox(height: 20.w),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.w, top: 50.w, right: 110.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //----- text product
                      Text(
                        'Expert Advisor',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 30.ssp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Super FX EA',
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
                            '4.5',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 32.ssp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // ------- image product ------

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 80.w),
                              Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 30.ssp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '\$200',
                                style: TextStyle(
                                  fontFamily: 'Nunito-Bold',
                                  fontSize: 40.ssp,
                                  color: Colors.white,
                                ),
                              ),

                              //----------- like ------
                              Container(
                                margin: EdgeInsets.only(top: 30.w),
                                height: 90.w,
                                width: 90.w,
                                child: Icon(
                                  FeatherIcons.heart,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
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
                          Container(
                            width: 270.w,
                            height: 370.w,
                            child: Hero(
                              tag: widget.idEA,
                              child: Image.asset(
                                'assets/images/superfx.png',
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
      ),
    );
    //   return Scaffold(
    //     backgroundColor: kBackgroundColor,
    //     appBar: buildAppBar(context),
    //     body:
    //     SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           Center(
    //             child: Container(
    //               margin: EdgeInsets.symmetric(vertical: 10.w),
    //               width: 250.w,
    //               height: 370.w,
    //               child: Hero(
    //                 tag: widget.idEA,
    //                 child: Image.asset(
    //                   'assets/images/superfx.png',
    //                   fit: BoxFit.fill,
    //                 ),
    //               ),
    //               decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     offset: Offset(10.w, 21.w),
    //                     blurRadius: 30.w,
    //                     color: Colors.black.withOpacity(0.08),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),

    //           //------- container title and rating -----------
    //           SizedBox(height: 30.w),
    //           Container(
    //             margin: EdgeInsets.symmetric(horizontal: 35.w),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Text(
    //                   "EA Super Fx",
    //                   style: TextStyle(
    //                     fontFamily: 'Nunito-ExtraBold',
    //                     fontSize: 40.ssp,
    //                   ),
    //                 ),
    //                 RatingBar(
    //                   itemSize: 35.w,
    //                   onRatingUpdate: null,
    //                   initialRating: 4.5,
    //                   minRating: 1,
    //                   direction: Axis.horizontal,
    //                   allowHalfRating: true,
    //                   itemBuilder: (context, _) => Icon(
    //                     Icons.star,
    //                     color: Colors.amber,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),

    //           //------- Container introduction ------------------
    //           SizedBox(height: 20.w),
    //           Container(
    //             margin: EdgeInsets.symmetric(horizontal: 35.w),
    //             child: Text(
    //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
    //               textAlign: TextAlign.justify,
    //               style: textContentStyle,
    //             ),
    //           ),

    //           //------ Container text fitur --------------
    //           SizedBox(height: 30.w),
    //           Container(
    //             margin: EdgeInsets.symmetric(horizontal: 35.w),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "Fitur",
    //                   style: textTitleStyle,
    //                 ),
    //                 SizedBox(height: 10.w),
    //                 for (var i = 0; i < 5; i++)
    //                   Text(
    //                     '-  Lorem Ipsum is simply dummy text',
    //                     style: textContentStyle,
    //                   ),
    //               ],
    //             ),
    //           ),

    //           //------------ back test --------------
    //           SizedBox(height: 30.w),
    //           Container(
    //             margin: EdgeInsets.only(left: 35.w),
    //             child: Text(
    //               'Back Test Result',
    //               style: textTitleStyle,
    //             ),
    //           ),

    //           //---------- backtest item -----------
    //           SizedBox(height: 10.w),
    //           Container(
    //             height: 300.w,
    //             margin: EdgeInsets.only(left: 35.w),
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               scrollDirection: Axis.horizontal,
    //               itemCount: 5,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Container(
    //                   margin: EdgeInsets.only(right: 20.w),
    //                   width: 500.w,
    //                   color: Colors.grey[300],
    //                   child: Center(
    //                     child: Text(
    //                       '$index',
    //                       style: textTitleStyle,
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),

    //           //------------ screenshoot title ----------
    //           SizedBox(height: 30.w),
    //           Container(
    //             margin: EdgeInsets.only(left: 35.w),
    //             child: Text(
    //               'Screenshot',
    //               style: textTitleStyle,
    //             ),
    //           ),

    //           //------ screenshot item ----------
    //           SizedBox(height: 10.w),
    //           Container(
    //             height: 400.w,
    //             margin: EdgeInsets.only(left: 35.w),
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               scrollDirection: Axis.horizontal,
    //               itemCount: 5,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return GestureDetector(
    //                   child: Hero(
    //                     tag: index,
    //                     child: Container(
    //                       margin: EdgeInsets.only(right: 20.w),
    //                       width: 300.w,
    //                       color: Colors.grey[300],
    //                       child: Center(
    //                         child: Text(
    //                           '$index',
    //                           style: textTitleStyle,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   onTap: () {
    //                     Navigator.push(context, MaterialPageRoute(builder: (_) {
    //                       return DetailImage(index);
    //                     }));
    //                   },
    //                 );
    //               },
    //             ),
    //           ),

    //           //------ button ---------------
    //           SizedBox(height: 30.w),
    //           Container(
    //             margin: EdgeInsets.symmetric(horizontal: 35.w),
    //             child: Row(
    //               children: <Widget>[
    //                 ButtonTheme(
    //                   minWidth: 50.w,
    //                   height: 80.w,
    //                   buttonColor: kPrimaryColor,
    //                   child: RaisedButton(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(8.w),
    //                     ),
    //                     color: kPrimaryColor,
    //                     onPressed: () {
    //                       FunctionGlobal().launchURL("https://t.me/ekosooo");
    //                     },
    //                     child: Icon(
    //                       FeatherIcons.send,
    //                       size: 40.w,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(width: 10.w),
    //                 Expanded(
    //                   child: ButtonTheme(
    //                     height: 80.w,
    //                     child: RaisedButton(
    //                       color: kPrimaryColor,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(8.w),
    //                       ),
    //                       onPressed: () {
    //                         FunctionGlobal().launchURL("https://t.me/ekosooo");
    //                       },
    //                       child: Text(
    //                         'BUY',
    //                         style: TextStyle(
    //                           fontFamily: 'Nunito-SemiBold',
    //                           fontSize: 30.ssp,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),

    //           //-------margin bottom
    //           SizedBox(height: 20.w),
    //         ],
    //       ),
    //     ),
    //   );
    // }
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
    );
  }
}

class DetailImage extends StatelessWidget {
  final int index;
  const DetailImage(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
      ),
      body: GestureDetector(
          child: Center(
            child: Hero(
              tag: index,
              child: Container(
                // color: Colors.grey[300],
                // width: 600.w,
                // height: 900.w,
                margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
                child: Center(
                  // child: Text(
                  //   '$index',
                  //   style: TextStyle(
                  //     fontFamily: 'Nunito-ExtraBold',
                  //     fontSize: 30.ssp,
                  //     color: kTextColor,
                  //   ),
                  // ),
                  child: PhotoView(
                    minScale: 0.8,
                    imageProvider: AssetImage(
                      'assets/images/superfx.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          }),
    );
  }
}
