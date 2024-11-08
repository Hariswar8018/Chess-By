class NotificationModel {
  NotificationModel({
    required this.myname,
    required this.myid,
    required this.datee,
    required this.timee,
    required this.preference,
    required this.locationpic,
    required this.locationname,
    required this.locationaddress,
    required this.locationlat,
    required this.locationlon,
    required this.locationrating,
    required this.locationid,
    required this.accept,
    required this.reject,
    required this.seen,
    required this.sendername,
    required this.senderid,
    required this.senderpic,
    required this.mypic,
    required this.mytoken,
    required this.sendertoken,
    required this.id,
    required this.added,
    required this.added2,
  });

  late final String myname;
  late final String myid;
  late final String datee;
  late final String timee;
  late final List<dynamic> preference;
  late final String locationpic;
  late final String locationname;
  late final String locationaddress;
  late final double locationlat;
  late final double locationlon;
  late final double locationrating;
  late final String locationid;
  late final bool accept;
  late final bool reject;
  late final String seen;
  late final String sendername;
  late final String senderid;
  late final String senderpic;
  late final String mypic;
  late final String mytoken;
  late final String sendertoken;
  late final String id;
  late final List<dynamic> added;
  late final List<dynamic> added2;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    myname = json['myname'] ?? '';
    myid = json['myid'] ?? '';
    datee = json['datee'] ?? '';
    timee = json['timee'] ?? '';
    preference = List<dynamic>.from(json['preference'] ?? []);
    locationpic = json['locationpic'] ?? '';
    locationname = json['locationname'] ?? '';
    locationaddress = json['locationaddress'] ?? '';
    locationlat = (json['locationlat'] ?? 0.0).toDouble();
    locationlon = (json['locationlon'] ?? 0.0).toDouble();
    locationrating = (json['locationrating'] ?? 0.0).toDouble();
    locationid = json['locationid'] ?? "";
    accept = json['accept'] ?? false;
    reject = json['reject'] ?? false;
    seen = json['seen'] ?? '';
    sendername = json['sendername'] ?? '';
    senderid = json['senderid'] ?? '';
    senderpic = json['senderpic'] ?? '';
    mypic = json['mypic'] ?? '';
    mytoken = json['mytoken'] ?? '';
    sendertoken = json['sendertoken'] ?? '';
    id = json['id'] ?? '';
    added = List<dynamic>.from(json['added'] ?? []);
    added2 = List<dynamic>.from(json['added2'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['myname'] = myname;
    data['myid'] = myid;
    data['datee'] = datee;
    data['timee'] = timee;
    data['preference'] = preference;
    data['locationpic'] = locationpic;
    data['locationname'] = locationname;
    data['locationaddress'] = locationaddress;
    data['locationlat'] = locationlat;
    data['locationlon'] = locationlon;
    data['locationrating'] = locationrating;
    data['locationid'] = locationid;
    data['accept'] = accept;
    data['reject'] = reject;
    data['seen'] = seen;
    data['sendername'] = sendername;
    data['senderid'] = senderid;
    data['senderpic'] = senderpic;
    data['mypic'] = mypic;
    data['mytoken'] = mytoken;
    data['sendertoken'] = sendertoken;
    data['id'] = id;
    data['added'] = added;
    data['added2'] = added2;
    return data;
  }
}
