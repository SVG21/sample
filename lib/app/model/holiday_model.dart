
import 'dart:convert';

Holidays holidaysFromJson(String str) => Holidays.fromJson(json.decode(str));

String holidaysToJson(Holidays data) => json.encode(data.toJson());

class Holidays {
  Holidays( {
    required this.englandAndWales,
    required this.scotland,
    required this.northernIreland,
  });

  EnglandAndWales englandAndWales;
  EnglandAndWales scotland;
  EnglandAndWales northernIreland;



  factory Holidays.fromJson(Map<String, dynamic> json) => Holidays(
    englandAndWales: EnglandAndWales.fromJson(json["england-and-wales"]),
    scotland: EnglandAndWales.fromJson(json["scotland"]),
    northernIreland: EnglandAndWales.fromJson(json["northern-ireland"]),
  );

  Map<String, dynamic> toJson() => {
    "england-and-wales": englandAndWales.toJson(),
    "scotland": scotland.toJson(),
    "northern-ireland": northernIreland.toJson(),
  };
}

class EnglandAndWales {
  EnglandAndWales({
    required this.division,
    required this.events,
  });

  String? division;
  List<Event> events;

  factory EnglandAndWales.fromJson(Map<String, dynamic> json) => EnglandAndWales(
    division: json["division"],
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "division": division,
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    required this.title,
    required this.date,

    required this.bunting,
  });

  String? title;
  DateTime date;
  bool bunting;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    title: json["title"],
    date: DateTime.parse(json["date"]),
    bunting: json["bunting"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "bunting": bunting,
  };
}



