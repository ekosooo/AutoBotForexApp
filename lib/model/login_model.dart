import 'dart:convert';

class Login {
  Login({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  DataLogin data;

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataLogin.fromMap(json["data"]),
      );
}

class DataLogin {
  DataLogin({
    this.id,
    this.email,
    this.name,
    this.mobile,
    this.username,
    this.refferer,
  });

  String id;
  String email;
  String name;
  String mobile;
  String username;
  String refferer;

  factory DataLogin.fromJson(String str) => DataLogin.fromMap(json.decode(str));

  factory DataLogin.fromMap(Map<String, dynamic> json) => DataLogin(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        username: json["username"] == null ? null : json["username"],
        refferer: json["refferer"] == null ? null : json["refferer"],
      );
}
