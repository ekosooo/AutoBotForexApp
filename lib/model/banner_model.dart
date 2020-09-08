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
    this.bnrId,
    this.bnrLink,
    this.bnrImg,
    this.bnrStatus,
  });

  String bnrId;
  String bnrLink;
  String bnrImg;
  int bnrStatus;

  factory DataBanner.fromJson(String str) =>
      DataBanner.fromMap(json.decode(str));

  factory DataBanner.fromMap(Map<String, dynamic> json) => DataBanner(
        bnrId: json["BnrID"] == null ? null : json["BnrID"],
        bnrLink: json["BnrLink"] == null ? null : json["BnrLink"],
        bnrImg: json["BnrImg"] == null ? null : json["BnrImg"],
        bnrStatus: json["BnrStatus"] == null ? null : json["BnrStatus"],
      );
}
