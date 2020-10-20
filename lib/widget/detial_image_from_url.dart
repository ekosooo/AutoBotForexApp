import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//-- detail image class --
class DetailImage extends StatelessWidget {
  final String url;
  DetailImage({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: url,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
              child: Center(
                child: PhotoView(
                  minScale: 0.8,
                  imageProvider: NetworkImage(
                    url,
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
