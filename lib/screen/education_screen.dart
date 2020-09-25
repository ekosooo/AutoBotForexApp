import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalforex/model/education_list_model.dart';
import 'package:signalforex/screen/education_detail_materi.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/widget/coming_soon.dart';
import 'package:signalforex/widget/no_data_record.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:shimmer/shimmer.dart';

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

  Future getEducation(String endPoint) async {
    final String baseUrl = kBaseUrlApi + 'education';
    final response = await http.post('$baseUrl', body: {'category': endPoint});
    if (response.statusCode == 200) {
      return Education.fromJson(response.body);
    } else {
      return Exception('Fail to load data');
    }
  }

  Future refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
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
          buildEducation('basic'),
          buildEducation('technical'),
          ComingSoon(),
          buildEducation('capital'),
          buildEducation('psycology'),
          ComingSoon(),
        ],
      ),
    );
  }

  buildEducation(String endPoint) {
    return Container(
      margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 10),
      child: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: refreshData,
        child: FutureBuilder(
          future: getEducation(endPoint),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: SomethingWrong(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.status == 'success') {
                return buildMateri(snapshot.data.data);
              } else {
                return Center(
                  child: SomethingWrong(),
                );
              }
            } else {
              return Column(
                children: <Widget>[
                  shimmerMateri(),
                  shimmerMateri(),
                  shimmerMateri(),
                  shimmerMateri(),
                  shimmerMateri(),
                ],
              );
            }
          },
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
          ),
        ),
      ),
    );
  }
}

buildMateri(List<DataEducation> dataEducationList) {
  if (dataEducationList.length == 0) {
    return NoDataRecord();
  } else {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: dataEducationList.length,
      itemBuilder: (BuildContext context, int index) {
        DataEducation dataEducation = dataEducationList[index];
        int no = index + 1;
        return Container(
          margin: EdgeInsets.only(top: 25.w),
          height: 205.w,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EducationDetailPage(link: dataEducation.link)));
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
                            padding: EdgeInsets.symmetric(
                                vertical: 20.w, horizontal: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  dataEducation.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Nunito-ExtraBold",
                                    fontSize: 27.ssp,
                                    color: kTextColor,
                                    height: 2.w,
                                  ),
                                ),
                                SizedBox(height: 5.w),
                                Text(
                                  dataEducation.desc,
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
                          offset: Offset(8.w, 21.w),
                          blurRadius: 35.w,
                          color: Colors.black.withOpacity(0.05),
                        ),
                      ],
                    ),
                  ),
                ),
                //number of content
                Positioned(
                  top: 0,
                  left: 20.w,
                  child: Container(
                    height: 180.w,
                    width: 135.w,
                    child: Center(
                      child: Text(
                        (no.toString().length > 1)
                            ? no.toString()
                            : '0' + no.toString(),
                        style: TextStyle(
                          fontFamily: 'Nunito-Bold',
                          fontSize: 50.ssp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, Colors.teal[700]],
                        // begin: Alignment.topCenter,
                        // end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10.w),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(8.w, 21.w),
                          blurRadius: 35.w,
                          color: Colors.black.withOpacity(0.05),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

shimmerMateri() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[200],
    highlightColor: Colors.grey[300],
    child: Container(
      margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
      width: double.infinity,
      height: 180.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
    ),
  );
}
