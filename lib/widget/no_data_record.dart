import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataRecord extends StatelessWidget {
  // final String textColor;
  // const SomethingWrong({Key key, this.textColor});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 40.w),
        height: 450.w,
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/norecord.svg',
              height: 300.w,
              width: 300.w,
            ),
            SizedBox(height: 40.w),
            // Text(
            //   "Aaaaah! Something went wrong",
            //   style: TextStyle(
            //     fontFamily: "Nunito-ExtraBold",
            //     fontSize: 35.ssp,
            //     color: Colors.black,
            //   ),
            // ),
            Text(
              "No Record ...",
              style: TextStyle(
                fontFamily: "Nunito-SemiBold",
                fontSize: 30.ssp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
