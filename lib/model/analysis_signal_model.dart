import 'dart:convert';

class AnalysisSignal {
  String status;
  String message;
  Data data;

  AnalysisSignal({
    this.status,
    this.message,
    this.data,
  });

  factory AnalysisSignal.fromJson(String str) =>
      AnalysisSignal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AnalysisSignal.fromMap(Map<String, dynamic> json) => AnalysisSignal(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    this.price,
    this.indicator,
  });

  Price price;
  Indicator indicator;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        price: Price.fromMap(json["price"]),
        indicator: Indicator.fromMap(json["indicator"]),
      );

  Map<String, dynamic> toMap() => {
        "price": price.toMap(),
        "indicator": indicator.toMap(),
      };
}

class Indicator {
  Indicator({
    this.ma,
    this.rsi,
    this.ichimoku,
    this.bb,
  });

  List<Ma> ma;
  List<Rsi> rsi;
  List<Ichimoku> ichimoku;
  List<Bb> bb;

  factory Indicator.fromJson(String str) => Indicator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Indicator.fromMap(Map<String, dynamic> json) => Indicator(
        ma: List<Ma>.from(json["MA"].map((x) => Ma.fromMap(x))),
        rsi: List<Rsi>.from(json["RSI"].map((x) => Rsi.fromMap(x))),
        ichimoku: List<Ichimoku>.from(
            json["Ichimoku"].map((x) => Ichimoku.fromMap(x))),
        bb: List<Bb>.from(json["BB"].map((x) => Bb.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "MA": List<dynamic>.from(ma.map((x) => x.toMap())),
        "RSI": List<dynamic>.from(rsi.map((x) => x.toMap())),
        "Ichimoku": List<dynamic>.from(ichimoku.map((x) => x.toMap())),
        "BB": List<dynamic>.from(bb.map((x) => x.toMap())),
      };
}

class Bb {
  Bb({
    this.iBbPair,
    this.iBbtf,
    this.iBbPeriod,
    this.iBbTop,
    this.iBbMid,
    this.iBbBottom,
    this.iBbSignal,
    this.iBbCreatedAt,
    this.iBbUpdatedAt,
  });

  String iBbPair;
  int iBbtf;
  int iBbPeriod;
  double iBbTop;
  double iBbMid;
  double iBbBottom;
  int iBbSignal;
  DateTime iBbCreatedAt;
  DateTime iBbUpdatedAt;

  factory Bb.fromJson(String str) => Bb.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bb.fromMap(Map<String, dynamic> json) => Bb(
        iBbPair: json["iBBPair"],
        iBbtf: json["iBBTF"],
        iBbPeriod: json["iBBPeriod"],
        iBbTop: json["iBBTop"].toDouble(),
        iBbMid: json["iBBMid"].toDouble(),
        iBbBottom: json["iBBBottom"].toDouble(),
        iBbSignal: json["iBBSignal"],
        iBbCreatedAt: DateTime.parse(json["iBBCreatedAt"]),
        iBbUpdatedAt: DateTime.parse(json["iBBUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "iBBPair": iBbPair,
        "iBBTF": iBbtf,
        "iBBPeriod": iBbPeriod,
        "iBBTop": iBbTop,
        "iBBMid": iBbMid,
        "iBBBottom": iBbBottom,
        "iBBSignal": iBbSignal,
        "iBBCreatedAt": iBbCreatedAt.toIso8601String(),
        "iBBUpdatedAt": iBbUpdatedAt.toIso8601String(),
      };
}

class Ichimoku {
  Ichimoku({
    this.iMokuPair,
    this.iMokuTf,
    this.iMokuTenkan,
    this.iMokuKijun,
    this.iMokuSsa,
    this.iMokuSsb,
    this.iMokuChikou,
    this.iMokuSignal,
    this.iMokuCreatedAt,
    this.iMokuUpdatedAt,
  });

  String iMokuPair;
  int iMokuTf;
  double iMokuTenkan;
  double iMokuKijun;
  double iMokuSsa;
  double iMokuSsb;
  double iMokuChikou;
  int iMokuSignal;
  DateTime iMokuCreatedAt;
  DateTime iMokuUpdatedAt;

  factory Ichimoku.fromJson(String str) => Ichimoku.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ichimoku.fromMap(Map<String, dynamic> json) => Ichimoku(
        iMokuPair: json["iMokuPair"],
        iMokuTf: json["iMokuTF"],
        iMokuTenkan: json["iMokuTenkan"],
        iMokuKijun: json["iMokuKijun"],
        iMokuSsa: json["iMokuSSA"],
        iMokuSsb: json["iMokuSSB"].toDouble(),
        iMokuChikou: json["iMokuChikou"],
        iMokuSignal: json["iMokuSignal"],
        iMokuCreatedAt: DateTime.parse(json["iMokuCreatedAt"]),
        iMokuUpdatedAt: DateTime.parse(json["iMokuUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "iMokuPair": iMokuPair,
        "iMokuTF": iMokuTf,
        "iMokuTenkan": iMokuTenkan,
        "iMokuKijun": iMokuKijun,
        "iMokuSSA": iMokuSsa,
        "iMokuSSB": iMokuSsb,
        "iMokuChikou": iMokuChikou,
        "iMokuSignal": iMokuSignal,
        "iMokuCreatedAt": iMokuCreatedAt.toIso8601String(),
        "iMokuUpdatedAt": iMokuUpdatedAt.toIso8601String(),
      };
}

class Ma {
  Ma({
    this.iMaPair,
    this.iMatf,
    this.iMaPeriod,
    this.iMaSimple,
    this.iMaExponential,
    this.iMaSmoothed,
    this.iMalw,
    this.iMaSigSimple,
    this.iMaSigExponential,
    this.iMaSigSmoothed,
    this.iMaSigLw,
    this.iMaCreatedAt,
    this.iMaUpdatedAt,
  });

  String iMaPair;
  int iMatf;
  String iMaPeriod;
  double iMaSimple;
  double iMaExponential;
  double iMaSmoothed;
  double iMalw;
  int iMaSigSimple;
  int iMaSigExponential;
  int iMaSigSmoothed;
  int iMaSigLw;
  DateTime iMaCreatedAt;
  DateTime iMaUpdatedAt;

  factory Ma.fromJson(String str) => Ma.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ma.fromMap(Map<String, dynamic> json) => Ma(
        iMaPair: json["iMAPair"],
        iMatf: json["iMATF"],
        iMaPeriod: json["iMAPeriod"],
        iMaSimple: json["iMASimple"].toDouble(),
        iMaExponential: json["iMAExponential"].toDouble(),
        iMaSmoothed: json["iMASmoothed"].toDouble(),
        iMalw: json["iMALW"].toDouble(),
        iMaSigSimple: json["iMASigSimple"],
        iMaSigExponential: json["iMASigExponential"],
        iMaSigSmoothed: json["iMASigSmoothed"],
        iMaSigLw: json["iMASigLW"],
        iMaCreatedAt: DateTime.parse(json["iMACreatedAt"]),
        iMaUpdatedAt: DateTime.parse(json["iMAUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "iMAPair": iMaPair,
        "iMATF": iMatf,
        "iMAPeriod": iMaPeriod,
        "iMASimple": iMaSimple,
        "iMAExponential": iMaExponential,
        "iMASmoothed": iMaSmoothed,
        "iMALW": iMalw,
        "iMASigSimple": iMaSigSimple,
        "iMASigExponential": iMaSigExponential,
        "iMASigSmoothed": iMaSigSmoothed,
        "iMASigLW": iMaSigLw,
        "iMACreatedAt": iMaCreatedAt.toIso8601String(),
        "iMAUpdatedAt": iMaUpdatedAt.toIso8601String(),
      };
}

class Rsi {
  Rsi({
    this.iRsiPair,
    this.iRsitf,
    this.iRsiPeriod,
    this.iRsiValue,
    this.iRsiSignal,
    this.iRsiCreatedAt,
    this.iRsiUpdatedAt,
  });

  String iRsiPair;
  int iRsitf;
  int iRsiPeriod;
  double iRsiValue;
  int iRsiSignal;
  DateTime iRsiCreatedAt;
  DateTime iRsiUpdatedAt;

  factory Rsi.fromJson(String str) => Rsi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rsi.fromMap(Map<String, dynamic> json) => Rsi(
        iRsiPair: json["iRSIPair"],
        iRsitf: json["iRSITF"],
        iRsiPeriod: json["iRSIPeriod"],
        iRsiValue: json["iRSIValue"].toDouble(),
        iRsiSignal: json["iRSISignal"],
        iRsiCreatedAt: DateTime.parse(json["iRSICreatedAt"]),
        iRsiUpdatedAt: DateTime.parse(json["iRSIUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "iRSIPair": iRsiPair,
        "iRSITF": iRsitf,
        "iRSIPeriod": iRsiPeriod,
        "iRSIValue": iRsiValue,
        "iRSISignal": iRsiSignal,
        "iRSICreatedAt": iRsiCreatedAt.toIso8601String(),
        "iRSIUpdatedAt": iRsiUpdatedAt.toIso8601String(),
      };
}

class Price {
  Price({
    this.now,
    this.open,
    this.close,
    this.low,
    this.high,
    this.adr,
  });

  double now;
  double open;
  double close;
  double low;
  double high;
  String adr;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        now: json["now"].toDouble(),
        open: json["open"].toDouble(),
        close: json["close"].toDouble(),
        low: json["low"].toDouble(),
        high: json["high"].toDouble(),
        adr: json["adr"],
      );

  Map<String, dynamic> toMap() => {
        "now": now,
        "open": open,
        "close": close,
        "low": low,
        "high": high,
        "adr": adr,
      };
}
