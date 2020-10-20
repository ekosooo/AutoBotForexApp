import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalNotifSettingPage extends StatefulWidget {
  @override
  SignalNotifSettingPageState createState() => SignalNotifSettingPageState();
}

class SignalNotifSettingPageState extends State<SignalNotifSettingPage> {
  List arrList = [
    {
      'pairID': 'EU',
      'pairName': 'EURUSD',
      'pairDesc': 'Euro vs US  Dollar',
      'isSelected': false,
    },
    {
      'pairID': 'GU',
      'pairName': 'GBPUSD',
      'pairDesc': 'Great Britian Pound vs US Dollar',
      'isSelected': false,
    },
    {
      'pairID': 'XU',
      'pairName': 'XAUUSD',
      'pairDesc': 'Gold vs US Dollar',
      'isSelected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //-- guide ---
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.w),
              padding: EdgeInsets.only(
                  top: 20.w, right: 15.w, left: 15.w, bottom: 20.w),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.07),
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Guide',
                    style: TextStyle(
                      fontFamily: 'Nunito-ExtraBold',
                      fontSize: 28.ssp,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    'You can set what notification signals will be sent to you. If you haven`t set it up, we will send all signal notifications to you.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 25.ssp,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.w),
            //-- list pair ---
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: arrList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 2.w),
                  // padding:
                  //     EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                  height: 100.w,
                  //color: kBgInputText,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 130.w,
                        height: 80.w,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  arrList[index]['pairName'],
                                  style: TextStyle(
                                    fontFamily: 'Nunito-ExtraBold',
                                    fontSize: 27.ssp,
                                    color: kTextColor,
                                  ),
                                ),
                                Text(
                                  arrList[index]['pairDesc'],
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 22.ssp,
                                    color: kTextLightColor,
                                  ),
                                ),
                              ],
                            ),

                            //-- button add --
                            (arrList[index]['isSelected'])
                                ? Container(
                                    height: 50.w,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(5.w),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 23.w,
                                          offset: Offset(8.w, 10.w),
                                          color: kPrimaryColor.withOpacity(0.2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        FeatherIcons.plus,
                                        color: Colors.white,
                                        size: 30.w,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 50.w,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      color: kBgInputText,
                                      borderRadius: BorderRadius.circular(5.w),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        FeatherIcons.plus,
                                        color: kTextColor,
                                        size: 30.w,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 100.w),
            Container(
              height: 2.w,
              color: kBgInputText,
              margin: EdgeInsets.all(35.w),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30.w, left: 35.w, right: 35.w),
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '2 Pair',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 32.ssp,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 32.ssp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        'Signal Notification Setting',
        style: TextStyle(
          fontFamily: 'Nunito-ExtraBold',
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kTextColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
