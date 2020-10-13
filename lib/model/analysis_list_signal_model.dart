import 'dart:convert';

class ListAnalysisSignal {
  ListAnalysisSignal({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataPair> data;

  factory ListAnalysisSignal.fromJson(String str) =>
      ListAnalysisSignal.fromMap(json.decode(str));

  factory ListAnalysisSignal.fromMap(Map<String, dynamic> json) =>
      ListAnalysisSignal(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataPair>.from(json["data"].map((x) => DataPair.fromMap(x))),
      );
}

class DataPair {
  DataPair({
    this.pairName,
    this.pairDesc,
    this.pairId,
    this.pairImg,
    this.iPriceClose,
    this.iPriceOpen,
    this.iPriceLow,
    this.iPriceHigh,
    this.iAdrPersen,
    this.iAdrDirection,
  });

  String pairName;
  String pairDesc;
  String pairId;
  String pairImg;
  String iPriceClose;
  String iPriceOpen;
  String iPriceLow;
  String iPriceHigh;
  String iAdrPersen;
  String iAdrDirection;

  factory DataPair.fromJson(String str) => DataPair.fromMap(json.decode(str));

  factory DataPair.fromMap(Map<String, dynamic> json) => DataPair(
        pairName: json["pair"] == null ? null : json["pair"],
        pairDesc: json["desc"] == null ? null : json["desc"],
        pairId: json["id"] == null ? null : json["id"],
        pairImg: json["img"] == null ? null : json["img"],
        iPriceClose: json["close"] == null ? null : json["close"],
        iPriceOpen: json["open"] == null ? null : json["open"],
        iPriceLow: json["low"] == null ? null : json["low"],
        iPriceHigh: json["high"] == null ? null : json["high"],
        iAdrPersen: json["persen"] == null ? null : json["persen"],
        iAdrDirection: json["direction"] == null ? null : json["direction"],
      );
}
