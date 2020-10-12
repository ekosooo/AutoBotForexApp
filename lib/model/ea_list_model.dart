import 'dart:convert';

class ListEA {
  ListEA({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataListEA> data;

  factory ListEA.fromJson(String str) => ListEA.fromMap(json.decode(str));

  factory ListEA.fromMap(Map<String, dynamic> json) => ListEA(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataListEA>.from(
                json["data"].map((x) => DataListEA.fromMap(x))),
      );
}

class DataListEA {
  DataListEA({
    this.id,
    this.name,
    this.desc,
    this.rate,
    this.img,
  });

  String id;
  String name;
  String desc;
  String rate;
  String img;

  factory DataListEA.fromJson(String str) =>
      DataListEA.fromMap(json.decode(str));

  factory DataListEA.fromMap(Map<String, dynamic> json) => DataListEA(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        desc: json["desc"] == null ? null : json["desc"],
        rate: json["rate"] == null ? null : json["rate"],
        img: json["img"] == null ? null : json["img"],
      );
}
