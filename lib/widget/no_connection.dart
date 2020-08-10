import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoConnectionScreen extends StatelessWidget {
  final String textColor;
  const NoConnectionScreen({Key key, this.textColor});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Container(
      margin: EdgeInsets.only(top: 40.w),
      height: 450.w,
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/no_connection.svg',
            height: 300.w,
            width: 300.w,
          ),
          SizedBox(height: 40.w),
          Text(
            "No internet connection",
            style: TextStyle(
              fontFamily: "Nunito-ExtraBold",
              fontSize: 35.ssp,
              color: (textColor == "white") ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "Try turning on your Wifi or Mobile Data for using the app",
            style: TextStyle(
              fontFamily: "Nunito-SemiBold",
              fontSize: 25.ssp,
              color: (textColor == "white") ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
