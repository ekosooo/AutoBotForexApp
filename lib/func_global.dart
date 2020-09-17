import 'package:url_launcher/url_launcher.dart';

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
}
