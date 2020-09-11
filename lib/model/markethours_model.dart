import 'dart:convert';

import 'package:signalforex/func_global.dart';

class MarketHours {
  MarketHours({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataMarketHours> data;

  factory MarketHours.fromJson(String str) =>
      MarketHours.fromMap(json.decode(str));

  factory MarketHours.fromMap(Map<String, dynamic> json) => MarketHours(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataMarketHours>.from(
                json["data"].map((x) => DataMarketHours.fromMap(x))),
      );
}

class DataMarketHours {
  DataMarketHours({
    this.center,
    this.open,
    this.close,
  });

  String center;
  DateTime open;
  DateTime close;

  factory DataMarketHours.fromJson(String str) =>
      DataMarketHours.fromMap(json.decode(str));

  factory DataMarketHours.fromMap(Map<String, dynamic> json) => DataMarketHours(
        center: json["center"] == null ? null : json["center"],
        open: json["open"] == null
            ? null
            : DateTime.parse(json["open"]).add(
                Duration(seconds: (FunctionGlobal().getGMTbySystem()) * 3600)),
        close: json["close"] == null
            ? null
            : DateTime.parse(json["close"]).add(
                Duration(seconds: (FunctionGlobal().getGMTbySystem()) * 3600)),
      );
}
