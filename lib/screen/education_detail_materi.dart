import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class EducationDetailPage extends StatefulWidget {
  final link;
  const EducationDetailPage({Key key, this.link}) : super(key: key);
  @override
  EducationDetailPageState createState() => EducationDetailPageState();
}

class EducationDetailPageState extends State<EducationDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return WebviewScaffold(
      url: kMasterUrl + widget.link,
      //url: 'https://signalforex.id/education/basic/pengantar',
      appBar: buildAppBar(context),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      scrollBar: false,
      initialChild: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kTextColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        "Materi",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
