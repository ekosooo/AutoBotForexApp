import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';

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
        child: Column(
          children: <Widget>[
            buildSearch(),
            SizedBox(height: 50.w),
            ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                buildProduct(),
                buildProduct(),
                buildProduct(),
                buildProduct(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildProduct() {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      height: 205.w,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              height: 150.w,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 140.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.w),
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
              height: 180.w,
              width: 140.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
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
        ],
      ),
    );
  }

  Row buildSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "EA Forex",
          style: TextStyle(
            fontFamily: "Nunito-ExtraBold",
            fontSize: 35.ssp,
            color: kTextColor,
          ),
        ),
        Icon(
          FeatherIcons.search,
          size: 25,
          color: kTextLightColor,
        ),
      ],
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
      // title: Text(
      //   "EA Forex",
      //   style: TextStyle(
      //     fontFamily: "Nunito-ExtraBold",
      //     fontSize: 32.ssp,
      //     color: kTextColor,
      //   ),
      // ),
    );
  }
}
