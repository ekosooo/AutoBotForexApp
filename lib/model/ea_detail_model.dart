import 'dart:convert';

class DetailEA {
  DetailEA({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataDetailEA> data;

  factory DetailEA.fromJson(String str) => DetailEA.fromMap(json.decode(str));

  factory DetailEA.fromMap(Map<String, dynamic> json) => DetailEA(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataDetailEA>.from(
                json["data"].map((x) => DataDetailEA.fromMap(x))),
      );
}

class DataDetailEA {
  DataDetailEA({
    this.name,
    this.desc,
    this.img,
    this.fitur,
    this.recom,
    this.rate,
    this.backtest,
    this.ss,
    this.product,
  });

  String name;
  String desc;
  String img;
  String fitur;
  String recom;
  String rate;
  List<BacktestEA> backtest;
  List<ScreenshotEA> ss;
  List<Product> product;

  factory DataDetailEA.fromJson(String str) =>
      DataDetailEA.fromMap(json.decode(str));

  factory DataDetailEA.fromMap(Map<String, dynamic> json) => DataDetailEA(
        name: json["name"] == null ? null : json["name"],
        desc: json["desc"] == null ? null : json["desc"],
        img: json["img"] == null ? null : json["img"],
        fitur: json["fitur"] == null ? null : json["fitur"],
        recom: json["recom"] == null ? null : json["recom"],
        rate: json["rate"] == null ? null : json["rate"],
        product: json["product"] == null
            ? null
            : List<Product>.from(
                json["product"].map((x) => Product.fromMap(x))),
        backtest: json["backtest"] == null
            ? null
            : List<BacktestEA>.from(
                json["backtest"].map((x) => BacktestEA.fromMap(x))),
        ss: json["ss"] == null
            ? null
            : List<ScreenshotEA>.from(
                json["ss"].map((x) => ScreenshotEA.fromMap(x))),
      );
}

class BacktestEA {
  BacktestEA({
    this.cat,
    this.url,
    this.priority,
    this.thumbnail,
  });

  String cat;
  String url;
  String priority;
  String thumbnail;

  factory BacktestEA.fromJson(String str) =>
      BacktestEA.fromMap(json.decode(str));

  factory BacktestEA.fromMap(Map<String, dynamic> json) => BacktestEA(
        cat: json["cat"] == null ? null : json["cat"],
        url: json["url"] == null ? null : json["url"],
        priority: json["priority"] == null ? null : json["priority"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
      );
}

class ScreenshotEA {
  ScreenshotEA({
    this.cat,
    this.url,
    this.priority,
  });

  String cat;
  String url;
  String priority;

  factory ScreenshotEA.fromJson(String str) =>
      ScreenshotEA.fromMap(json.decode(str));

  factory ScreenshotEA.fromMap(Map<String, dynamic> json) => ScreenshotEA(
        cat: json["cat"] == null ? null : json["cat"],
        url: json["url"] == null ? null : json["url"],
        priority: json["priority"] == null ? null : json["priority"],
      );
}

class Product {
  Product({
    this.period,
    this.price,
    this.id,
    this.desc,
    this.aff,
  });

  String id;
  String desc;
  String period;
  String price;
  String aff;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        desc: json["desc"] == null ? null : json["desc"],
        period: json["period"] == null ? null : json["period"],
        price: json["price"] == null ? null : json["price"],
        aff: json["aff"] == null ? null : json["aff"],
      );
}
