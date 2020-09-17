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
    this.pairname,
    this.pairimg,
    this.ordertype,
    this.provider,
    this.timeopen,
    this.timeclose,
    this.price,
    this.tp1,
    this.tp2,
    this.tp3,
    this.sl,
    this.close,
    this.result,
    this.statusfloating,
    this.provId,
    this.status,
  });

  String pairname;
  String pairimg;
  String ordertype;
  String provider;
  DateTime timeopen;
  DateTime timeclose;
  String price;
  String tp1;
  String tp2;
  String tp3;
  String sl;
  String close;
  String result;
  String status;
  String statusfloating;
  String provId;

  factory DataSignal.fromJson(String str) =>
      DataSignal.fromMap(json.decode(str));

  factory DataSignal.fromMap(Map<String, dynamic> json) => DataSignal(
        pairname: json["pairname"] == null ? null : json["pairname"],
        pairimg: json["pairimg"] == null ? null : json["pairimg"],
        ordertype: json["ordertype"] == null ? null : json["ordertype"],
        provider: json["provider"] == null ? null : json["provider"],
        timeopen:
            json["timeopen"] == null ? null : DateTime.parse(json["timeopen"]),
        timeclose: json["timeclose"] == null
            ? null
            : DateTime.parse(json["timeclose"]),
        price: json["price"] == null ? null : json["price"],
        tp1: json["tp1"] == null ? null : json["tp1"],
        tp2: json["tp2"] == null ? null : json["tp2"],
        tp3: json["tp3"] == null ? null : json["tp3"],
        sl: json["sl"] == null ? null : json["sl"],
        close: json["close"] == null ? null : json["close"],
        result: json["result"] == null ? null : json["result"],
        statusfloating:
            json["statusfloating"] == null ? null : json["statusfloating"],
        provId: json["provID"] == null ? null : json["provID"],
        status: json["status"] == null ? null : json["status"],
      );
}
