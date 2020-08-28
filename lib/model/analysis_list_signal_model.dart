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

  String toJson() => json.encode(toMap());

  factory ListAnalysisSignal.fromMap(Map<String, dynamic> json) =>
      ListAnalysisSignal(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataPair>.from(json["data"].map((x) => DataPair.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
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
  int iAdrDirection;

  factory DataPair.fromJson(String str) => DataPair.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataPair.fromMap(Map<String, dynamic> json) => DataPair(
        pairName: json["PairName"] == null ? null : json["PairName"],
        pairDesc: json["PairDesc"] == null ? null : json["PairDesc"],
        pairId: json["PairID"] == null ? null : json["PairID"],
        pairImg: json["PairImg"] == null ? null : json["PairImg"],
        iPriceClose: json["iPriceClose"] == null ? null : json["iPriceClose"],
        iPriceOpen: json["iPriceOpen"] == null ? null : json["iPriceOpen"],
        iPriceLow: json["iPriceLow"] == null ? null : json["iPriceLow"],
        iPriceHigh: json["iPriceHigh"] == null ? null : json["iPriceHigh"],
        iAdrPersen: json["iADRPersen"] == null ? null : json["iADRPersen"],
        iAdrDirection:
            json["iADRDirection"] == null ? null : json["iADRDirection"],
      );

  Map<String, dynamic> toMap() => {
        "PairName": pairName == null ? null : pairName,
        "PairDesc": pairDesc == null ? null : pairDesc,
        "PairID": pairId == null ? null : pairId,
        "PairImg": pairImg == null ? null : pairImg,
        "iPriceClose": iPriceClose == null ? null : iPriceClose,
        "iPriceOpen": iPriceOpen == null ? null : iPriceOpen,
        "iPriceLow": iPriceLow == null ? null : iPriceLow,
        "iPriceHigh": iPriceHigh == null ? null : iPriceHigh,
        "iADRPersen": iAdrPersen == null ? null : iAdrPersen,
        "iADRDirection": iAdrDirection == null ? null : iAdrDirection,
      };
}
