import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentModel {
  TournamentModel({
    required this.name,
    required this.system,
    this.join = false,
    required this.dateTime,
    required this.id,
    required this.totalPrize,
    required this.organizer,
    required this.venue,
    required this.reachingTime,
    this.offline = true,
    required this.players,
    required this.description,
    required this.terms,
    required this.first,
    required this.second,
    required this.perCard,
    required this.preference,
    required this.pic,
    required this.endDateTime,
    required this.userid
  });

  late final String name;
  late final String system;
  late final bool join;
  late final String dateTime;
  late final String id;
  late final String userid;
  late final String totalPrize;
  late final String organizer;
  late final String venue;
  late final String reachingTime;
  late final bool offline;
  late final List<dynamic> players;
  late final String description;
  late final String terms;
  late final String first;
  late final String second;
  late final String perCard;
  late final List<dynamic> preference;
  late final List<dynamic> pic;
  late final String endDateTime;

  TournamentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? 'Tournament';
    system = json['system'] ?? 'Swiss';
    userid=json['userid']??"UjvXgSe6yrY7hIlqcFMlKC91VuE3";
    join = json['join'] ?? false;
    dateTime = json['dateTime'] ?? '2024-01-01 00:00:00';
    id = json['id'] ?? 'default_id';
    totalPrize = json['total_prize'] ?? '0';
    organizer = json['organizer'] ?? 'Unknown';
    venue = json['venue'] ?? 'Default Venue';
    reachingTime = json['reaching_time'] ?? '00:00';
    offline = json['offline'] ?? true;
    players = List<dynamic>.from(json['players'] ?? []);
    description = json['description'] ?? 'No description available.';
    terms = json['terms'] ?? 'No terms provided.';
    first = json['first'] ?? '0';
    second = json['second'] ?? '0';
    perCard = json['perCard'] ?? '0';
    preference = List<dynamic>.from(json['preference'] ?? []);
    pic = List<dynamic>.from(json['pic'] ?? []);
    endDateTime = json['enddatetime'] ?? '2024-01-01 23:59:59';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['system'] = system;
    data['userid']=userid;
    data['join'] = join;
    data['dateTime'] = dateTime;
    data['id'] = id;
    data['total_prize'] = totalPrize;
    data['organizer'] = organizer;
    data['venue'] = venue;
    data['reaching_time'] = reachingTime;
    data['offline'] = offline;
    data['players'] = players;
    data['description'] = description;
    data['terms'] = terms;
    data['first'] = first;
    data['second'] = second;
    data['perCard'] = perCard;
    data['preference'] = preference;
    data['pic'] = pic;
    data['enddatetime'] = endDateTime;
    return data;
  }

  static TournamentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return TournamentModel.fromJson(snapshot);
  }
}
