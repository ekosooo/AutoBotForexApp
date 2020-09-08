import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/model/top_broker_model.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailTopBrokerPage extends StatelessWidget {
  final broker;
  const DetailTopBrokerPage({Key key, this.broker}) : super(key: key);

  Future getDetailBroker() async {
    final String baseUrl = "http://192.168.100.5:8000/api/broker/detail";
    final response = await http.post("$baseUrl", body: {"brokerID": broker});
    if (response.statusCode == 200) {
      return TopBroker.fromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  launchURL(String url) async {
    //const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: FutureBuilder(
          future: getDetailBroker(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: SomethingWrong(
                    textColor: 'black',
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<DataBroker> dataBroker = snapshot.data.data;
              return buildContent(dataBroker);
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  ),
                ),
              );
            }
          }),
    );
  }

  ListView buildContent(List<DataBroker> dataBroker) {
    var textStyleTitle = TextStyle(
      fontFamily: "Nunito-ExtraBold",
      fontSize: 27.ssp,
      color: kTextColor,
    );
    var textStyleContent = TextStyle(
      fontFamily: "Nunito",
      fontSize: 25.ssp,
      color: kTextLightColor,
    );
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // container content
        Container(
          padding: EdgeInsets.all(20.w),
          margin: EdgeInsets.only(left: 35.w, right: 35.w, bottom: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //------------------ logo broker and rating ----------------
              Container(
                padding: EdgeInsets.symmetric(vertical: 40.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //color: Colors.amber,
                        width: 100.w,
                        height: 100.w,
                        child: Image.network(
                          'http://192.168.100.5:8000/images/broker/' +
                              dataBroker[0].brokerImg,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        dataBroker[0].brokerName,
                        style: TextStyle(
                          fontFamily: "Nunito-ExtraBold",
                          fontSize: 30.ssp,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RatingBar(
                            itemSize: 35.w,
                            onRatingUpdate: null,
                            initialRating: dataBroker[0].brokerRate,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            dataBroker[0].brokerRate.toString(),
                            style: TextStyle(
                              fontFamily: "Nunito-ExtraBold",
                              fontSize: 25.ssp,
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          launchURL(dataBroker[0].brokerAffiliate);
                        },
                        elevation: 0.0,
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontFamily: "Nunito-ExtraBold",
                            fontSize: 22.ssp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //----------------------- indroduction -----------
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Introduction",
                      style: textStyleTitle,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      dataBroker[0].brokerIntro,
                      textAlign: TextAlign.justify,
                      style: textStyleContent,
                    ),
                  ],
                ),
              ),

              //------------------- regulation and brokerage model --------------
              Container(
                margin: EdgeInsets.only(top: 30.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Regulation",
                            style: textStyleTitle,
                          ),
                          SizedBox(height: 10.w),
                          Text(
                            dataBroker[0].brokerRegulation,
                            style: textStyleContent,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Brokerage Model",
                            style: textStyleTitle,
                          ),
                          SizedBox(height: 10.w),
                          Text(
                            dataBroker[0].brokerModel,
                            style: textStyleContent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //--------------- Demo Account ----------------------
              Container(
                margin: EdgeInsets.only(top: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Demo Account",
                      style: textStyleTitle,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      dataBroker[0].brokerDemo,
                      style: textStyleContent,
                    ),
                  ],
                ),
              ),

              //------------ Deposit minimal & Founding Methods ---------
              Container(
                margin: EdgeInsets.only(top: 30.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Min Deposit",
                            style: textStyleTitle,
                          ),
                          SizedBox(height: 10.w),
                          Text(
                            dataBroker[0].brokerMinDepo,
                            style: textStyleContent,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Founding Methods",
                            style: textStyleTitle,
                          ),
                          SizedBox(height: 10.w),
                          Text(
                            dataBroker[0].brokerFound,
                            style: textStyleContent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //--------------- pros --------------
              Container(
                margin: EdgeInsets.only(top: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pros",
                      style: textStyleTitle,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      dataBroker[0].brokerPros,
                      style: textStyleContent,
                    ),
                  ],
                ),
              ),

              //------------- Cros -----------------
              Container(
                margin: EdgeInsets.only(top: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Cros",
                      style: textStyleTitle,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      dataBroker[0].brokerCros,
                      style: textStyleContent,
                    ),
                  ],
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
                blurRadius: 53.w,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.w),
        buildPromo(dataBroker[0].brokerPromo),
      ],
    );
  }

  buildPromo(List<BrokerPromo> brokerPromo) {
    if (brokerPromo.length != 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
            ),
            child: Text(
              "Promo",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 25.ssp,
                color: kTextLightColor,
              ),
            ),
          ),
          SizedBox(height: 10.w),
          ListView.builder(
            shrinkWrap: true,
            itemCount: brokerPromo.length,
            itemBuilder: (BuildContext context, int index) {
              BrokerPromo dataPromo = brokerPromo[index];
              return GestureDetector(
                onTap: () {
                  launchURL(dataPromo.prmBrokerLink);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 35.w, right: 35.w, bottom: 15.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 150.w,
                        width: 150.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
                          child: Image.network(
                            "http://192.168.100.5:8000/images/promo/" +
                                dataPromo.prmBrokerImg,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                dataPromo.prmBrokerTitle,
                                style: TextStyle(
                                  fontFamily: "Nunito-Bold",
                                  fontSize: 25.ssp,
                                  color: kTextColor,
                                ),
                              ),
                              Text(
                                dataPromo.prmBrokerCaption,
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 22.ssp,
                                  color: kTextLightColor,
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
                        blurRadius: 21.w,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[],
      );
    }
  }

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
        "Detail Broker",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }
}
