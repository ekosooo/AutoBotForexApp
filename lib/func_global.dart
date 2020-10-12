import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signalforex/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FunctionGlobal {
  getGMTbySystem() {
    var currentTime = DateTime.now();
    var timeZone = currentTime.timeZoneOffset;
    var end = ":";
    final endIdx = timeZone.toString().indexOf(end);
    var gmt = int.parse(timeZone.toString().substring(0, endIdx));
    return gmt;
  }

  launchURL(String url) async {
    //const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> infoDevice() async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String currentDate = DateFormat('yyyy-MM-d').format(DateTime.now());
    String lastDate = preferences.getString('lastDate');
    if (lastDate != currentDate) {
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        String androidId = androidInfo.androidId;
        int osVersion = androidInfo.version.sdkInt;
        String device = androidInfo.model;
        final String baseUrl = kBaseUrlApi + 'historyuser';
        final response = await http.post(
          '$baseUrl',
          body: {
            'imei': androidId,
            'osVersion': osVersion.toString(),
            'platform': 'android',
            'device': device
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> map = json.decode(response.body);
          String status = map['status'];
          if (status == 'success') {
            preferences.setString('lastDate', currentDate);
          } else {
            print(status);
          }
        } else {
          print('error server');
        }
      } on PlatformException {
        print('Error:' 'Failed to get device info.');
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
          SizedBox(width: 30.w),
          Container(
            child: Text("Loading..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showSuccessDialog(BuildContext context, String message) {
    ScreenUtil.init(context, width: 750, height: 1344);
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/success.svg',
            height: 200.w,
            width: 300.w,
          ),
          SizedBox(height: 40.w),
          Text(
            'Success',
            style: TextStyle(
              fontFamily: 'Nunito-Bold',
              fontSize: 40.ssp,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: 20.w),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 30.ssp,
              color: kTextLightColor,
            ),
          ),
          SizedBox(height: 40.w),
          Container(
            height: 80.w,
            width: 400.w,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(50.w),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.1),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 30.ssp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showErrorDialog(BuildContext context, String message) {
    ScreenUtil.init(context, width: 750, height: 1344);
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/error.svg',
            height: 200.w,
            width: 300.w,
          ),
          SizedBox(height: 40.w),
          Text(
            'Error',
            style: TextStyle(
              fontFamily: 'Nunito-Bold',
              fontSize: 40.ssp,
              color: Colors.red[400],
            ),
          ),
          SizedBox(height: 20.w),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 30.ssp,
              color: kTextLightColor,
            ),
          ),
          SizedBox(height: 40.w),
          Container(
            height: 80.w,
            width: 400.w,
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(50.w),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.1),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 30.ssp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
