import 'dart:convert';
import '../func_global.dart';
import 'package:http/http.dart' as http;

class CalendarNews {
  String ffTitle;
  String ffCountry;
  DateTime ffDate;
  String ffTime;
  String ffImpact;
  String ffForecast;
  String ffPrevious;
  dynamic ffActual;
  DateTime ffCreatedAt;
  DateTime ffUpdatedAt;

  CalendarNews({
    this.ffTitle,
    this.ffCountry,
    this.ffDate,
    this.ffTime,
    this.ffImpact,
    this.ffForecast,
    this.ffPrevious,
    this.ffActual,
    this.ffCreatedAt,
    this.ffUpdatedAt,
  });

  factory CalendarNews.fromJson(Map<String, dynamic> json) => CalendarNews(
        // ffTitle: json["FFTitle"],
        // ffCountry: json["FFCountry"],
        // ffDate: DateTime.parse(json["FFDate"] + " " + json["FFTime"])
        //     .add(Duration(seconds: (FunctionGlobal().getGMTbySystem()) * 3600)),
        // //ffTime: json["FFTime"],
        // ffImpact: json["FFImpact"],
        // ffForecast: json["FFForecast"],
        // ffPrevious: json["FFPrevious"],
        // ffActual: json["FFActual"],
        // ffCreatedAt: DateTime.parse(json["FFCreatedAt"]),
        // ffUpdatedAt: DateTime.parse(json["FFUpdatedAt"]),
        ffTitle: json["FFTitle"] == null ? null : json["FFTitle"],
        ffCountry: json["FFCountry"] == null ? null : json["FFCountry"],
        ffDate: json["FFDate"] == null ? null : DateTime.parse(json["FFDate"]),
        ffTime: json["FFTime"] == null ? null : json["FFTime"],
        ffImpact: json["FFImpact"] == null ? null : json["FFImpact"],
        ffForecast: json["FFForecast"] == null ? null : json["FFForecast"],
        ffPrevious: json["FFPrevious"] == null ? null : json["FFPrevious"],
        ffActual: json["FFActual"],
        ffCreatedAt: json["FFCreatedAt"] == null
            ? null
            : DateTime.parse(json["FFCreatedAt"]),
        ffUpdatedAt: json["FFUpdatedAt"] == null
            ? null
            : DateTime.parse(json["FFUpdatedAt"]),
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
