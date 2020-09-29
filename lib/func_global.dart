import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
        // print(androidInfo.androidId);
        // print(androidInfo.version.sdkInt);
        // print(androidInfo.model);
        // print(currentDate);
        final response = await http.post(
          'http://192.168.100.5:8000/api/history/use/app',
          body: {
            'id': androidId,
            'osVersion': osVersion.toString(),
            'date': currentDate,
            'device': device
          },
        );

        if (response.body == 'success') {
          preferences.setString('lastDate', currentDate);
        }
      } on PlatformException {
        print('Error:' 'Failed to get device info.');
      }
    }
  }
}
