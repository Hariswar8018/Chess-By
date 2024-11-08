import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.Chess_Level,
    required this.Email,
    required this.Name,
    required this.Pic_link,
    required this.Bio,
    required this.Draw,
    required this.Gender,
    required this.Language,
    required this.Location,
    required this.Lose,
    required this.Talk,
    required this.Won,
    required this.uid,
    required this.Lat,
    required this.Lon,
    required this.lastlogin,
    required this.code,
    required this.age,
    required this.lastloginn,
    required this.State,
    required this.token,
    required this.preference,
    required this.language,
    required this.filterpreference,
    required this.filterlanguage,
    required this.filterskill,
    required this.chesscomra,
    required this.lichesorgran,
    required this.chesscomu,
    required this.lichessorgu,
    required this.fpreference,
    required this.fgamelevel,
    required this.favailable,
    required this.flanguage,
    required this.block,
    required this.Report,
  });

  late final String Chess_Level;
  late final String Email;
  late final String Name;
  late final String Pic_link;
  late final String Bio;
  late final int Draw;
  late final String Gender;
  late final String Language;
  late final String Location;
  late final int Lose;
  late final String Talk;
  late final int Won;
  late final String uid;
  late final double Lat;
  late final double Lon;
  late final String lastlogin;
  late final String code;
  late final String age;
  late final String lastloginn;
  late final String State;
  late final String token;
  late final List<dynamic> preference;
  late final List<dynamic> language;
  late final List<dynamic> filterpreference;
  late final List<dynamic> filterlanguage;
  late final String filterskill;
  late final int chesscomra;
  late final int lichesorgran;
  late final String chesscomu;
  late final String lichessorgu;
  late final String fpreference;
  late final String fgamelevel;
  late final String favailable;
  late final String flanguage;
  late final List<dynamic> block;
  late final List<dynamic> Report;

  UserModel.fromJson(Map<String, dynamic> json) {
    Chess_Level = json['Chess_Level'] ?? 'NA';
    Email = json['Email'] ?? 'demo@demo.com';
    Name = json['Name'] ?? 'samai';
    State = json['State'] ?? 'NA';
    Pic_link = json['Pic_link'] ?? 'https://i.pinimg.com/736x/98/fc/63/98fc635fae7bb3e63219dd270f88e39d.jpg';
    Bio = json['Bio'] ?? 'Demo';
    Draw = json['Draw'] ?? 0;
    Gender = json['Gender'] ?? "Male";
    Language = json['Language'] ?? "English";
    Location = json['Location'] ?? "Spain";
    Lose = json['Lose'] ?? 0;
    Talk = json['Talk'] ?? "Little Talkative";
    Won = json['Won'] ?? 0;
    uid = json['uid'] ?? "Hello";
    Lat = json['Lat'] ?? 22.2661556;
    Lon = json['Lon'] ?? 84.9088836;
    lastlogin = json['lastlogin'] ?? "73838";
    code = json["Code"] ?? "0124";
    age = json["Age"] ?? "20";
    lastloginn = json['lastloginn'] ?? "7986345";
    token = json['token'] ?? "default_token";
    preference = List<dynamic>.from(json['preference'] ?? []);
    language = List<dynamic>.from(json['language'] ?? []);
    filterpreference = List<dynamic>.from(json['filterpreference'] ?? []);
    filterlanguage = List<dynamic>.from(json['filterlanguage'] ?? []);
    filterskill = json['filterskill'] ?? '';
    chesscomra = json['chesscomra'] ?? 0;
    lichesorgran = json['lichesorgran'] ?? 0;
    chesscomu = json['chesscomu'] ?? '';
    lichessorgu = json['lichessorgu'] ?? '';
    fpreference = json['fpreference'] ?? 'NA';
    fgamelevel = json['fgamelevel'] ?? "NA";
    favailable = json['favailable'] ?? "NA";
    flanguage = json['flanguage'] ?? 'NA';
    block = List<dynamic>.from(json['block'] ?? []);
    Report = List<dynamic>.from(json['Report'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Chess_Level'] = Chess_Level;
    data['Email'] = Email;
    data['Name'] = Name;
    data['Pic_link'] = Pic_link;
    data['Bio'] = Bio;
    data['Age'] = age;
    data['Gender'] = Gender;
    data['uid'] = uid;
    data['Draw'] = Draw;
    data['Lose'] = Lose;
    data['Won'] = Won;
    data['Language'] = Language;
    data['Location'] = Location;
    data['Code'] = code;
    data['Talk'] = Talk;
    data['Lat'] = Lat;
    data['Lon'] = Lon;
    data['lastlogin'] = lastlogin;
    data['lastloginn'] = lastloginn;
    data['State'] = State;
    data['token'] = token;
    data['preference'] = preference;
    data['language'] = language;
    data['filterpreference'] = filterpreference;
    data['filterlanguage'] = filterlanguage;
    data['filterskill'] = filterskill;
    data['chesscomra'] = chesscomra;
    data['lichesorgran'] = lichesorgran;
    data['chesscomu'] = chesscomu;
    data['lichessorgu'] = lichessorgu;
    data['fpreference'] = fpreference;
    data['fgamelevel'] = fgamelevel;
    data['favailable'] = favailable;
    data['flanguage'] = flanguage;
    data['block'] = block;
    data['Report'] = Report;
    return data;
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel.fromJson(snapshot);
  }
}
