import 'dart:convert';

class Education {
  Education({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataEducation> data;

  factory Education.fromJson(String str) => Education.fromMap(json.decode(str));

  factory Education.fromMap(Map<String, dynamic> json) => Education(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataEducation>.from(
                json["data"].map((x) => DataEducation.fromMap(x))),
      );
}

class DataEducation {
  DataEducation({
    this.img,
    this.title,
    this.desc,
    this.link,
  });

  String img;
  String title;
  String desc;
  String link;

  factory DataEducation.fromJson(String str) =>
      DataEducation.fromMap(json.decode(str));

  factory DataEducation.fromMap(Map<String, dynamic> json) => DataEducation(
        img: json["img"] == null ? null : json["img"],
        title: json["title"] == null ? null : json["title"],
        desc: json["desc"] == null ? null : json["desc"],
        link: json["link"] == null ? null : json["link"],
      );
}
