import 'dart:convert';
import '../func_global.dart';
import 'package:http/http.dart' as http;

class CalendarNews {
  String title;
  String country;
  DateTime date;
  String time;
  String impact;
  String forecast;
  String previous;
  String actual;
  DateTime createdat;
  DateTime updatedat;

  CalendarNews({
    this.title,
    this.country,
    this.date,
    this.time,
    this.impact,
    this.forecast,
    this.previous,
    this.actual,
    this.createdat,
    this.updatedat,
  });

  factory CalendarNews.fromJson(Map<String, dynamic> json) => CalendarNews(
        title: json["title"] == null ? null : json["title"],
        country: json["country"] == null ? null : json["country"],
        date: json["date"] == null
            ? null
            : DateTime.parse(json["date"] + " " + json["time"]).add(
                Duration(seconds: (FunctionGlobal().getGMTbySystem()) * 3600)),
        //ffTime: json["FFTime"] == null ? null : json["FFTime"],
        impact: json["impact"] == null ? null : json["impact"],
        forecast: json["forecast"] == null ? null : json["forecast"],
        previous: json["previous"] == null ? null : json["previous"],
        actual: json["actual"],
        createdat: json["createdat"] == null
            ? null
            : DateTime.parse(json["createdat"]),
        updatedat: json["updatedat"] == null
            ? null
            : DateTime.parse(json["updatedat"]),
      );

  List<CalendarNews> calendarFromJson(String jsonData) {
    //print(jsonData);
    List data = json.decode(jsonData);
    return List<CalendarNews>.from(
        data.map((item) => CalendarNews.fromJson(item)));
  }

  Future<List<CalendarNews>> getNews(String date) async {
    final String baseUrl = "https://signalforex.id/apis/ShowFF";
    final response = await http.post("$baseUrl", body: {"date": date});
    if (response.statusCode == 200) {
      return calendarFromJson(response.body);
    } else {
      return null;
    }
  }
}
