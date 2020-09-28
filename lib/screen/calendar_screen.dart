import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signalforex/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signalforex/model/calendar_news_model.dart';
import 'package:signalforex/widget/something_wrong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool _isALL = true;
bool _isHigh = false;
bool _isMedium = false;
bool _isLow = false;
//arr impact news
List<String> arrImpact = ["Low", "Medium", "High"];

EventList<Event> _markedDateMap = EventList<Event>();
CalendarCarousel _calendarCarousel;

class CalendarPage extends StatefulWidget {
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  FlutterLocalNotificationsPlugin flutterNotif;

  bool _flagEventToDay = true;
  DateTime dateSelectedEvent;

  CalendarNews calendarNews = CalendarNews();
  Future<List> futureCalendar;

  @override
  void initState() {
    super.initState();
    _markedDateMap.clear();
    this.getDataFromAPI(DateTime.now());

    //-- local notif -----
    var androidInitilize = AndroidInitializationSettings('launcher_icon_dark');
    var iOSInitilize = IOSInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(androidInitilize, iOSInitilize);
    flutterNotif = FlutterLocalNotificationsPlugin();
    flutterNotif.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  void refresh(DateTime date) {
    _currentDate = date;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    _calendarCarousel = CalendarCarousel<Event>(
      /// Example Calendar Carousel without header and custom prev & next button
      todayBorderColor: Colors.white,
      onDayPressed: (DateTime date, events) {
        this.setState(() => refresh(date));
        _flagEventToDay = false;
        dateSelectedEvent = date;
      },
      daysHaveCircularBorder: null,
      showOnlyCurrentMonthDate: false,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle: TextStyle(
        color: kPrimaryColor,
        fontFamily: "Nunito-Bold",
        fontSize: 25.ssp,
      ),
      pageScrollPhysics: NeverScrollableScrollPhysics(),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: true,
      showHeader: true,
      iconColor: kPrimaryColor,
      headerTextStyle: TextStyle(
        color: kPrimaryColor,
        fontFamily: "Nunito-ExtraBold",
        fontSize: 30.ssp,
      ),
      //markedDatesMap: main.getMarkCalendar(),
      height: 270.w,
      headerMargin: EdgeInsets.symmetric(vertical: 2.0),
      selectedDateTime: _currentDate,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      todayTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "Nunito-Bold",
      ),
      todayButtonColor: kPrimaryColor,
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 18.ssp,
        color: kPrimaryColor.withOpacity(0.5),
        fontFamily: "Nunito-Bold",
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 18.ssp,
        color: kPrimaryColor.withOpacity(0.5),
        fontFamily: "Nunito-Bold",
      ),
      daysTextStyle: TextStyle(
        color: kPrimaryColor,
        fontFamily: "Nunito-Bold",
        fontSize: 25.ssp,
      ),
      weekendTextStyle: TextStyle(
        color: kPrimaryColor,
        fontFamily: "Nunito-Bold",
        fontSize: 25.ssp,
      ),
      selectedDayButtonColor: kPrimaryColor.withOpacity(0.08),
      onCalendarChanged: (DateTime date) {
        // this.setState(() {
        _markedDateMap.clear();
        getDataFromAPI(date);
        _targetDateTime = date;
        _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        // });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    //---------------------------------------------

    return Scaffold(
      key: scaffoldState,
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: Container(
        child: FutureBuilder<List>(
          future: futureCalendar,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.w),
                  child: SomethingWrong(
                    textColor: "black",
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return buildSlidingUpPanel();
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
    );
  }

  buildSlidingUpPanel() {
    return SlidingUpPanel(
      minHeight: 950.w,
      maxHeight: 950.w,
      backdropEnabled: false,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(35.w), topLeft: Radius.circular(35.w)),
      panel: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 35.w, top: 50.w, right: 35.w),
        decoration: BoxDecoration(
          // color: kPrimaryColor,
          color: kPrimaryColor.withOpacity(0.93),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35.w), topLeft: Radius.circular(35.w)),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            buildLineSwipeUp(),
            SizedBox(height: 30.w),
            buildFilterButton(),
            SizedBox(height: 30.w),
            Container(
              child: FutureBuilder<List>(
                future: futureCalendar,
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasError) {
                    return SomethingWrong(
                      textColor: "black",
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<CalendarNews> calendarNewsData = snapshot.data;
                    if (_flagEventToDay) {
                      return buildListNews(calendarNewsData, DateTime.now());
                    } else {
                      return buildListNews(calendarNewsData, dateSelectedEvent);
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
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 270.w,
            margin: EdgeInsets.symmetric(horizontal: 35.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  offset: Offset(8.w, 21.w),
                  blurRadius: 53.w,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: _calendarCarousel,
          ),
        ],
      ),
    );
  }

  Container buildListNews(
      List<CalendarNews> calendarNewsData, DateTime dateSelected) {
    List<CalendarNews> filterNewsList = [];
    //filter data berdasarkan tanggal
    String dateSelectedStr = dateSelected.toString().substring(0, 10);

    if (_isALL) {
      filterNewsList = calendarNewsData
          .where((data) => data.date.toString().contains(dateSelectedStr))
          .toList();
    } else {
      filterNewsList = calendarNewsData
          .where((data) =>
              data.date.toString().contains(dateSelectedStr) &&
              ((data.impact.contains("High") && _isHigh == true) ||
                  (data.impact.contains("Medium") && _isMedium == true) ||
                  (data.impact.contains("Low") && _isLow == true)))
          .toList();
    }

    // sorting data berdsarkan tanggal
    filterNewsList.sort((a, b) => a.date.compareTo(b.date));

    if (filterNewsList.length == 0) {
      return buildEmptyRecords();
    } else {
      return Container(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 0.0,
            );
          },
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: filterNewsList.length,
          itemBuilder: (context, index) {
            CalendarNews calendarNewsBuilder = filterNewsList[index];
            String dateNews =
                calendarNewsBuilder.date.toString().substring(0, 10);
            String timeNews =
                calendarNewsBuilder.date.toString().substring(11, 16);

            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.2,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Set Alarm',
                  color: kPrimaryColor.withOpacity(0.1),
                  icon: FeatherIcons.clock,
                  foregroundColor: Colors.white,
                  onTap: () {
                    showDialogAlarm(
                      calendarNewsBuilder.title,
                      calendarNewsBuilder.impact,
                      calendarNewsBuilder.date,
                    );
                  },
                ),
              ],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
                // margin: EdgeInsets.only(bottom: 10.w),
                color: kPrimaryColor,
                // decoration: BoxDecoration(
                //   //color: Colors.white.withOpacity(0.08),
                //   color: kPrimaryColor,
                //   // borderRadius: BorderRadius.circular(10.w),
                // ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          calendarNewsBuilder.title,
                          style: TextStyle(
                            fontFamily: "Nunito-Bold",
                            fontSize: 25.ssp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          calendarNewsBuilder.country,
                          style: TextStyle(
                            fontFamily: "Nunito-Bold",
                            fontSize: 25.ssp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dateNews + " " + timeNews,
                              style: TextStyle(
                                fontFamily: "Nunito-Light",
                                fontSize: 20.ssp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Container(
                              height: 40.w,
                              width: 93.w,
                              child: Center(
                                child: Text(
                                  calendarNewsBuilder.impact,
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 20.ssp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: boxDecorationImpact(
                                calendarNewsBuilder.impact,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              calendarNewsBuilder.actual == ''
                                  ? "-"
                                  : calendarNewsBuilder.actual,
                              style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 22.ssp,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              "Actual",
                              style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 22.ssp,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              calendarNewsBuilder.forecast == ''
                                  ? '-'
                                  : calendarNewsBuilder.forecast,
                              style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 22.ssp,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              "Forecast",
                              style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 22.ssp,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              calendarNewsBuilder.previous == ''
                                  ? '-'
                                  : calendarNewsBuilder.previous,
                              style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 22.ssp,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              "Previous",
                              style: TextStyle(
                                  fontFamily: "Nunito-Light",
                                  fontSize: 22.ssp,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Container buildEmptyRecords() {
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
            "Ooops, News Not Found",
            style: TextStyle(
              fontFamily: "Nunito-ExtraBold",
              fontSize: 35.ssp,
              color: Colors.white,
            ),
          ),
          Text(
            "Try choosing another date or news impact",
            style: TextStyle(
              fontFamily: "Nunito-SemiBold",
              fontSize: 25.ssp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  //dialog set alarm
  void showDialogAlarm(String titleNews, String impact, DateTime timeNews) {
    int valueSelected = 0;
    int second = 60;
    var textStyleDropDown = TextStyle(
      fontFamily: "Nunito-Bold",
      fontSize: 25.ssp,
      color: kPrimaryColor,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('Set Alarm'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Reminders',
                    style: TextStyle(
                      fontFamily: 'Nunito-Bold',
                      fontSize: 30.ssp,
                      color: kTextLightColor,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Icon(
                    FeatherIcons.clock,
                    color: kPrimaryColor,
                    size: 80.w,
                  ),
                  SizedBox(height: 20.w),
                  Text(
                    'When will we remind you before the release of the news ' +
                        titleNews +
                        ' with ' +
                        impact.toLowerCase() +
                        ' impact ' +
                        timeNews.toString().substring(0, 10) +
                        ' ' +
                        timeNews.toString().substring(11, 16) +
                        ' ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24.ssp,
                      color: kTextLightColor,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Time : ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 25.ssp,
                          color: kTextLightColor,
                        ),
                      ),
                      DropdownButton(
                        //isExpanded: true,
                        underline: SizedBox(),
                        value: valueSelected,
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Text(
                              "1 Minute",
                              style: textStyleDropDown,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "5 Minute",
                              style: textStyleDropDown,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "10 Minute",
                              style: textStyleDropDown,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(
                              "30 Minute",
                              style: textStyleDropDown,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text(
                              "1 Hour",
                              style: textStyleDropDown,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            valueSelected = value;
                          });
                          if (valueSelected == 0) {
                            second = 60;
                          } else if (valueSelected == 1) {
                            second = 300;
                          } else if (valueSelected == 2) {
                            second = 600;
                          } else if (valueSelected == 3) {
                            second = 1800;
                          } else if (valueSelected == 4) {
                            second = 3600;
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No, Cancel',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24.ssp,
                  color: Colors.red,
                ),
              ),
            ),
            FlatButton(
              color: kPrimaryColor,
              child: Text(
                'Yes, Set Alarm',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24.ssp,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setNotification(timeNews, second, titleNews);
                scaffoldState.currentState.showSnackBar(
                  SnackBar(
                    content: Text("succes set the alarm.."),
                    action: SnackBarAction(
                        label: 'Close',
                        textColor: kPrimaryColor,
                        onPressed: () {
                          scaffoldState.currentState.hideCurrentSnackBar();
                        }),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //--- send local notif ----
  Future setNotification(
      DateTime timeNews, int seconds, String titleNews) async {
    DateTime scheduledTime = timeNews.subtract(Duration(seconds: seconds));
    //DateTime scheduledTime = DateTime.now().add(Duration(minutes: 2));
    var idSchedule = DateTime.now().millisecondsSinceEpoch;
    var androidDetails = AndroidNotificationDetails(
        'signal_forex', 'signal_froex', 'singal forex',
        sound: RawResourceAndroidNotificationSound('newstime'),
        playSound: true,
        priority: Priority.High,
        importance: Importance.Max);
    var iOSDetails = IOSNotificationDetails();
    var generalNotifDetail = NotificationDetails(androidDetails, iOSDetails);

    await flutterNotif.schedule(
        int.tryParse(idSchedule.toString().substring(0, 10)),
        'News Alarm',
        titleNews,
        scheduledTime,
        generalNotifDetail);
  }

  buildFilterButton() {
    var padding = EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w);
    return Row(
      children: <Widget>[
        buildAllImpact(padding),
        SizedBox(width: 15.w),
        buildHighImpact(padding),
        SizedBox(width: 15.w),
        buildMediumImpact(padding),
        SizedBox(width: 15.w),
        buildLowImpact(padding),
      ],
    );
  }

  Expanded buildMediumImpact(EdgeInsets padding) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_isMedium) {
              _isMedium = false;
            } else {
              _isMedium = true;
            }
            _isALLChecked();
          });
        },
        child: Container(
          padding: padding,
          height: 50.w,
          child: Row(
            children: <Widget>[
              Container(
                width: 13.w,
                height: 13.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                "Medium",
                style: TextStyle(
                  fontFamily: "Nunito-Bold",
                  fontSize: 23.ssp,
                  color: (_isMedium) ? kPrimaryColor : Colors.white,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.w),
            // color: (_isMedium) ? Colors.white : Colors.black.withOpacity(0.2),
            color: (_isMedium) ? Colors.white : kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Expanded buildLowImpact(EdgeInsets padding) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_isLow) {
              _isLow = false;
            } else {
              _isLow = true;
            }
            _isALLChecked();
          });
        },
        child: Container(
          padding: padding,
          height: 50.w,
          child: Row(
            children: <Widget>[
              Container(
                width: 13.w,
                height: 13.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow[700],
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                "Low",
                style: TextStyle(
                  fontFamily: "Nunito-Bold",
                  fontSize: 23.ssp,
                  color: (_isLow) ? kPrimaryColor : Colors.white,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.w),
            // color: (_isLow) ? Colors.white : Colors.black.withOpacity(0.2),
            color: (_isLow) ? Colors.white : kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Expanded buildHighImpact(EdgeInsets padding) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_isHigh) {
              _isHigh = false;
            } else {
              _isHigh = true;
            }
            _isALLChecked();
          });
        },
        child: Container(
          padding: padding,
          height: 50.w,
          child: Row(
            children: <Widget>[
              Container(
                width: 13.w,
                height: 13.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                "High",
                style: TextStyle(
                  fontFamily: "Nunito-Bold",
                  fontSize: 23.ssp,
                  color: (_isHigh) ? kPrimaryColor : Colors.white,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.w),
            //color: (_isHigh) ? Colors.white : Colors.black.withOpacity(0.2),
            color: (_isHigh) ? Colors.white : kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Expanded buildAllImpact(EdgeInsets padding) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_isALL) {
              _isALL = false;
            } else {
              _isALL = true;
              _isHigh = false;
              _isMedium = false;
              _isLow = false;
            }
          });
        },
        child: Container(
          padding: padding,
          height: 50.w,
          child: Row(
            children: <Widget>[
              Container(
                width: 13.w,
                height: 13.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                "All",
                style: TextStyle(
                  fontFamily: "Nunito-Bold",
                  fontSize: 23.ssp,
                  color: (_isALL) ? kPrimaryColor : Colors.white,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.w),
            //color: (_isALL) ? Colors.white : Colors.black.withOpacity(0.2),
            color: (_isALL) ? Colors.white : kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Row buildLineSwipeUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70.w,
          height: 8.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
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
            _isHigh = false;
            _isMedium = false;
            _isLow = false;
            _isALL = true;
            _markedDateMap.clear();
          }),
      title: Text(
        "Calendar Economic",
        style: TextStyle(
          fontFamily: "Nunito-ExtraBold",
          fontSize: 32.ssp,
          color: kTextColor,
        ),
      ),
    );
  }

//function untuk mengganti warna box impact news
  BoxDecoration boxDecorationImpact(String impact) {
    if (impact == "High") {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        color: Color.fromRGBO(192, 57, 43, 1),
      );
    } else if (impact == "Medium") {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        color: Color.fromRGBO(230, 126, 34, 1),
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        color: Colors.yellow[700],
      );
    }
  }

  void _isALLChecked() {
    if (_isHigh && _isMedium && _isLow) {
      _isALL = true;
      _isHigh = false;
      _isMedium = false;
      _isLow = false;
    } else {
      _isALL = false;
    }
  }

  // get impact from news
  int getImpactVal(String impact) {
    int val = -1;
    for (var i = 0; i < arrImpact.length; i++) {
      if (impact == arrImpact[i]) {
        val = i;
        break;
      }
    }
    return val;
  }

  getDataFromAPI(DateTime date) {
    //array list 3 dimensi untuk menampung tanggal dan impact dari news
    var arrFlag = List.generate(31, (index) => List(3), growable: false);
    //membuat default flag setiap tanggal menjadi 0
    for (var i = 0; i < 31; i++) {
      for (var j = 0; j < 3; j++) {
        arrFlag[i][j] = 0;
      }
    }

    String strDate = date.toString().substring(0, 7);

    futureCalendar = calendarNews.getNews(strDate);
    futureCalendar.then((value) {
      int day;
      int month;
      int year;
      String impact;
      Color colorImpact;

      //get year and month to mark calendar berdasarkan bulan dan tahun saat ini
      //var now = DateTime.now();
      year = int.parse(date.toString().substring(0, 4));
      month = int.parse(date.toString().substring(5, 7));

      for (var i = 0; i < value.length; i++) {
        day = int.parse(value[i].date.toString().substring(8, 10));
        //day = int.parse(value[i].ffDate.toString());
        impact = value[i].impact;

        //-------------------------------

        int impactVal = getImpactVal(impact);
        if (impactVal >= 0) {
          arrFlag[day - 1][impactVal] = 1;
        }

        //-------------------------------
      }

      for (var i = 0; i < 31; i++) {
        for (var j = 0; j < 3; j++) {
          //cek jika tanggal tersebut memiliki impact berita maka akan di mark di calendar
          if (arrFlag[i][j] == 1) {
            //menentukan warna marked pada calendar sesuai impact news
            if (j == 2) {
              //impact high
              colorImpact = Colors.red;
            } else if (j == 1) {
              //impact medium
              colorImpact = Colors.orange;
            } else if (j == 0) {
              //impact low
              colorImpact = Colors.yellow;
            }

            _markedDateMap.add(
              DateTime(year, month, i + 1),
              Event(
                date: DateTime(year, month, i + 1),
                dot: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  height: 7.w,
                  width: 7.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorImpact,
                  ),
                ),
              ),
            );
          }
        }
      }
    });
  }
}
