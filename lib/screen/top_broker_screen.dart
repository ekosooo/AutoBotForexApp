import 'package:flutter/material.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalforex/func_global.dart';
import 'package:signalforex/model/banner_model.dart';
import 'package:signalforex/model/broker_list_model.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'detail_top_broker_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class TopBrokerPage extends StatelessWidget {
  Future getTopBrokerList() async {
    final String baseUrl = kBaseUrlApi + 'broker/list';
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return ListBroker.fromJson(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future getPromo() async {
    final String baseUrl = kBaseUrlApi + "broker/promo";
    final response = await http.get("$baseUrl");
    if (response.statusCode == 200) {
      return Banners.fromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          // Container(
          //   height: 330.w,
          //   color: Colors.grey,
          // ),
          buildCarouselSliderFuture(),
          SizedBox(height: 30.w),
          Container(
            margin: EdgeInsets.only(top: 20.w, left: 35.w, right: 35.w),
            child: FutureBuilder(
              future: getTopBrokerList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return SomethingWrong(
                    textColor: "black",
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return buildListTopBroker(snapshot.data.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder buildCarouselSliderFuture() {
    return FutureBuilder(
      future: getPromo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something Wrong",
              style: TextStyle(fontFamily: "Nunito", fontSize: 24.ssp),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return buildCarouselSlider(snapshot.data.data);
        } else {
          return Center(
            child: shimmerBanner(),
          );
        }
      },
    );
  }

  CarouselSlider buildCarouselSlider(List<DataBanner> dataBannerList) {
    return CarouselSlider(
      items: <Widget>[
        for (var i = 0; i < dataBannerList.length; i++)
          GestureDetector(
            onTap: () {
              FunctionGlobal().launchURL(dataBannerList[i].link);
            },
            child: Container(
              //height: 450.w,
              // margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                child: Image.network(
                  kMasterUrl + "img/promo/broker/" + dataBannerList[i].img,
                  width: 650.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
      ],
      options: CarouselOptions(
        height: 450.w,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
      ),
    );
  }

  SizedBox shimmerBanner() {
    return SizedBox(
      width: 670.w,
      height: 400.w,
      child: Shimmer.fromColors(
        child: Container(
          height: 400.w,
          width: 670.w,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[300],
      ),
    );
  }

  buildListTopBroker(List<DataListBroker> dataBrokerList) {
    if (dataBrokerList.length == 0) {
      return Container(
        margin: EdgeInsets.only(top: 40.w),
        height: 450.w,
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/empty.svg',
              height: 300.w,
              width: 300.w,
            ),
            SizedBox(height: 40.w),
            Text(
              "Ooops, Data Not Found",
              style: TextStyle(
                fontFamily: "Nunito-ExtraBold",
                fontSize: 35.ssp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: dataBrokerList.length,
        itemBuilder: (context, index) {
          DataListBroker dataBroker = dataBrokerList[index];
          int no = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          DetailTopBrokerPage(broker: dataBroker.broker)));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 15.w),
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        no.toString() + ".",
                        style: TextStyle(
                          fontFamily: "Nunito-ExtraBold",
                          fontSize: 25.ssp,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Container(
                        width: 50.w,
                        height: 50.w,
                        child: Image.network(
                          kMasterUrl + "img/broker/" + dataBroker.img,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        dataBroker.name,
                        style: TextStyle(
                          fontFamily: "Nunito-ExtraBold",
                          fontSize: 25.ssp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: kPrimaryColor,
                        size: 30.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        dataBroker.rate,
                        style: TextStyle(
                          fontFamily: "Nunito-ExtraBold",
                          fontSize: 25.ssp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(8.w, 21.w),
                    blurRadius: 53.w,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  // GestureDetector buildItemTop1(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         CupertinoPageRoute(
  //           builder: (context) => DetailTopForexPage(
  //             broker: "FBS",
  //           ),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       padding: EdgeInsets.all(40.w),
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               color: Colors.amber,
  //               width: 100.w,
  //               height: 100.w,
  //               child: Image.asset(
  //                 'assets/images/fbs.jpg',
  //                 fit: BoxFit.fitWidth,
  //               ),
  //             ),
  //             SizedBox(height: 10.w),
  //             Text(
  //               "FBS",
  //               style: TextStyle(
  //                 fontFamily: "Nunito-ExtraBold",
  //                 fontSize: 30.ssp,
  //               ),
  //             ),
  //             SizedBox(height: 10.w),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 RatingBar(
  //                   itemSize: 35.w,
  //                   onRatingUpdate: null,
  //                   initialRating: 4.5,
  //                   minRating: 1,
  //                   direction: Axis.horizontal,
  //                   allowHalfRating: true,
  //                   itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
  //                   itemBuilder: (context, _) => Icon(
  //                     Icons.star,
  //                     color: kPrimaryColor,
  //                   ),
  //                 ),
  //                 SizedBox(width: 10.w),
  //                 Text(
  //                   "4.5",
  //                   style: TextStyle(
  //                     fontFamily: "Nunito-ExtraBold",
  //                     fontSize: 25.ssp,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10.w),
  //         boxShadow: [
  //           BoxShadow(
  //             offset: Offset(8.w, 21.w),
  //             blurRadius: 53.w,
  //             color: Colors.black.withOpacity(0.05),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Container buildItem() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 15.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Row(
  //           children: <Widget>[
  //             Text(
  //               "2.",
  //               style: TextStyle(
  //                 fontFamily: "Nunito-ExtraBold",
  //                 fontSize: 25.ssp,
  //               ),
  //             ),
  //             SizedBox(width: 20.w),
  //             Container(
  //               color: Colors.amber,
  //               width: 50.w,
  //               height: 50.w,
  //               child: Image.asset(
  //                 'assets/images/fbs.jpg',
  //                 fit: BoxFit.fitWidth,
  //               ),
  //             ),
  //             SizedBox(width: 20.w),
  //             Text(
  //               "OctaFx",
  //               style: TextStyle(
  //                 fontFamily: "Nunito-ExtraBold",
  //                 fontSize: 25.ssp,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: <Widget>[
  //             Icon(
  //               Icons.star,
  //               color: kPrimaryColor,
  //               size: 30.w,
  //             ),
  //             SizedBox(width: 5.w),
  //             Text(
  //               "4.2",
  //               style: TextStyle(
  //                 fontFamily: "Nunito-ExtraBold",
  //                 fontSize: 25.ssp,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10.w),
  //       boxShadow: [
  //         BoxShadow(
  //           offset: Offset(8.w, 21.w),
  //           blurRadius: 53.w,
  //           color: Colors.black.withOpacity(0.05),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kBackgroundColor,
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
        "Top Broker",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
