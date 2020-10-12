import 'dart:convert';

class General {
  General({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<dynamic> data;

  factory General.fromJson(String str) => General.fromMap(json.decode(str));

  factory General.fromMap(Map<String, dynamic> json) => General(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<dynamic>.from(json["data"].map((x) => x)),
      );
}
