import 'dart:convert';

class DetailBroker {
  DetailBroker({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataDetailBroker> data;

  factory DetailBroker.fromJson(String str) =>
      DetailBroker.fromMap(json.decode(str));

  factory DetailBroker.fromMap(Map<String, dynamic> json) => DetailBroker(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataDetailBroker>.from(
                json["data"].map((x) => DataDetailBroker.fromMap(x))),
      );
}

class DataDetailBroker {
  DataDetailBroker({
    this.name,
    this.rate,
    this.intro,
    this.regulation,
    this.model,
    this.demo,
    this.mindepo,
    this.paymethod,
    this.pros,
    this.cons,
    this.brokerimg,
    this.afflink,
    this.promobroker,
  });

  String name;
  String rate;
  String intro;
  String regulation;
  String model;
  String demo;
  String mindepo;
  String paymethod;
  String pros;
  String cons;
  String brokerimg;
  String afflink;
  List<Promobroker> promobroker;

  factory DataDetailBroker.fromJson(String str) =>
      DataDetailBroker.fromMap(json.decode(str));

  factory DataDetailBroker.fromMap(Map<String, dynamic> json) =>
      DataDetailBroker(
        name: json["name"] == null ? null : json["name"],
        rate: json["rate"] == null ? null : json["rate"],
        intro: json["intro"] == null ? null : json["intro"],
        regulation: json["regulation"] == null ? null : json["regulation"],
        model: json["model"] == null ? null : json["model"],
        demo: json["demo"] == null ? null : json["demo"],
        mindepo: json["mindepo"] == null ? null : json["mindepo"],
        paymethod: json["paymethod"] == null ? null : json["paymethod"],
        pros: json["pros"] == null ? null : json["pros"],
        cons: json["cons"] == null ? null : json["cons"],
        brokerimg: json["brokerimg"] == null ? null : json["brokerimg"],
        afflink: json["afflink"] == null ? null : json["afflink"],
        promobroker: json["promobroker"] == null
            ? null
            : List<Promobroker>.from(
                json["promobroker"].map((x) => Promobroker.fromMap(x))),
      );
}

class Promobroker {
  Promobroker({
    this.title,
    this.caption,
    this.promolink,
    this.promoimg,
  });

  String title;
  String caption;
  String promolink;
  String promoimg;

  factory Promobroker.fromJson(String str) =>
      Promobroker.fromMap(json.decode(str));

  factory Promobroker.fromMap(Map<String, dynamic> json) => Promobroker(
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        promolink: json["promolink"] == null ? null : json["promolink"],
        promoimg: json["promoimg"] == null ? null : json["promoimg"],
      );
}
