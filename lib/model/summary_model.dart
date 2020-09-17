import 'dart:convert';

class SummarySignals {
  SummarySignals({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory SummarySignals.fromJson(String str) =>
      SummarySignals.fromMap(json.decode(str));

  factory SummarySignals.fromMap(Map<String, dynamic> json) => SummarySignals(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    this.dataSignal,
    this.dataSummary,
  });

  List<DataSumSignal> dataSignal;
  DataSummary dataSummary;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        dataSignal: json["dataSignal"] == null
            ? null
            : List<DataSumSignal>.from(
                json["dataSignal"].map((x) => DataSumSignal.fromMap(x))),
        dataSummary: json["dataSummary"] == null
            ? null
            : DataSummary.fromMap(json["dataSummary"]),
      );
}

class DataSumSignal {
  DataSumSignal({
    this.pairname,
    this.desc,
    this.img,
    this.sumLoss,
    this.sumProfit,
  });

  String pairname;
  String desc;
  String img;
  String sumLoss;
  String sumProfit;

  factory DataSumSignal.fromJson(String str) =>
      DataSumSignal.fromMap(json.decode(str));

  factory DataSumSignal.fromMap(Map<String, dynamic> json) => DataSumSignal(
        pairname: json["pairname"] == null ? null : json["pairname"],
        desc: json["desc"] == null ? null : json["desc"],
        img: json["img"] == null ? null : json["img"],
        sumLoss: json["sumLoss"] == null ? null : json["sumLoss"],
        sumProfit: json["sumProfit"] == null ? null : json["sumProfit"],
      );
}

class DataSummary {
  DataSummary({
    this.sumProfit,
    this.sumLoss,
    this.sumDifference,
  });

  String sumProfit;
  String sumLoss;
  String sumDifference;

  factory DataSummary.fromJson(String str) =>
      DataSummary.fromMap(json.decode(str));

  factory DataSummary.fromMap(Map<String, dynamic> json) => DataSummary(
        sumProfit: json["sumProfit"] == null ? null : json["sumProfit"],
        sumLoss: json["sumLoss"] == null ? null : json["sumLoss"],
        sumDifference:
            json["sumDifference"] == null ? null : json["sumDifference"],
      );
}
