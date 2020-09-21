import 'dart:convert';

class ListBroker {
  ListBroker({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataListBroker> data;

  factory ListBroker.fromJson(String str) =>
      ListBroker.fromMap(json.decode(str));

  factory ListBroker.fromMap(Map<String, dynamic> json) => ListBroker(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataListBroker>.from(
                json["data"].map((x) => DataListBroker.fromMap(x))),
      );
}

class DataListBroker {
  DataListBroker({
    this.broker,
    this.name,
    this.rate,
    this.img,
  });

  String broker;
  String name;
  String rate;
  String img;

  factory DataListBroker.fromJson(String str) =>
      DataListBroker.fromMap(json.decode(str));

  factory DataListBroker.fromMap(Map<String, dynamic> json) => DataListBroker(
        broker: json["broker"] == null ? null : json["broker"],
        name: json["name"] == null ? null : json["name"],
        rate: json["rate"] == null ? null : json["rate"],
        img: json["img"] == null ? null : json["img"],
      );
}
