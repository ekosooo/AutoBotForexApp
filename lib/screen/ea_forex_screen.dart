import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalforex/screen/ea_forex_detail_screen.dart';

class EAForexPage extends StatefulWidget {
  EAForexPageState createState() => EAForexPageState();
}

class EAForexPageState extends State<EAForexPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334.w);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35.w),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext contex, int index) {
            return Container(
              margin: EdgeInsets.only(top: 20.w),
              height: 205.w,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EAForexDetailPage(index.toString() + "a")));
                },
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: double.infinity,
                        height: 150.w,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "EA Super FX",
                                      style: TextStyle(
                                        fontFamily: "Nunito-ExtraBold",
                                        fontSize: 28.ssp,
                                        color: kTextColor,
                                      ),
                                    ),
                                    Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
                                    SizedBox(height: 5.w),
                                    Row(
                                      children: <Widget>[
                                        RatingBar(
                                          itemSize: 25.w,
                                          onRatingUpdate: null,
                                          initialRating: 4.5,
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
                                          "4.5",
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
                    Positioned(
                      top: 0,
                      left: 20.w,
                      child: Container(
                        height: 190.w,
                        width: 135.w,
                        child: Hero(
                          tag: index.toString() + "a",
                          child: Image.asset(
                            'assets/images/superfx.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.grey[300],
                          // borderRadius: BorderRadius.circular(10.w),
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
        //  Column(
        //   children: <Widget>[
        //     ListView(
        //       shrinkWrap: true,
        //       physics: BouncingScrollPhysics(),
        //       children: <Widget>[
        //         buildProduct(context),
        //         buildProduct(context),
        //         buildProduct(context),
        //         buildProduct(context),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Container buildProduct(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      height: 205.w,
      width: double.infinity,
      child: GestureDetector(
        // onTap: () {
        //   Navigator.push(context,
        //       CupertinoPageRoute(builder: (context) => EAForexDetailPage()));
        // },
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                height: 150.w,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "EA Super FX",
                              style: TextStyle(
                                fontFamily: "Nunito-ExtraBold",
                                fontSize: 28.ssp,
                                color: kTextColor,
                              ),
                            ),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
                            SizedBox(height: 5.w),
                            Row(
                              children: <Widget>[
                                RatingBar(
                                  itemSize: 25.w,
                                  onRatingUpdate: null,
                                  initialRating: 4.5,
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
                                  "4.5",
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
            Positioned(
              top: 0,
              left: 20.w,
              child: Container(
                height: 190.w,
                width: 135.w,
                child: Hero(
                  tag: null,
                  child: Image.asset(
                    'assets/images/superfx.png',
                    fit: BoxFit.fill,
                  ),
                ),
                decoration: BoxDecoration(
                  // color: Colors.grey[300],
                  // borderRadius: BorderRadius.circular(10.w),
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
