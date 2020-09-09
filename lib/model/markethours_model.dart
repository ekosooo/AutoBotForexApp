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
    this.marketId,
    this.marketCenter,
    this.marketOpen,
    this.marketClose,
  });

  String marketId;
  String marketCenter;
  DateTime marketOpen;
  DateTime marketClose;

  factory DataMarketHours.fromJson(String str) =>
      DataMarketHours.fromMap(json.decode(str));

  factory DataMarketHours.fromMap(Map<String, dynamic> json) => DataMarketHours(
        marketId: json["MarketID"] == null ? null : json["MarketID"],
        marketCenter:
            json["MarketCenter"] == null ? null : json["MarketCenter"],
        marketOpen: json["MarketOpen"] == null
            ? null
            : DateTime.parse(json["MarketOpen"]).add(
                Duration(seconds: (FunctionGlobal().getGMTbySystem()) * 3600)),
        marketClose: json["MarketClose"] == null
            ? null
            : DateTime.parse(json["MarketClose"]).add(
                Duration(seconds: (FunctionGlobal().getGMTbySystem()) * 3600)),
      );
}
