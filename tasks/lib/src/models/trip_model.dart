// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Trip> trips;

  Welcome({required this.trips});

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    trips: List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trips": List<dynamic>.from(trips.map((x) => x.toJson())),
  };
}

class Trip {
  String id;
  String status;
  String title;
  Dates dates;
  List<Participant> participants;
  int unfinishedTasks;
  String coverImage;

  Trip({
    required this.id,
    required this.status,
    required this.title,
    required this.dates,
    required this.participants,
    required this.unfinishedTasks,
    required this.coverImage,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"],
    status: json["status"],
    title: json["title"],
    dates: Dates.fromJson(json["dates"]),
    participants: List<Participant>.from(
      json["participants"].map((x) => Participant.fromJson(x)),
    ),
    unfinishedTasks: json["unfinished_tasks"],
    coverImage: json["cover_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "title": title,
    "dates": dates.toJson(),
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    "unfinished_tasks": unfinishedTasks,
    "cover_image": coverImage,
  };
}

class Dates {
  String start;
  String end;

  Dates({required this.start, required this.end});

  factory Dates.fromJson(Map<String, dynamic> json) =>
      Dates(start: json["start"], end: json["end"]);

  Map<String, dynamic> toJson() => {"start": start, "end": end};
}

class Participant {
  String name;
  String avatarUrl;

  Participant({required this.name, required this.avatarUrl});

  factory Participant.fromJson(Map<String, dynamic> json) =>
      Participant(name: json["name"], avatarUrl: json["avatar_url"]);

  Map<String, dynamic> toJson() => {"name": name, "avatar_url": avatarUrl};
}
