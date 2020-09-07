import 'dart:convert';

class TopBroker {
  TopBroker({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<DataBroker> data;

  factory TopBroker.fromJson(String str) => TopBroker.fromMap(json.decode(str));

  factory TopBroker.fromMap(Map<String, dynamic> json) => TopBroker(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataBroker>.from(
                json["data"].map((x) => DataBroker.fromMap(x))),
      );
}

class DataBroker {
  DataBroker({
    this.brokerId,
    this.brokerName,
    this.brokerRate,
    this.brokerIntro,
    this.brokerRegulation,
    this.brokerModel,
    this.brokerDemo,
    this.brokerMinDepo,
    this.brokerFound,
    this.brokerPros,
    this.brokerCros,
    this.brokerImg,
    this.brokerAffiliate,
    this.brokerPromo,
  });

  String brokerId;
  String brokerName;
  double brokerRate;
  String brokerIntro;
  String brokerRegulation;
  String brokerModel;
  String brokerDemo;
  String brokerMinDepo;
  String brokerFound;
  String brokerPros;
  String brokerCros;
  String brokerImg;
  String brokerAffiliate;
  List<BrokerPromo> brokerPromo;

  factory DataBroker.fromJson(String str) =>
      DataBroker.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataBroker.fromMap(Map<String, dynamic> json) => DataBroker(
        brokerId: json["BrokerID"] == null ? null : json["BrokerID"],
        brokerName: json["BrokerName"] == null ? null : json["BrokerName"],
        brokerRate:
            json["BrokerRate"] == null ? null : json["BrokerRate"].toDouble(),
        brokerIntro: json["BrokerIntro"] == null ? null : json["BrokerIntro"],
        brokerRegulation:
            json["BrokerRegulation"] == null ? null : json["BrokerRegulation"],
        brokerModel: json["BrokerModel"] == null ? null : json["BrokerModel"],
        brokerDemo: json["BrokerDemo"] == null ? null : json["BrokerDemo"],
        brokerMinDepo:
            json["BrokerMinDepo"] == null ? null : json["BrokerMinDepo"],
        brokerFound: json["BrokerFound"] == null ? null : json["BrokerFound"],
        brokerPros: json["BrokerPros"] == null ? null : json["BrokerPros"],
        brokerCros: json["BrokerCros"] == null ? null : json["BrokerCros"],
        brokerImg: json["BrokerImg"] == null ? null : json["BrokerImg"],
        brokerAffiliate:
            json["BrokerAffiliate"] == null ? null : json["BrokerAffiliate"],
        brokerPromo: json["BrokerPromo"] == null
            ? null
            : List<BrokerPromo>.from(
                json["BrokerPromo"].map((x) => BrokerPromo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "BrokerID": brokerId == null ? null : brokerId,
        "BrokerName": brokerName == null ? null : brokerName,
        "BrokerRate": brokerRate == null ? null : brokerRate,
        "BrokerIntro": brokerIntro == null ? null : brokerIntro,
        "BrokerRegulation": brokerRegulation == null ? null : brokerRegulation,
        "BrokerModel": brokerModel == null ? null : brokerModel,
        "BrokerDemo": brokerDemo == null ? null : brokerDemo,
        "BrokerMinDepo": brokerMinDepo == null ? null : brokerMinDepo,
        "BrokerFound": brokerFound == null ? null : brokerFound,
        "BrokerPros": brokerPros == null ? null : brokerPros,
        "BrokerCros": brokerCros == null ? null : brokerCros,
        "BrokerImg": brokerImg == null ? null : brokerImg,
        "BrokerAffiliate": brokerAffiliate == null ? null : brokerAffiliate,
        "BrokerPromo": brokerPromo == null
            ? null
            : List<dynamic>.from(brokerPromo.map((x) => x.toMap())),
      };
}

class BrokerPromo {
  BrokerPromo({
    this.prmBrokerId,
    this.brokerId,
    this.prmBrokerTitle,
    this.prmBrokerCaption,
    this.prmBrokerLink,
    this.prmBrokerImg,
  });

  String prmBrokerId;
  String brokerId;
  String prmBrokerTitle;
  String prmBrokerCaption;
  String prmBrokerLink;
  String prmBrokerImg;

  factory BrokerPromo.fromJson(String str) =>
      BrokerPromo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrokerPromo.fromMap(Map<String, dynamic> json) => BrokerPromo(
        prmBrokerId: json["prmBrokerID"] == null ? null : json["prmBrokerID"],
        brokerId: json["BrokerID"] == null ? null : json["BrokerID"],
        prmBrokerTitle:
            json["prmBrokerTitle"] == null ? null : json["prmBrokerTitle"],
        prmBrokerCaption:
            json["prmBrokerCaption"] == null ? null : json["prmBrokerCaption"],
        prmBrokerLink:
            json["prmBrokerLink"] == null ? null : json["prmBrokerLink"],
        prmBrokerImg:
            json["prmBrokerImg"] == null ? null : json["prmBrokerImg"],
      );

  Map<String, dynamic> toMap() => {
        "prmBrokerID": prmBrokerId == null ? null : prmBrokerId,
        "BrokerID": brokerId == null ? null : brokerId,
        "prmBrokerTitle": prmBrokerTitle == null ? null : prmBrokerTitle,
        "prmBrokerCaption": prmBrokerCaption == null ? null : prmBrokerCaption,
        "prmBrokerLink": prmBrokerLink == null ? null : prmBrokerLink,
        "prmBrokerImg": prmBrokerImg == null ? null : prmBrokerImg,
      };
}
