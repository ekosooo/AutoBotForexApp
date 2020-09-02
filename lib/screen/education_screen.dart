import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalforex/screen/education_detail_materi.dart';

class EducationPage extends StatefulWidget {
  EducationPageState createState() => EducationPageState();
}

class EducationPageState extends State<EducationPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 10),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                buildMateri(),
                buildMateri(),
                buildMateri(),
                buildMateri(),
                buildMateri(),
                buildMateri(),
                buildMateri(),
                buildMateri(),
              ],
            ),
          ),
          Text("AA"),
          Text("AA"),
          Text("AA"),
          Text("AA"),
          Text("AA"),
        ],
      ),
    );
  }

  Container buildMateri() {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      height: 205.w,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EducationDetailPage()));
        },
        child: Stack(
          children: <Widget>[
            //content
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                height: 150.w,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: Container(
                        //color: Colors.red,
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tipe dari ten, grafik dan peraturan penyusunan grafik",
                              style: TextStyle(
                                fontFamily: "Nunito-ExtraBold",
                                fontSize: 27.ssp,
                                color: kTextColor,
                                height: 2.w,
                              ),
                            ),
                            SizedBox(height: 5.w),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 22.ssp,
                                color: kTextLightColor,
                                height: 2.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.w),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3.w, 21.w),
                      blurRadius: 20.w,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
              ),
            ),
            //image cover content
            Positioned(
              top: 0,
              left: 20.w,
              child: Container(
                height: 180.w,
                width: 135.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: Image.asset(
                    'assets/images/cover_book.png',
                    fit: BoxFit.fill,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.w),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(8.w, 21.w),
                      blurRadius: 20.w,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
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
        "Education",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
      bottom: TabBar(
        indicatorColor: kPrimaryColor,
        controller: _tabController,
        isScrollable: true,
        unselectedLabelColor: kTextLightColor,
        unselectedLabelStyle:
            TextStyle(fontSize: 22.ssp, fontFamily: "Nunito-bold"),
        labelColor: kTextColor,
        labelStyle: TextStyle(fontSize: 27.ssp, fontFamily: "Nunito-ExtraBold"),
        tabs: [
          buildTab("Basic Forex"),
          buildTab("Technical Analysis"),
          buildTab("Fundamental"),
          buildTab("Capital and Risk Management"),
          buildTab("Trading Psycology"),
          buildTab("Videos"),
        ],
      ),
    );
  }

  Tab buildTab(String _title) {
    return Tab(
      child: Container(
        child: Center(
          child: Text(
            _title,
            // style: TextStyle(
            //   fontFamily: "Nunito-bold",
            //   fontSize: 25.ssp,
            //   //color: kTextColor,
            // ),
          ),
        ),
      ),
    );
  }
}
