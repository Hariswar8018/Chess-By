import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  TeacherModel({
    required this.uid,
    required this.Email,
    required this.Name,
    required this.Pic_link,
    required this.Price_N,
    required this.Minutes_N,
    required this.Reviews_N,
    required this.Study,
    required this.Language,
    required this.Active_N,
    required this.Special_Bio,
    required this.Bio_Bio,
    required this.Shedule,
    required this.Imp_N,
    required this.Tap_N,
    required this.Joined,
    required this.Phone,
    required this.lastlogin,
    required this.Gender,
    required this.Bio,
    required this.clientId,
    required this.secretkey,
  });


  late final int Price_N;
  late final int Minutes_N;
  late final int Reviews_N;
  late final String Study;
  late final List Active_N;
  late final String Special_Bio;
  late final String Bio_Bio;
  late final String Shedule;
  late final List Imp_N;
  late final List Tap_N;
  late final String Joined;
  late final int Phone;
  late final String Email;
  late final String Name;
  late final String Pic_link;
  late final String Bio;
  late final String Gender;
  late final String Language;
  late final String uid;
  late final String lastlogin;
  late final String clientId;
  late final String secretkey;


  TeacherModel.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'] ?? " ";
    secretkey = json['secretkey'] ?? " ";
    Price_N = json["Price_N"] ?? 10;
    Minutes_N = json["Minutes_N"] ?? 50;
    Reviews_N = json["Reviews_N"] ?? 1;
    Imp_N = json["Imp_N"] ?? ["hh"];
    Tap_N = json["Imp_N"] ?? ["hh"];
    Study = json["Study"] ?? " A good";
    Active_N = json["Active_N"] ?? ["hhh"];
    Email = json['Email'] ?? 'demo@demo.com';
    Name = json['Name'] ?? 'samai';
    Pic_link = json['Pic_link'] ??
        'https://i.pinimg.com/736x/98/fc/63/98fc635fae7bb3e63219dd270f88e39d.jpg';
    Bio_Bio = json['Bio_Bio'] ?? 'Demo';
    Joined = json["Joined"] ?? "456";
    Language = json['Language'] ?? "English";
    uid = json['uid'] ?? "hs5b7a8vj0f6ZrUlY2zHVR1wuEk1";
    Phone = json["Phone"] ?? 917978097489 ;
    lastlogin = json['lastlogin'] ?? "73838";
    Special_Bio = json["Special_Bio"] ?? "A Good Boy I am";
    Bio = json['Bio'] ?? "Certified tutor with experience at universities and Japanese language schools";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['secretkey'] = secretkey;
    data['Price_N'] = Price_N;
    data['Minutes_N'] = Minutes_N;
    data['Reviews_N'] = Reviews_N;
    data['Imp_N'] = Imp_N;
    data['Tap_N'] = Tap_N;
    data['Study'] = Study;
    data['Active_N'] = Active_N;
    data['Email'] = Email;
    data['Name'] = Name;
    data['Pic_link'] = Pic_link;
    data['Bio_Bio'] = Bio_Bio;
    data['Joined'] = Joined;
    data['Language'] = Language;
    data['uid'] = uid;
    data['Phone'] = Phone;
    data['lastlogin'] = lastlogin;
    data['Special_Bio'] = Special_Bio;
    data['Bio'] = Bio;
    return data;
  }

  static TeacherModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return TeacherModel(
      clientId: snapshot['clientId'] ?? " ",
      secretkey: snapshot['secretkey'] ?? " ",
      Price_N: snapshot["Price_N"] ?? 10,
      Minutes_N: snapshot["Minutes_N"] ?? 50,
      Reviews_N: snapshot["Reviews_N"] ?? 1,
      Imp_N: snapshot["Imp_N"] ?? ["hh"],
      Tap_N: snapshot["Imp_N"] ?? ["hh"],
      Study: snapshot["Study"] ?? " A good",
      Active_N: snapshot["Active_N"] ?? ["hhh"],
      Email: snapshot['Email'] ?? 'demo@demo.com',
      Name: snapshot['Name'] ?? 'samai',
      Pic_link: snapshot['Pic_link'] ??
          'https://i.pinimg.com/736x/98/fc/63/98fc635fae7bb3e63219dd270f88e39d.jpg',
      Bio_Bio: snapshot['Bio_Bio'] ?? 'Demo',
      Joined: snapshot["Joined"] ?? "456",
      Language: snapshot['Language'] ?? "English",
      uid: snapshot['uid'] ?? "hs5b7a8vj0f6ZrUlY2zHVR1wuEk1",
      Phone: snapshot["Phone"] ?? 917978097489,
      lastlogin: snapshot['lastlogin'] ?? "73838",
      Special_Bio: snapshot["Special_Bio"] ?? "A Good Boy I am",
      Bio: snapshot['Bio'] ??
          "Certified tutor with experience at universities and Japanese language schools", Shedule: 'u', Gender: snapshot["Gender"] ?? "Male",
    );
  }

}
