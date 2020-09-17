import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class IndicatorDetailPage extends StatefulWidget {
  final String idIndi;
  const IndicatorDetailPage(this.idIndi);
  @override
  IndicatorDetailPageState createState() => IndicatorDetailPageState();
}

class IndicatorDetailPageState extends State<IndicatorDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  PlayerState _playerState;

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    //_controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1344);
    var textContentStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 25.ssp,
      color: kTextLightColor,
    );
    var textTitleStyle = TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      fontSize: 30.ssp,
      color: kTextColor,
    );
    Size size = MediaQuery.of(context).size;
    return YoutubePlayerBuilder(
      // onEnterFullScreen: () {
      //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
      //   SystemChrome.setPreferredOrientations([
      //     DeviceOrientation.landscapeLeft,
      //     DeviceOrientation.landscapeRight
      //   ]);
      // },
      // onExitFullScreen: () {
      //   SystemChrome.setPreferredOrientations(
      //       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      // },
      player: youtubeVideo("h_K5sgc_lcs"),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(23, 40, 59, 1),
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // -------- container content --------
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
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
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
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
                              for (var i = 0; i < 5; i++)
                                Text(
                                  '-  Lorem Ipsum is simply dummy text',
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
                                "Rule",
                                style: textTitleStyle,
                              ),
                              SizedBox(height: 10.w),
                              for (var i = 0; i < 5; i++)
                                Text(
                                  '-  Lorem Ipsum is simply dummy text',
                                  style: textContentStyle,
                                ),
                            ],
                          ),
                        ),

                        //------------ Video --------------
                        SizedBox(height: 30.w),
                        Container(
                          margin: EdgeInsets.only(left: 35.w, right: 35.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Video',
                                style: textTitleStyle,
                              ),
                              SizedBox(height: 10.w),
                              Container(
                                height: 350.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.w),
                                  child: player,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //------------ screenshoot title ----------
                        SizedBox(height: 30.w),
                        Container(
                          margin: EdgeInsets.only(left: 35.w),
                          child: Text(
                            'Screenshot',
                            style: textTitleStyle,
                          ),
                        ),

                        //------ screenshot item ----------
                        SizedBox(height: 10.w),
                        Container(
                          height: 400.w,
                          margin: EdgeInsets.only(left: 35.w),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: Hero(
                                  tag: index,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    width: 250.w,
                                    child: Image.network(
                                      'https://i2.wp.com/synapsetrading.com/wp-content/uploads/2015/09/2015-09-04-21.10.17.png?ssl=1',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return DetailImage(index);
                                  }));
                                },
                              );
                            },
                          ),
                        ),

                        //------ button ---------------
                        SizedBox(height: 30.w),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Row(
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 50.w,
                                height: 80.w,
                                buttonColor: kPrimaryColor,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    // launchURL("https://t.me/ekosooo");
                                  },
                                  child: Icon(
                                    FeatherIcons.send,
                                    size: 40.w,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: ButtonTheme(
                                  height: 80.w,
                                  child: RaisedButton(
                                    color: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                    onPressed: () {
                                      // launchURL("https://t.me/ekosooo");
                                    },
                                    child: Text(
                                      'BUY',
                                      style: TextStyle(
                                        fontFamily: 'Nunito-SemiBold',
                                        fontSize: 30.ssp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // --------- bottom margin -----
                        SizedBox(height: 20.w),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 35.w, top: 50.w, right: 110.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //----- text product
                        Text(
                          'Indicator',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 30.ssp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'iGodZilla',
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
                              '4.5',
                              style: TextStyle(
                                fontFamily: 'Nunito-Bold',
                                fontSize: 32.ssp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // ------- image product ------

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 80.w),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 30.ssp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\$200',
                                  style: TextStyle(
                                    fontFamily: 'Nunito-Bold',
                                    fontSize: 40.ssp,
                                    color: Colors.white,
                                  ),
                                ),

                                //----------- like ------
                                Container(
                                  margin: EdgeInsets.only(top: 30.w),
                                  height: 90.w,
                                  width: 90.w,
                                  child: Icon(
                                    FeatherIcons.heart,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle,
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
                            Container(
                              width: 270.w,
                              height: 370.w,
                              child: Hero(
                                tag: widget.idIndi,
                                child: Image.asset(
                                  'assets/images/superfx.png',
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
        ),
      ),
    );
  }

  youtubeVideo(String idVideo) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: idVideo,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: true,
          enableCaption: true,
        ),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
    );
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
      // actions: <Widget>[
      //   Padding(
      //     padding: EdgeInsets.only(right: 35.w),
      //     child: Icon(
      //       FeatherIcons.heart,
      //       color: kTextColor,
      //     ),
      //   ),
      // ],
    );
  }
}

class DetailImage extends StatelessWidget {
  final int index;
  const DetailImage(this.index);
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
              tag: index,
              child: Container(
                // color: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
                child: PhotoView(
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.5,
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  imageProvider: NetworkImage(
                    'https://i2.wp.com/synapsetrading.com/wp-content/uploads/2015/09/2015-09-04-21.10.17.png?ssl=1',
                  ),
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          }),
    );
  }
}
