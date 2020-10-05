import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:signalforex/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
}
