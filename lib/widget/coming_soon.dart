import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/comingsoon.svg',
              width: 400.w,
              height: 400.w,
            ),
            SizedBox(height: 30.w),
            Text(
              'Coming Soon..',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito-ExtraBold',
                fontSize: 45.ssp,
                color: kTextColor,
              ),
            ),
            Text(
              'This feature will be available in the future. Keep using this app to get the convenience of your trading.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 28.ssp,
                color: kTextLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
