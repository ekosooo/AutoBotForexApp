import 'dart:convert';

class Banners {
  Banners({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataBanner> data;

  factory Banners.fromJson(String str) => Banners.fromMap(json.decode(str));

  factory Banners.fromMap(Map<String, dynamic> json) => Banners(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataBanner>.from(
                json["data"].map((x) => DataBanner.fromMap(x))),
      );
}

class DataBanner {
  DataBanner({
    this.link,
    this.img,
  });

  String link;
  String img;

  factory DataBanner.fromJson(String str) =>
      DataBanner.fromMap(json.decode(str));

  factory DataBanner.fromMap(Map<String, dynamic> json) => DataBanner(
        link: json["link"] == null ? null : json["link"],
        img: json["img"] == null ? null : json["img"],
      );
}
