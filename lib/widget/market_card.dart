import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signalforex/constants.dart';

class MarketHoursCard extends StatelessWidget {
  final String location;
  final String open;
  final String close;
  final String statusMarket;

  const MarketHoursCard(
      {Key key, this.location, this.open, this.close, this.statusMarket})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return LayoutBuilder(
      builder: (context, constrains) {
        return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.w),
              width: constrains.maxWidth / 2 - 11.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.w),
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
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/mark.svg',
                        width: 31.w,
                        height: 31.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, bottom: 10.w),
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          fontFamily: "Nunito-ExtraBold",
                          fontSize: 30.ssp,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/time.svg',
                        width: 31.w,
                        height: 31.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Open",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 20.ssp,
                              ),
                            ),
                            SizedBox(
                              height: 3.w,
                            ),
                            Text(
                              open,
                              style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 19.ssp,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 12.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Close",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 20.ssp,
                              ),
                            ),
                            SizedBox(
                              height: 3.w,
                            ),
                            Text(
                              close,
                              style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 20.ssp,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            //-------------label container ----------
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 100.w,
                height: 33.w,
                decoration: BoxDecoration(
                  //color: kPrimaryColor,
                  gradient: (statusMarket == 'Open')
                      ? LinearGradient(
                          colors: [kPrimaryColor, Colors.teal[600]],
                        )
                      : LinearGradient(
                          colors: [Colors.red[400], Colors.red[700]],
                        ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.w),
                    bottomLeft: Radius.circular(20.w),
                  ),
                ),
                child: Center(
                  child: Text(
                    statusMarket,
                    style: TextStyle(
                      fontFamily: "Nunito-Bold",
                      fontSize: 18.ssp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
