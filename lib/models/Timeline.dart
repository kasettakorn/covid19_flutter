
import 'dart:convert';

ResTimeline resTimelineFromJson(String str) => ResTimeline.fromJson(json.decode(str));

String resTimelineToJson(ResTimeline data) => json.encode(data.toJson());

class ResTimeline {
  String updateDate;
  String source;
  String devBy;
  String severBy;
  List<Datum> data;

  ResTimeline({
    this.updateDate,
    this.source,
    this.devBy,
    this.severBy,
    this.data,
  });

  factory ResTimeline.fromJson(Map<String, dynamic> json) => ResTimeline(
    updateDate: json["UpdateDate"],
    source: json["Source"],
    devBy: json["DevBy"],
    severBy: json["SeverBy"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UpdateDate": updateDate,
    "Source": source,
    "DevBy": devBy,
    "SeverBy": severBy,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String date;
  int newConfirmed;
  int newRecovered;
  int newHospitalized;
  int newDeaths;
  int confirmed;
  int recovered;
  int hospitalized;
  int deaths;

  Datum({
    this.date,
    this.newConfirmed,
    this.newRecovered,
    this.newHospitalized,
    this.newDeaths,
    this.confirmed,
    this.recovered,
    this.hospitalized,
    this.deaths,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["Date"],
    newConfirmed: json["NewConfirmed"],
    newRecovered: json["NewRecovered"],
    newHospitalized: json["NewHospitalized"],
    newDeaths: json["NewDeaths"],
    confirmed: json["Confirmed"],
    recovered: json["Recovered"],
    hospitalized: json["Hospitalized"],
    deaths: json["Deaths"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "NewConfirmed": newConfirmed,
    "NewRecovered": newRecovered,
    "NewHospitalized": newHospitalized,
    "NewDeaths": newDeaths,
    "Confirmed": confirmed,
    "Recovered": recovered,
    "Hospitalized": hospitalized,
    "Deaths": deaths,
  };
}
