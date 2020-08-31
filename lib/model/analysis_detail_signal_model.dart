import 'dart:convert';

class DetailAnalysisSignal {
  DetailAnalysisSignal({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory DetailAnalysisSignal.fromJson(String str) =>
      DetailAnalysisSignal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailAnalysisSignal.fromMap(Map<String, dynamic> json) =>
      DetailAnalysisSignal(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  Data({
    this.price,
    this.adr,
    this.indicator,
  });

  List<Price> price;
  List<Adr> adr;
  Indicator indicator;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        price: json["price"] == null
            ? null
            : List<Price>.from(json["price"].map((x) => Price.fromMap(x))),
        adr: json["adr"] == null
            ? null
            : List<Adr>.from(json["adr"].map((x) => Adr.fromMap(x))),
        indicator: json["indicator"] == null
            ? null
            : Indicator.fromMap(json["indicator"]),
      );

  Map<String, dynamic> toMap() => {
        "price": price == null
            ? null
            : List<dynamic>.from(price.map((x) => x.toMap())),
        "adr":
            adr == null ? null : List<dynamic>.from(adr.map((x) => x.toMap())),
        "indicator": indicator == null ? null : indicator.toMap(),
      };
}

class Adr {
  Adr({
    this.iAdrUpper,
    this.iAdrLower,
    this.iAdrRange,
    this.iAdrPersen,
    this.iAdrDirection,
  });

  String iAdrUpper;
  String iAdrLower;
  String iAdrRange;
  String iAdrPersen;
  int iAdrDirection;

  factory Adr.fromJson(String str) => Adr.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Adr.fromMap(Map<String, dynamic> json) => Adr(
        iAdrUpper: json["iADRUpper"] == null ? null : json["iADRUpper"],
        iAdrLower: json["iADRLower"] == null ? null : json["iADRLower"],
        iAdrRange: json["iADRRange"] == null ? null : json["iADRRange"],
        iAdrPersen: json["iADRPersen"] == null ? null : json["iADRPersen"],
        iAdrDirection:
            json["iADRDirection"] == null ? null : json["iADRDirection"],
      );

  Map<String, dynamic> toMap() => {
        "iADRUpper": iAdrUpper == null ? null : iAdrUpper,
        "iADRLower": iAdrLower == null ? null : iAdrLower,
        "iADRRange": iAdrRange == null ? null : iAdrRange,
        "iADRPersen": iAdrPersen == null ? null : iAdrPersen,
        "iADRDirection": iAdrDirection == null ? null : iAdrDirection,
      };
}

class Indicator {
  Indicator(
      {this.bb,
      this.envelopes,
      this.ma,
      this.ichimoku,
      this.rsi,
      this.stochastic,
      this.wpr,
      this.sumSignal});

  List<Bb> bb;
  List<Envelope> envelopes;
  List<Ma> ma;
  List<Ichimoku> ichimoku;
  List<Rsi> rsi;
  List<Stochastic> stochastic;
  List<Wpr> wpr;
  SumSignal sumSignal;

  factory Indicator.fromJson(String str) => Indicator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Indicator.fromMap(Map<String, dynamic> json) => Indicator(
        bb: json["BB"] == null
            ? null
            : List<Bb>.from(json["BB"].map((x) => Bb.fromMap(x))),
        envelopes: json["Envelopes"] == null
            ? null
            : List<Envelope>.from(
                json["Envelopes"].map((x) => Envelope.fromMap(x))),
        ma: json["MA"] == null
            ? null
            : List<Ma>.from(json["MA"].map((x) => Ma.fromMap(x))),
        ichimoku: json["Ichimoku"] == null
            ? null
            : List<Ichimoku>.from(
                json["Ichimoku"].map((x) => Ichimoku.fromMap(x))),
        rsi: json["RSI"] == null
            ? null
            : List<Rsi>.from(json["RSI"].map((x) => Rsi.fromMap(x))),
        stochastic: json["Stochastic"] == null
            ? null
            : List<Stochastic>.from(
                json["Stochastic"].map((x) => Stochastic.fromMap(x))),
        wpr: json["WPR"] == null
            ? null
            : List<Wpr>.from(json["WPR"].map((x) => Wpr.fromMap(x))),
        sumSignal: json["SumSignal"] == null
            ? null
            : SumSignal.fromMap(json["SumSignal"]),
      );

  Map<String, dynamic> toMap() => {
        "BB": bb == null ? null : List<dynamic>.from(bb.map((x) => x.toMap())),
        "Envelopes": envelopes == null
            ? null
            : List<dynamic>.from(envelopes.map((x) => x.toMap())),
        "MA": ma == null ? null : List<dynamic>.from(ma.map((x) => x.toMap())),
        "Ichimoku": ichimoku == null
            ? null
            : List<dynamic>.from(ichimoku.map((x) => x.toMap())),
        "RSI":
            rsi == null ? null : List<dynamic>.from(rsi.map((x) => x.toMap())),
        "Stochastic": stochastic == null
            ? null
            : List<dynamic>.from(stochastic.map((x) => x.toMap())),
        "WPR":
            wpr == null ? null : List<dynamic>.from(wpr.map((x) => x.toMap())),
        "SumSignal": sumSignal == null ? null : sumSignal.toMap(),
      };
}

class SumSignal {
  SumSignal({
    this.bb,
    this.envelopes,
    this.ma,
    this.ichimoku,
    this.rsi,
    this.stochastic,
    this.wpr,
    this.sumAll,
  });

  String bb;
  String envelopes;
  String ma;
  String ichimoku;
  String rsi;
  String stochastic;
  String wpr;
  String sumAll;

  factory SumSignal.fromJson(String str) => SumSignal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SumSignal.fromMap(Map<String, dynamic> json) => SumSignal(
        bb: json["BB"] == null ? null : json["BB"],
        envelopes: json["ENVELOPES"] == null ? null : json["ENVELOPES"],
        ma: json["MA"] == null ? null : json["MA"],
        ichimoku: json["ICHIMOKU"] == null ? null : json["ICHIMOKU"],
        rsi: json["RSI"] == null ? null : json["RSI"],
        stochastic: json["STOCHASTIC"] == null ? null : json["STOCHASTIC"],
        wpr: json["WPR"] == null ? null : json["WPR"],
        sumAll: json["SumAll"] == null ? null : json["SumAll"],
      );

  Map<String, dynamic> toMap() => {
        "BB": bb == null ? null : bb,
        "ENVELOPES": envelopes == null ? null : envelopes,
        "MA": ma == null ? null : ma,
        "ICHIMOKU": ichimoku == null ? null : ichimoku,
        "RSI": rsi == null ? null : rsi,
        "STOCHASTIC": stochastic == null ? null : stochastic,
        "WPR": wpr == null ? null : wpr,
        "SumAll": sumAll == null ? null : sumAll,
      };
}

class Bb {
  Bb({
    this.iBbPeriod,
    this.iBbTop,
    this.iBbMid,
    this.iBbBottom,
    this.iBbSignal,
  });

  int iBbPeriod;
  String iBbTop;
  String iBbMid;
  String iBbBottom;
  int iBbSignal;

  factory Bb.fromJson(String str) => Bb.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bb.fromMap(Map<String, dynamic> json) => Bb(
        iBbPeriod: json["iBBPeriod"] == null ? null : json["iBBPeriod"],
        iBbTop: json["iBBTop"] == null ? null : json["iBBTop"],
        iBbMid: json["iBBMid"] == null ? null : json["iBBMid"],
        iBbBottom: json["iBBBottom"] == null ? null : json["iBBBottom"],
        iBbSignal: json["iBBSignal"] == null ? null : json["iBBSignal"],
      );

  Map<String, dynamic> toMap() => {
        "iBBPeriod": iBbPeriod == null ? null : iBbPeriod,
        "iBBTop": iBbTop == null ? null : iBbTop,
        "iBBMid": iBbMid == null ? null : iBbMid,
        "iBBBottom": iBbBottom == null ? null : iBbBottom,
        "iBBSignal": iBbSignal == null ? null : iBbSignal,
      };
}

class Envelope {
  Envelope({
    this.iEnvPeriod,
    this.iEnvUpper,
    this.iEnvLower,
    this.iEnvSignal,
  });

  int iEnvPeriod;
  String iEnvUpper;
  String iEnvLower;
  int iEnvSignal;

  factory Envelope.fromJson(String str) => Envelope.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Envelope.fromMap(Map<String, dynamic> json) => Envelope(
        iEnvPeriod: json["iEnvPeriod"] == null ? null : json["iEnvPeriod"],
        iEnvUpper: json["iEnvUpper"] == null ? null : json["iEnvUpper"],
        iEnvLower: json["iEnvLower"] == null ? null : json["iEnvLower"],
        iEnvSignal: json["iEnvSignal"] == null ? null : json["iEnvSignal"],
      );

  Map<String, dynamic> toMap() => {
        "iEnvPeriod": iEnvPeriod == null ? null : iEnvPeriod,
        "iEnvUpper": iEnvUpper == null ? null : iEnvUpper,
        "iEnvLower": iEnvLower == null ? null : iEnvLower,
        "iEnvSignal": iEnvSignal == null ? null : iEnvSignal,
      };
}

class Ichimoku {
  Ichimoku({
    this.iMokuTenkan,
    this.iMokuKijun,
    this.iMokuSsa,
    this.iMokuSsb,
    this.iMokuChikou,
    this.iMokuSignal,
  });

  String iMokuTenkan;
  String iMokuKijun;
  String iMokuSsa;
  String iMokuSsb;
  String iMokuChikou;
  int iMokuSignal;

  factory Ichimoku.fromJson(String str) => Ichimoku.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ichimoku.fromMap(Map<String, dynamic> json) => Ichimoku(
        iMokuTenkan: json["iMokuTenkan"] == null ? null : json["iMokuTenkan"],
        iMokuKijun: json["iMokuKijun"] == null ? null : json["iMokuKijun"],
        iMokuSsa: json["iMokuSSA"] == null ? null : json["iMokuSSA"],
        iMokuSsb: json["iMokuSSB"] == null ? null : json["iMokuSSB"],
        iMokuChikou: json["iMokuChikou"] == null ? null : json["iMokuChikou"],
        iMokuSignal: json["iMokuSignal"] == null ? null : json["iMokuSignal"],
      );

  Map<String, dynamic> toMap() => {
        "iMokuTenkan": iMokuTenkan == null ? null : iMokuTenkan,
        "iMokuKijun": iMokuKijun == null ? null : iMokuKijun,
        "iMokuSSA": iMokuSsa == null ? null : iMokuSsa,
        "iMokuSSB": iMokuSsb == null ? null : iMokuSsb,
        "iMokuChikou": iMokuChikou == null ? null : iMokuChikou,
        "iMokuSignal": iMokuSignal == null ? null : iMokuSignal,
      };
}

class Ma {
  Ma({
    this.iMaPeriod,
    this.iMaSimple,
    this.iMaExponential,
    this.iMaSmoothed,
    this.iMalw,
    this.iMaSigSimple,
    this.iMaSigExponential,
    this.iMaSigSmoothed,
    this.iMaSigLw,
  });

  int iMaPeriod;
  String iMaSimple;
  String iMaExponential;
  String iMaSmoothed;
  String iMalw;
  int iMaSigSimple;
  int iMaSigExponential;
  int iMaSigSmoothed;
  int iMaSigLw;

  factory Ma.fromJson(String str) => Ma.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ma.fromMap(Map<String, dynamic> json) => Ma(
        iMaPeriod: json["iMAPeriod"] == null ? null : json["iMAPeriod"],
        iMaSimple: json["iMASimple"] == null ? null : json["iMASimple"],
        iMaExponential:
            json["iMAExponential"] == null ? null : json["iMAExponential"],
        iMaSmoothed: json["iMASmoothed"] == null ? null : json["iMASmoothed"],
        iMalw: json["iMALW"] == null ? null : json["iMALW"],
        iMaSigSimple:
            json["iMASigSimple"] == null ? null : json["iMASigSimple"],
        iMaSigExponential: json["iMASigExponential"] == null
            ? null
            : json["iMASigExponential"],
        iMaSigSmoothed:
            json["iMASigSmoothed"] == null ? null : json["iMASigSmoothed"],
        iMaSigLw: json["iMASigLW"] == null ? null : json["iMASigLW"],
      );

  Map<String, dynamic> toMap() => {
        "iMAPeriod": iMaPeriod == null ? null : iMaPeriod,
        "iMASimple": iMaSimple == null ? null : iMaSimple,
        "iMAExponential": iMaExponential == null ? null : iMaExponential,
        "iMASmoothed": iMaSmoothed == null ? null : iMaSmoothed,
        "iMALW": iMalw == null ? null : iMalw,
        "iMASigSimple": iMaSigSimple == null ? null : iMaSigSimple,
        "iMASigExponential":
            iMaSigExponential == null ? null : iMaSigExponential,
        "iMASigSmoothed": iMaSigSmoothed == null ? null : iMaSigSmoothed,
        "iMASigLW": iMaSigLw == null ? null : iMaSigLw,
      };
}

class Rsi {
  Rsi({
    this.iRsiPeriod,
    this.iRsiValue,
    this.iRsiSignal,
  });

  int iRsiPeriod;
  String iRsiValue;
  int iRsiSignal;

  factory Rsi.fromJson(String str) => Rsi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rsi.fromMap(Map<String, dynamic> json) => Rsi(
        iRsiPeriod: json["iRSIPeriod"] == null ? null : json["iRSIPeriod"],
        iRsiValue: json["iRSIValue"] == null ? null : json["iRSIValue"],
        iRsiSignal: json["iRSISignal"] == null ? null : json["iRSISignal"],
      );

  Map<String, dynamic> toMap() => {
        "iRSIPeriod": iRsiPeriod == null ? null : iRsiPeriod,
        "iRSIValue": iRsiValue == null ? null : iRsiValue,
        "iRSISignal": iRsiSignal == null ? null : iRsiSignal,
      };
}

class Stochastic {
  Stochastic({
    this.iStochPeriod,
    this.iStochValue,
    this.iStochsigValue,
    this.iStochsigStoch,
  });

  int iStochPeriod;
  String iStochValue;
  String iStochsigValue;
  int iStochsigStoch;

  factory Stochastic.fromJson(String str) =>
      Stochastic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stochastic.fromMap(Map<String, dynamic> json) => Stochastic(
        iStochPeriod:
            json["iStochPeriod"] == null ? null : json["iStochPeriod"],
        iStochValue: json["iStochValue"] == null ? null : json["iStochValue"],
        iStochsigValue:
            json["iStochsigValue"] == null ? null : json["iStochsigValue"],
        iStochsigStoch:
            json["iStochsigStoch"] == null ? null : json["iStochsigStoch"],
      );

  Map<String, dynamic> toMap() => {
        "iStochPeriod": iStochPeriod == null ? null : iStochPeriod,
        "iStochValue": iStochValue == null ? null : iStochValue,
        "iStochsigValue": iStochsigValue == null ? null : iStochsigValue,
        "iStochsigStoch": iStochsigStoch == null ? null : iStochsigStoch,
      };
}

class Wpr {
  Wpr({
    this.iWprPeriod,
    this.iWprValue,
    this.iWprSignal,
  });

  int iWprPeriod;
  String iWprValue;
  int iWprSignal;

  factory Wpr.fromJson(String str) => Wpr.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wpr.fromMap(Map<String, dynamic> json) => Wpr(
        iWprPeriod: json["iWPRPeriod"] == null ? null : json["iWPRPeriod"],
        iWprValue: json["iWPRValue"] == null ? null : json["iWPRValue"],
        iWprSignal: json["iWPRSignal"] == null ? null : json["iWPRSignal"],
      );

  Map<String, dynamic> toMap() => {
        "iWPRPeriod": iWprPeriod == null ? null : iWprPeriod,
        "iWPRValue": iWprValue == null ? null : iWprValue,
        "iWPRSignal": iWprSignal == null ? null : iWprSignal,
      };
}

class Price {
  Price({
    this.iPricePeriod,
    this.iPriceOpen,
    this.iPriceHigh,
    this.iPriceLow,
    this.iPriceClose,
  });

  int iPricePeriod;
  String iPriceOpen;
  String iPriceHigh;
  String iPriceLow;
  String iPriceClose;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        iPricePeriod:
            json["iPricePeriod"] == null ? null : json["iPricePeriod"],
        iPriceOpen: json["iPriceOpen"] == null ? null : json["iPriceOpen"],
        iPriceHigh: json["iPriceHigh"] == null ? null : json["iPriceHigh"],
        iPriceLow: json["iPriceLow"] == null ? null : json["iPriceLow"],
        iPriceClose: json["iPriceClose"] == null ? null : json["iPriceClose"],
      );

  Map<String, dynamic> toMap() => {
        "iPricePeriod": iPricePeriod == null ? null : iPricePeriod,
        "iPriceOpen": iPriceOpen == null ? null : iPriceOpen,
        "iPriceHigh": iPriceHigh == null ? null : iPriceHigh,
        "iPriceLow": iPriceLow == null ? null : iPriceLow,
        "iPriceClose": iPriceClose == null ? null : iPriceClose,
      };
}
