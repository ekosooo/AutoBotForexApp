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

  factory DetailAnalysisSignal.fromMap(Map<String, dynamic> json) =>
      DetailAnalysisSignal(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );
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
  String iAdrDirection;

  factory Adr.fromJson(String str) => Adr.fromMap(json.decode(str));

  factory Adr.fromMap(Map<String, dynamic> json) => Adr(
        iAdrUpper: json["upper"] == null ? null : json["upper"],
        iAdrLower: json["lower"] == null ? null : json["lower"],
        iAdrRange: json["range"] == null ? null : json["range"],
        iAdrPersen: json["persen"] == null ? null : json["persen"],
        iAdrDirection: json["direction"] == null ? null : json["direction"],
      );
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

  String iBbPeriod;
  String iBbTop;
  String iBbMid;
  String iBbBottom;
  String iBbSignal;

  factory Bb.fromJson(String str) => Bb.fromMap(json.decode(str));

  factory Bb.fromMap(Map<String, dynamic> json) => Bb(
        iBbPeriod: json["period"] == null ? null : json["period"],
        iBbTop: json["top"] == null ? null : json["top"],
        iBbMid: json["mid"] == null ? null : json["mid"],
        iBbBottom: json["bottom"] == null ? null : json["bottom"],
        iBbSignal: json["signal"] == null ? null : json["signal"],
      );
}

class Envelope {
  Envelope({
    this.iEnvPeriod,
    this.iEnvUpper,
    this.iEnvLower,
    this.iEnvSignal,
  });

  String iEnvPeriod;
  String iEnvUpper;
  String iEnvLower;
  String iEnvSignal;

  factory Envelope.fromJson(String str) => Envelope.fromMap(json.decode(str));

  factory Envelope.fromMap(Map<String, dynamic> json) => Envelope(
        iEnvPeriod: json["period"] == null ? null : json["period"],
        iEnvUpper: json["upper"] == null ? null : json["upper"],
        iEnvLower: json["lower"] == null ? null : json["lower"],
        iEnvSignal: json["signal"] == null ? null : json["signal"],
      );
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
  String iMokuSignal;

  factory Ichimoku.fromJson(String str) => Ichimoku.fromMap(json.decode(str));

  factory Ichimoku.fromMap(Map<String, dynamic> json) => Ichimoku(
        iMokuTenkan: json["tenkan"] == null ? null : json["tenkan"],
        iMokuKijun: json["kijun"] == null ? null : json["kijun"],
        iMokuSsa: json["ssa"] == null ? null : json["ssa"],
        iMokuSsb: json["ssb"] == null ? null : json["ssb"],
        iMokuChikou: json["chikou"] == null ? null : json["chikou"],
        iMokuSignal: json["signal"] == null ? null : json["signal"],
      );
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

  String iMaPeriod;
  String iMaSimple;
  String iMaExponential;
  String iMaSmoothed;
  String iMalw;
  String iMaSigSimple;
  String iMaSigExponential;
  String iMaSigSmoothed;
  String iMaSigLw;

  factory Ma.fromJson(String str) => Ma.fromMap(json.decode(str));

  factory Ma.fromMap(Map<String, dynamic> json) => Ma(
        iMaPeriod: json["period"] == null ? null : json["period"],
        iMaSimple: json["simple"] == null ? null : json["simple"],
        iMaExponential:
            json["exponential"] == null ? null : json["exponential"],
        iMaSmoothed: json["smoothed"] == null ? null : json["smoothed"],
        iMalw: json["lw"] == null ? null : json["lw"],
        iMaSigSimple: json["sigsimple"] == null ? null : json["sigsimple"],
        iMaSigExponential: json["sigsimple"] == null ? null : json["sigsimple"],
        iMaSigSmoothed: json["siglw"] == null ? null : json["siglw"],
        iMaSigLw: json["iMASigLW"] == null ? null : json["iMASigLW"],
      );
}

class Rsi {
  Rsi({
    this.iRsiPeriod,
    this.iRsiValue,
    this.iRsiSignal,
  });

  String iRsiPeriod;
  String iRsiValue;
  String iRsiSignal;

  factory Rsi.fromJson(String str) => Rsi.fromMap(json.decode(str));

  factory Rsi.fromMap(Map<String, dynamic> json) => Rsi(
        iRsiPeriod: json["period"] == null ? null : json["period"],
        iRsiValue: json["value"] == null ? null : json["value"],
        iRsiSignal: json["signal"] == null ? null : json["signal"],
      );
}

class Stochastic {
  Stochastic({
    this.iStochPeriod,
    this.iStochValue,
    this.iStochsigValue,
    this.iStochsigStoch,
  });

  String iStochPeriod;
  String iStochValue;
  String iStochsigValue;
  String iStochsigStoch;

  factory Stochastic.fromJson(String str) =>
      Stochastic.fromMap(json.decode(str));

  factory Stochastic.fromMap(Map<String, dynamic> json) => Stochastic(
        iStochPeriod: json["period"] == null ? null : json["period"],
        iStochValue: json["value"] == null ? null : json["value"],
        iStochsigValue: json["sigvalue"] == null ? null : json["sigvalue"],
        iStochsigStoch: json["sigstoch"] == null ? null : json["sigstoch"],
      );
}

class Wpr {
  Wpr({
    this.iWprPeriod,
    this.iWprValue,
    this.iWprSignal,
  });

  String iWprPeriod;
  String iWprValue;
  String iWprSignal;

  factory Wpr.fromJson(String str) => Wpr.fromMap(json.decode(str));

  factory Wpr.fromMap(Map<String, dynamic> json) => Wpr(
        iWprPeriod: json["period"] == null ? null : json["period"],
        iWprValue: json["value"] == null ? null : json["value"],
        iWprSignal: json["signal"] == null ? null : json["signal"],
      );
}

class Price {
  Price({
    this.iPricePeriod,
    this.iPriceOpen,
    this.iPriceHigh,
    this.iPriceLow,
    this.iPriceClose,
  });

  String iPricePeriod;
  String iPriceOpen;
  String iPriceHigh;
  String iPriceLow;
  String iPriceClose;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        iPricePeriod: json["period"] == null ? null : json["period"],
        iPriceOpen: json["open"] == null ? null : json["open"],
        iPriceHigh: json["high"] == null ? null : json["high"],
        iPriceLow: json["low"] == null ? null : json["low"],
        iPriceClose: json["close"] == null ? null : json["close"],
      );
}
