import 'dart:convert';

class ToolsList {
  ToolsList({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataTools> data;

  factory ToolsList.fromJson(String str) => ToolsList.fromMap(json.decode(str));

  factory ToolsList.fromMap(Map<String, dynamic> json) => ToolsList(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataTools>.from(
                json["data"].map(
                  (x) => DataTools.fromMap(x),
                ),
              ),
      );
}

class DataTools {
  DataTools({
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

  factory DataTools.fromJson(String str) => DataTools.fromMap(json.decode(str));

  factory DataTools.fromMap(Map<String, dynamic> json) => DataTools(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        desc: json["desc"] == null ? null : json["desc"],
        rate: json["rate"] == null ? null : json["rate"],
        img: json["img"] == null ? null : json["img"],
      );
}
