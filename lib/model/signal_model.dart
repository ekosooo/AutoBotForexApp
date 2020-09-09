import 'dart:convert';

class Signal {
  Signal({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataSignal> data;

  factory Signal.fromJson(String str) => Signal.fromMap(json.decode(str));

  factory Signal.fromMap(Map<String, dynamic> json) => Signal(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataSignal>.from(
                json["data"].map((x) => DataSignal.fromMap(x))),
      );
}

class DataSignal {
  DataSignal({
    this.sigId,
    this.sigProvId,
    this.sigOrderType,
    this.sigPrice,
    this.sigTp1,
    this.sigTp2,
    this.sigTp3,
    this.sigSl,
    this.sigStatusFloating,
    this.sigClose,
    this.sigResult,
    this.sigStatus,
    this.sigCreatedAt,
    this.sigUpdatedAt,
    this.provsigId,
    this.provsigTech,
    this.provsigName,
    this.pairName,
    this.pairDesc,
    this.pairImg,
    this.oTypeId,
    this.oTypeName,
  });

  int sigId;
  String sigProvId;
  String sigOrderType;
  String sigPrice;
  String sigTp1;
  String sigTp2;
  String sigTp3;
  String sigSl;
  int sigStatusFloating;
  String sigClose;
  String sigResult;
  int sigStatus;
  DateTime sigCreatedAt;
  DateTime sigUpdatedAt;
  String provsigId;
  String provsigTech;
  String provsigName;
  String pairName;
  String pairDesc;
  String pairImg;
  int oTypeId;
  String oTypeName;

  factory DataSignal.fromJson(String str) =>
      DataSignal.fromMap(json.decode(str));

  factory DataSignal.fromMap(Map<String, dynamic> json) => DataSignal(
        sigId: json["sigID"] == null ? null : json["sigID"],
        sigProvId: json["sigProvID"] == null ? null : json["sigProvID"],
        sigOrderType:
            json["sigOrderType"] == null ? null : json["sigOrderType"],
        sigPrice: json["sigPrice"] == null ? null : json["sigPrice"],
        sigTp1: json["sigTP1"] == null ? null : json["sigTP1"],
        sigTp2: json["sigTP2"] == null ? null : json["sigTP2"],
        sigTp3: json["sigTP3"] == null ? null : json["sigTP3"],
        sigSl: json["sigSL"] == null ? null : json["sigSL"],
        sigStatusFloating: json["sigStatusFloating"] == null
            ? null
            : json["sigStatusFloating"],
        sigClose: json["sigClose"] == null ? null : json["sigClose"],
        sigResult: json["sigResult"] == null ? null : json["sigResult"],
        sigStatus: json["sigStatus"] == null ? null : json["sigStatus"],
        sigCreatedAt: json["sigCreatedAt"] == null
            ? null
            : DateTime.parse(json["sigCreatedAt"]),
        sigUpdatedAt: json["sigUpdatedAt"] == null
            ? null
            : DateTime.parse(json["sigUpdatedAt"]),
        provsigId: json["provsigID"] == null ? null : json["provsigID"],
        provsigTech: json["provsigTech"] == null ? null : json["provsigTech"],
        provsigName: json["provsigName"] == null ? null : json["provsigName"],
        pairName: json["PairName"] == null ? null : json["PairName"],
        pairDesc: json["PairDesc"] == null ? null : json["PairDesc"],
        pairImg: json["PairImg"] == null ? null : json["PairImg"],
        oTypeId: json["OTypeID"] == null ? null : json["OTypeID"],
        oTypeName: json["OTypeName"] == null ? null : json["OTypeName"],
      );
}
