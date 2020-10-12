import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:signalforex/func_global.dart';
import 'package:signalforex/model/ea_detail_model.dart';
import 'package:signalforex/model/ea_list_model.dart';
import 'package:signalforex/screen/form_subscribe_ea_screen.dart';
import 'package:signalforex/widget/no_data_record.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';

final GlobalKey<ScaffoldState> scaffoldStateDialog =
    new GlobalKey<ScaffoldState>();

class EAForexDetailPage extends StatefulWidget {
  final String idEA;
  const EAForexDetailPage(this.idEA);
  EAForexDetailPageState createState() => EAForexDetailPageState();
}

class EAForexDetailPageState extends State<EAForexDetailPage> {
  bool isLoading = true;

  Future getDetailEA() async {
    final String baseUrl = kBaseUrlApi + 'tools/EA/detail';
    final response = await http.post(
      '$baseUrl',
      body: {'idTools': widget.idEA},
    );

    if (response.statusCode == 200) {
      return DetailEA.fromJson(response.body);
    } else {
      throw Exception('Fail load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return Scaffold(
      key: scaffoldStateDialog,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(23, 40, 59, 1),
      appBar: buildAppBar(context),
      body: FutureBuilder(
        future: getDetailEA(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SomethingWrong(textColor: 'white'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.status == 'success') {
              return buildDetailEA(context, snapshot.data.data);
            } else {
              return SomethingWrong(textColor: 'white');
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  buildDetailEA(BuildContext context, List<DataDetailEA> dataDetailEAList) {
    if (dataDetailEAList.length == 0) {
      return NoDataRecord();
    } else {
      var textContentStyle = TextStyle(
        fontFamily: 'Nunito',
        fontSize: 26.ssp,
        color: kTextLightColor,
      );
      var textTitleStyle = TextStyle(
        fontFamily: 'Nunito-ExtraBold',
        fontSize: 30.ssp,
        color: kTextColor,
      );

      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // -------- container content --------
                Container(
                  margin: EdgeInsets.only(top: 390.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.w),
                      topRight: Radius.circular(45.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //------- Container introduction ------------------
                      SizedBox(height: 170.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Text(
                          dataDetailEAList[0].desc,
                          textAlign: TextAlign.justify,
                          style: textContentStyle,
                        ),
                      ),

                      //------ Container text fitur --------------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Fitur",
                              style: textTitleStyle,
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              dataDetailEAList[0].fitur,
                              style: textContentStyle,
                            ),
                          ],
                        ),
                      ),

                      //------ Container text fitur --------------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Recommendation",
                              style: textTitleStyle,
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              dataDetailEAList[0].recom,
                              style: textContentStyle,
                            ),
                          ],
                        ),
                      ),

                      //------------ backtest titlel ---------
                      SizedBox(height: 30.w),
                      Container(
                        margin: EdgeInsets.only(left: 35.w),
                        child: Text(
                          'Backtest',
                          style: textTitleStyle,
                        ),
                      ),

                      //---------- backtest -----------
                      SizedBox(height: 10.w),
                      Container(
                        height: 300.w,
                        margin: EdgeInsets.only(left: 35.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dataDetailEAList[0].backtest.length,

                          // ignore: missing_return
                          itemBuilder: (BuildContext context, int index) {
                            String idVideo = YoutubePlayer.convertUrlToId(
                                dataDetailEAList[0].backtest[index].url);
                            //-- untuk return video
                            if (dataDetailEAList[0].backtest[index].cat ==
                                'VIDEO') {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PlayVideo(
                                        title: 'Backtest EA ' +
                                            dataDetailEAList[0].name,
                                        idVideo: idVideo,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20.w),
                                  width: 550.w,
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.w),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        dataDetailEAList[0]
                                            .backtest[0]
                                            .thumbnail,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            } else if (dataDetailEAList[0]
                                    .backtest[index]
                                    .cat ==
                                'IMG') {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailImage(
                                          url: dataDetailEAList[0]
                                              .backtest[index]
                                              .url),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: dataDetailEAList[0].backtest[index].url,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    width: 550.w,
                                    child: Image.network(
                                      dataDetailEAList[0].backtest[index].url,
                                      fit: BoxFit.cover,
                                    ),
                                    decoration: BoxDecoration(
                                      //color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),

                      //------------ screenshoot title ----------

                      (dataDetailEAList[0].ss.length == 0)
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(left: 35.w, top: 30.w),
                              child: Text(
                                'Screenshot',
                                style: textTitleStyle,
                              ),
                            ),

                      //------ screenshot item ----------
                      (dataDetailEAList[0].ss.length == 0)
                          ? Container()
                          : Container(
                              height: 400.w,
                              margin: EdgeInsets.only(left: 35.w, top: 10.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: dataDetailEAList[0].ss.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: Hero(
                                      tag: index,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.w),
                                        width: 300.w,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: Text(
                                            '$index',
                                            style: textTitleStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) {
                                      //       //return DetailImage(index);
                                      //     },
                                      //   ),
                                      // );
                                    },
                                  );
                                },
                              ),
                            ),

                      //------ button ---------------
                      SizedBox(height: 80.w),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 100.w,
                              height: 100.w,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.black.withOpacity(0.1),
                                  onTap: () {
                                    FunctionGlobal().launchURL(
                                        'https://t.me/SignalForex889');
                                  },
                                  child: Center(
                                    child: Icon(
                                      FeatherIcons.send,
                                      size: 35.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(18.w),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 21.w),
                                    blurRadius: 35.w,
                                    color: kPrimaryColor.withOpacity(0.25),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30.w),
                            Expanded(
                              child: Container(
                                height: 100.w,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.black.withOpacity(0.1),
                                    onTap: () {
                                      // showDialogForm(
                                      //     context,
                                      //     dataDetailEAList[0].product,
                                      //     widget.idEA);
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              FormSubscribeEAPage(
                                            idEA: widget.idEA,
                                            nameEA: dataDetailEAList[0].name,
                                            rateEA: dataDetailEAList[0].rate,
                                            urlImgEA: dataDetailEAList[0].img,
                                            productList:
                                                dataDetailEAList[0].product,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Subscribe',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 28.ssp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(18.w),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 21.w),
                                      blurRadius: 35.w,
                                      color: kPrimaryColor.withOpacity(0.25),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --------- bottom margin -----
                      SizedBox(height: 60.w),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.w, right: 110.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //----- text product
                      Text(
                        'Expert Advisor',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 30.ssp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        dataDetailEAList[0].name,
                        style: TextStyle(
                          fontFamily: 'Nunito-ExtraBold',
                          fontSize: 55.ssp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 38.w,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            dataDetailEAList[0].rate,
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 32.ssp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // ------- price product ------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20.w),
                              Text(
                                'Price',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 30.ssp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontFamily: 'Nunito-Bold',
                                  fontSize: 40.ssp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '*for affiliate',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 20.ssp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // ------- img product ------
                          Container(
                            width: 250.w,
                            height: 350.w,
                            child: Hero(
                              tag: widget.idEA,
                              child: Image.network(
                                dataDetailEAList[0].img,
                                fit: BoxFit.fill,
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(10.w, 21.w),
                                  blurRadius: 30.w,
                                  color: Colors.black.withOpacity(0.08),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}

// -- play video --
// ignore: must_be_immutable
class PlayVideo extends StatefulWidget {
  String title;
  String idVideo;
  PlayVideo({Key key, this.title, this.idVideo}) : super(key: key);
  @override
  PlayVideoState createState() => PlayVideoState();
}

class PlayVideoState extends State<PlayVideo> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  YoutubePlayerController controller;
  YoutubeMetaData videoMetaData;
  bool isPlayerReady = false;
  PlayerState playerState;

  void listener() {
    if (isPlayerReady && mounted && !controller.value.isFullScreen) {
      setState(() {
        playerState = controller.value.playerState;
        videoMetaData = controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    //controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.idVideo,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        key: scaffoldKey,
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
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Nunito-ExtraBold',
              fontSize: 30.ssp,
            ),
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 35.0),
            child: player,
          ),
        ),
      ),
    );
  }
}

//-- detail image class --
class DetailImage extends StatelessWidget {
  final String url;
  DetailImage({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              // color: Colors.grey[300],
              // width: 600.w,
              // height: 900.w,
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
