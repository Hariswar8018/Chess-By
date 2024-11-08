import 'package:cloud_firestore/cloud_firestore.dart';

class ClubModel {
  ClubModel({
    required this.Email,
    required this.Name,
    required this.HEmail,
    required this.HName,
    required this.uid,
    required this.Pic_link,
    required this.Bio,
    required this.Language,
    required this.Location,
    required this.Lat,
    required this.Lon,
    required this.lastlogin,
    required this.Create,
    required this.Lastlogin,
    required this.discord,
    required this.facebook,
    required this.instagram,
    required this.linkedin,
    required this.twitter,
    required this.whatsapp,
    required this.Clublist,
    required this.State,
    required this.ratingpeople,
    required this.ratingsnumber,
    required this.blocks, // Add blocks parameter
  });

  late final String Email;
  late final String HEmail;
  late final String HName;
  late final String Name;
  late final String uid;
  late final String Pic_link;
  late final String Bio;
  late final List Clublist;
  late final String Language;
  late final String Location;
  late final double Lat;
  late final double Lon;
  late final String lastlogin;
  late final String Create;
  late final String Lastlogin;
  late final String State;
  late final String facebook;
  late final String instagram;
  late final String whatsapp;
  late final String discord;
  late final String linkedin;
  late final String twitter;
  late final int ratingpeople;
  late final int ratingsnumber;
  late final List<String> blocks; // Define the blocks list

  ClubModel.fromJson(Map<String, dynamic> json) {
    Email = json['Email'] ?? 'demo@demo.com';
    Name = json['Name'] ?? 'samai';
    HEmail = json['HEmail'] ?? 'demo@demo.com';
    HName = json['HName'] ?? 'samai';
    uid = json['uid'] ?? '67';
    Clublist = json['ClubList'] ?? [];
    Pic_link = json['Pic_link'] ?? 'https://i.pinimg.com/736x/98/fc/63/98fc635fae7bb3e63219dd270f88e39d.jpg';
    Bio = json['Bio'] ?? 'Demo';
    Language = json['Language'] ?? "English";
    Create = json["Create"] ?? "777";
    facebook = json["Facebook"] ?? "http";
    instagram = json["Instagram"] ?? "http";
    whatsapp = json["Whatsapp"] ?? "http";
    discord = json["Discord"] ?? "http";
    linkedin = json["LinkedIn"] ?? "http";
    twitter = json["X"] ?? "http";
    Location = json['Location'] ?? "Spain";
    State = json['State'] ?? "Canary Islands";
    Lat = json['Lat'] ?? 22.7;
    Lon = json['Lon'] ?? 33.5;
    lastlogin = json['Lastlogin'] ?? "73838";
    ratingpeople = json['ratingpeople'] ?? 0;
    ratingsnumber = json['ratingsnumber'] ?? 0;
    blocks = List<String>.from(json['blocks'] ?? []); // Initialize blocks
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Email'] = Email;
    data['Name'] = Name;
    data['HEmail'] = HEmail;
    data['HName'] = HName;
    data['uid'] = uid;
    data['ClubList'] = Clublist;
    data['Pic_link'] = Pic_link;
    data['Bio'] = Bio;
    data['Language'] = Language;
    data['Create'] = Create;
    data['Facebook'] = facebook;
    data['Instagram'] = instagram;
    data['Whatsapp'] = whatsapp;
    data['Discord'] = discord;
    data['LinkedIn'] = linkedin;
    data['X'] = twitter;
    data['State'] = State;
    data['Location'] = Location;
    data['Lat'] = Lat;
    data['Lon'] = Lon;
    data['Lastlogin'] = lastlogin;
    data['ratingpeople'] = ratingpeople;
    data['ratingsnumber'] = ratingsnumber;
    data['blocks'] = blocks; // Add blocks to JSON
    return data;
  }

  factory ClubModel.fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return ClubModel.fromJson(data);
  }
}
