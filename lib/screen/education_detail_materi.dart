import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';

class EducationDetailPage extends StatefulWidget {
  @override
  EducationDetailPageState createState() => EducationDetailPageState();
}

class EducationDetailPageState extends State<EducationDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Container(
        margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 10.w),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              height: 400.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.w),
              ),
            ),
            SizedBox(height: 20.w),
            Text(
              "Tipe dari ten, grafik dan peraturan penyusunan grafik",
              style: TextStyle(
                fontFamily: "Nunito-ExtraBold",
                fontSize: 27.ssp,
                color: kTextColor,
                height: 2.w,
              ),
            ),
            SizedBox(height: 20.w),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 22.ssp,
                color: kTextLightColor,
                height: 3.w,
              ),
            ),
            SizedBox(height: 20.w),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 22.ssp,
                color: kTextLightColor,
                height: 3.w,
              ),
            ),
          ],
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
          }),
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
