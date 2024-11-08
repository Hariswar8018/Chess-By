import 'dart:math';
import 'dart:math';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/club_full_card.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/club_chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/main%20page/Notifications/mynavigation.dart';
import 'package:chessby/main%20page/home.dart';
import 'package:chessby/main%20page/profile_second/points.dart';
import 'package:chessby/main%20page/tournaments.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/noti.dart';
import 'package:chessby/models/tournament.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class New_Home extends StatefulWidget {
  New_Home({super.key});

  @override
  State<New_Home> createState() => _New_HomeState();
}

class _New_HomeState extends State<New_Home> {
  // Define Futures for the data
  String h = " ";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void fg() async{
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message in foreground: ${message.notification?.title}");
      _showNotification(message);
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', // Unique channel ID
        'your_channel_name', // User-friendly channel name
        channelDescription: 'Your channel description', // Description of the channel
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

      // Using a unique ID for each notification
      int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000); // Unique ID based on timestamp

      await flutterLocalNotificationsPlugin.show(
        notificationId, // Unique Notification ID
        message.notification?.title, // Notification title
        message.notification?.body, // Notification body
        platformChannelSpecifics, // Platform-specific settings
        payload: 'item x', // Payload to handle on tap
      );
    } catch (e) {
      print("Error showing notification: $e");
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print(":gg");
    // Handle background message
  }
  void g() async{
    try {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      String? token = await _firebaseMessaging.getToken();
      print(token);
      if (token != null) {
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).update({
          'token': token,
        });
        _firebaseMessaging.requestPermission();
      }
    }catch(e){
      print(e);    }
  }
  initState() {
    super.initState();
    g();
    vq();
    fg();
    setState((){

    });
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      h  = prefs.getString('State') ?? "Canary Islands";
    });
    await _userprovider.refreshuser();
    DateTime now = DateTime.now();
    String s = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(s)
        .update({
      "lastloginn" : now.toString() ,
    });
  }

  final Future<List<UserModel>> _userFuture = FirebaseFirestore.instance
      .collection('users').where("chessplace",isEqualTo: false)
      .get()
      .then((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  final Future<List<ClubModel>> _clubFuture = FirebaseFirestore.instance
      .collection('clubs').where("status",isEqualTo: "Active")
      .get()
      .then((snapshot) => snapshot.docs.map((doc) => ClubModel.fromJson(doc.data() as Map<String, dynamic>)).toList());


  final Future<List<TournamentModel>> _tourn = FirebaseFirestore.instance.collection('Tournaments').orderBy("dateTime",descending: true)
      .get()
      .then((snapshot) => snapshot.docs.map((doc) => TournamentModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return AppLocalizations.of(context)!.translate('GoodMorning');
    } else if (hour >= 12 && hour < 17) {
      return AppLocalizations.of(context)!.translate('GoodAfternoon');
    } else {
      return AppLocalizations.of(context)!.translate('GoodEvening');
    }
  }

  final Future<List<NotificationModel>> _notificationFuture = FirebaseFirestore.instance
      .collection('Notification')
      .get()
      .then((snapshot) {
    final currentUserID = FirebaseAuth.instance.currentUser?.uid;
    return snapshot.docs
        .where((doc) {
      final data = doc.data();
      final accept = data['accept'] == true;
      final senderID = data['senderid'];
      final myID = data['myid'];
      return accept && (senderID == currentUserID || myID == currentUserID);
    })
        .map((doc) => NotificationModel.fromJson(doc.data()))
        .toList();
  });

  String getFirstWord(String input) {
    // Split the string into words based on whitespace
    List<String> words = input.trim().split(' ');

    if (words.isNotEmpty) {
      String firstWord = words.first;
      // Check the length of the first word
      if (firstWord.length > 12) {
        return firstWord.substring(0, 12); // Trim to 12 characters
      }
      return firstWord;
    }

    return ""; // Return an empty string if no words are found
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _value = 'one';


  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // Radius of Earth in kilometers

    final double dLat = (lat2 - lat1) * (pi / 180);
    final double dLon = (lon2 - lon1) * (pi / 180);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) *
            sin(dLon / 2) * sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in kilometers
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      drawer: Global.buildDrawer(context),
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,
          height: 95,
          width: w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: Countryy(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0, left: 10),
                  child: CircleAvatar(
                    backgroundColor: Global.yell,
                    radius: 25,
                    child: _user!.assetb?CircleAvatar(
                      radius: 23,
                      backgroundImage: AssetImage(_user!.assetn),
                    ): CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(_user!.Pic_link),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 38),
                  Text(
                    "   ${getGreeting()}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "  " + getFirstWord(_user.Name),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 1),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Points()),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Global.blac,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.subscriptions, color: Colors.yellowAccent),
                          SizedBox(width: 8),
                          Text(
                            (_user.Won + _user.lichesorgran + _user.chesscomra)
                                .toString(),
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 5),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Points()),
                      );
                    },
                    child: Container(
                      width:49,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Global.blac,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.account_balance_wallet, color: Colors.yellowAccent),
                          SizedBox(width: 3),
                          Text(
                            '0',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: (){
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0, left: 1),
                  child: CircleAvatar(
                    backgroundColor: Global.blac,
                    radius: 22,
                    child: Icon(Icons.more_horiz, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 3),
            ],
          ),
        ),
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Text("   ${AppLocalizations.of(context)!.translate('NearbyPlayers')}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: Preference(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 30)
                      ));
                    },
                    child: Text("   ${AppLocalizations.of(context)!.translate('Filter')} >  ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.yellow, fontSize: 14)),
                  ),
                ],
              ),
              SizedBox(height: 10),
            Container(
              width: w,
              height: 345,
              child: FutureBuilder<List<UserModel>>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final List<UserModel> _list = snapshot.data ?? [];
                  if (_list.isEmpty) {
                    return Global.emptypic(context, "${AppLocalizations.of(context)!.translate("Players")}");
                  }

                  // Filter and sort the list based on distance
                  final List<MapEntry<UserModel, double>> filteredList = _list
                      .map((user) {
                    final double distance = calculateDistance(
                      _user!.Lat,
                      _user.Lon,
                      user.Lat,
                      user.Lon,
                    );
                    return MapEntry(user, distance);
                  })
                      .where((entry) => entry.value < _user.maxdistance) // Filter by max distance
                      .toList();

                  if (filteredList.isEmpty) {
                    return Center(child: Text("No users within the selected distance"));
                  }

                  // Sort by distance
                  filteredList.sort((a, b) => a.value.compareTo(b.value));

                  return ListView.builder(
                    itemCount: filteredList.length,
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUserr(user: filteredList[index].key);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 8),
              Text("   ${AppLocalizations.of(context)!.translate('NearbyPlaces')}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
              Container(
                width: w,
                height: 365,
                child: FutureBuilder<List<ClubModel>>(
                  future: _clubFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final List<ClubModel> list = snapshot.data ?? [];
                    if (list.isEmpty) {
                      return Global.emptypic(context, "${AppLocalizations.of(context)!.translate("Clubs")}");
                    }

// Filter and sort the list based on distance
                    final List<MapEntry<ClubModel, double>> filteredList = list
                        .map((user) {
                      final double distance = calculateDistance(
                        _user!.Lat,
                        _user.Lon,
                        user.Lat,
                        user.Lon,
                      );
                      return MapEntry(user, distance);
                    })
                        .where((entry) => entry.value < _user.maxdistance) // Filter users within max distance
                        .toList();

                    if (filteredList.isEmpty) {
                      return Center(child: Text("No clubs within the selected distance"));
                    }

// Sort the filtered list by distance
                    filteredList.sort((a, b) => a.value.compareTo(b.value));

                    return ListView.builder(
                      itemCount: filteredList.length,
                      padding: EdgeInsets.only(top: 1),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Hoye(user: filteredList[index].key);
                      },
                    );

                  },
                ),

              ),
              SizedBox(height: 8),

              Text("   ${AppLocalizations.of(context)!.translate('UpcomingMatches')}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
             SizedBox(height: 20,),
              Container(
                width: w,
                height: 250,
                child: FutureBuilder<List<NotificationModel>>(
                  future: _notificationFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Global.emptybox(context, "${AppLocalizations.of(context)!.translate("Confirmed Matches")}");
                    }

                    final notificationList = snapshot.data!;

                    return ListView.builder(
                      itemCount: notificationList.length,
                      padding: EdgeInsets.only(top: 1),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Chatr(user: notificationList[index]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text("   ${AppLocalizations.of(context)!.translate('UpcomingChessTournaments')}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.red,
                            width: 1.5
                        ),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9.0,right: 9,top: 4,bottom: 4),
                      child: Text("BETA",style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w700),),
                    ),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
              Container(
                width: w,
                height: 400,
                child: FutureBuilder<List<TournamentModel>>(
                  future: _tourn,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final list = snapshot.data ?? [];
                    if (list.isEmpty) {
                      return Global.emptypic(context, "${AppLocalizations.of(context)!.translate("Tournaments")}");
                    }
                    return ListView.builder(
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: 1),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Tyu(user: list[index]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}


class ChatUserr extends StatelessWidget {
  ChatUserr({super.key,required this.user});
UserModel user;

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                child: Ucard(
                  user: user,
                ),
                type: PageTransitionType.topToBottom,
                duration: Duration(milliseconds: 80)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 3
                ),
                image: DecorationImage(
                  image: user.assetb?AssetImage(user.assetn):NetworkImage(user.Pic_link),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      c3((user.Won+user.lichesorgran+user.chesscomra),"assets/logoi.png",context),
                      c3(user.chesscomra,"assets/anewchesscom.png",context),
                      c3(user.lichesorgran,"assets/newliches.png",context),
                      c3(user.fidera,"assets/newfide.png",context),
                    ],
                  ),
                  SizedBox(height: 3,)
                ],
              ),
            ),
            Text(user.Name+" ( "+calculateAge(user.bday).toString()+" )",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
            Row(
              children: [
                Icon(CupertinoIcons.location,color: Colors.grey,size: 14,),
                SizedBox(width: 9,),
                Text(calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + AppLocalizations.of(context)!.translate("kmsAway"),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 11),),
              ],
            ),
          ],
        ),
      ),
    );
  }
  int calculateAge(String s) {
    try {
      DateTime birthDate = DateTime.parse(s);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;

      // Adjust if the birthday hasn't occurred this year yet
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    }catch(e){
      return 18;
    }
  }
  Widget c3(int str,String s4,BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width/7-10,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0,right: 4,top: 5,bottom: 5),
        child: Row(
          children: [
            Image.asset(s4,height: 12,width: 12,),
            Text("  "+ format(str).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 8,letterSpacing: 0.4),),
          ],
        ),
      ),
    );
  }
  String format(int number) {
    if (number == 0) {
      // If the number is 0, return "0"
      return "0";
    } else if (number < 1000) {
      // If the number is less than 1000, return it as a three-digit number
      return number.toString().padLeft(3, '0');
    } else if (number < 1000000) {
      // If the number is in the thousands, format with 'K' and no decimal places
      double formatted = number / 1000;
      return '${formatted.toStringAsFixed(0)}K';
    } else if (number < 1000000000) {
      // If the number is in the millions, format with 'M' and no decimal places
      double formatted = number / 1000000;
      return '${formatted.toStringAsFixed(0)}M';
    } else {
      // If the number is in the billions, format with 'B' and no decimal places
      double formatted = number / 1000000000;
      return '${formatted.toStringAsFixed(0)}B';
    }
  }

  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    //calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " km"),


    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    if( distance > 100 ){
      return "100+" ;
    }
    // Format the distance as a string
    return distance.toStringAsFixed(1); // Adjust the precision as needed
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}

class Hoye extends StatefulWidget {
  ClubModel user;

  Hoye({super.key, required this.user});

  @override
  State<Hoye> createState() => _HoyeState();
}

class _HoyeState extends State<Hoye> {
  String s = " ";
  initState(){
    super.initState();
    vq();
  }

  vq() async{
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
    s = FirebaseAuth.instance.currentUser!.uid ?? "h";
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: Club_Full(user: widget.user, names : _user!.Name),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 400)));
        },
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 350,width: MediaQuery.of(context).size.width-70,
            decoration: BoxDecoration(
                color: Global.blac,
                image: DecorationImage(image: NetworkImage(widget.user.Pic_link),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),

                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(widget.user.Name,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 19),),
                    SizedBox(height:2,),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0,right: 4),
                      child: Text(widget.user.Location,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 13),),
                    ),
                    SizedBox(height:4,),
                    widget.user.status=="Active"?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.location_fill,color: Colors.white,size: 20,),
                        SizedBox(width: 4,),
                        Text(calculateDistance(_user!.Lat, _user.Lon, widget.user.Lat, widget.user.Lon)+AppLocalizations.of(context)!.translate("kmsAway"),
                          style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 12),),
                      ],
                    ):Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                          child: Text("${AppLocalizations.of(context)!.translate("Still Waiting for Confirmation")}",style: TextStyle(color: Colors.white),),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.star_fill,color: Colors.yellow,size: 15,),
                        SizedBox(width: 4,),
                        Text(" ${doubl()}",
                          style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 13),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  String doubl() {
    print("Rating people: ${widget.user.ratingpeople}, Ratings number: ${widget.user.ratingsnumber}");
    try {
      if (widget.user.ratingpeople == null || widget.user.ratingpeople == 0) {
        return "0.0";
      }
      double averageRating = widget.user.ratingsnumber / widget.user.ratingpeople;
      return averageRating.toStringAsFixed(1);
    } catch (e) {
      return "0.0";
    }
  }
  String trim(String input) {
    return input.length <= 36 ? input : input.substring(0, 36)+"....";
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    //calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " km"),


    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    if( distance > 100 ){
      return "100+" ;
    }
    // Format the distance as a string
    return distance.toStringAsFixed(1); // Adjust the precision as needed
  }

  Widget r(UserModel _user)=> Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        // specify the radius for the top-left corner
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        // specify the radius for the top-right corner
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // specify the radius for the top-left corner
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    // specify the radius for the top-right corner
                  ),
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.user!.Pic_link,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10),
            child: Text(widget.user.Name,
                style:
                TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded,
                    size: 20, color: Colors.greenAccent),
                Text(
                  "  " + widget.user.Location,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10),
            child: Row(
              children: [
                Icon(Icons.person_pin, size: 20, color: Colors.yellow),
                Text(
                  "  ${AppLocalizations.of(context)!.translate("Organised by")} " + widget.user.HName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10),
            child: Row(
              children: [
                Icon(Icons.person, size: 20, color: Colors.deepOrange),
                Text(
                  " " +
                      widget.user.Clublist.length.toString() +
                      " ${AppLocalizations.of(context)!.translate("Active Members")}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10),
            child: Row(
              children: [
                Icon(Icons.translate, size: 20, color: Colors.blueAccent),
                Text(
                  "  ${AppLocalizations.of(context)!.translate("Language")} " + widget.user.Language,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
              padding:
              const EdgeInsets.only(left: 19.0, top: 10, right: 19),
              child: ReadMoreText(
                widget.user.Bio,
                numLines: 2,
                readMoreText: 'Read more',
                readMoreAlign: AlignmentDirectional.bottomStart,
                readLessText: 'Read less',
              )),
          Padding(
            padding: const EdgeInsets.only(left: 19.0),
            child: Row(children: [
              Text("${AppLocalizations.of(context)!.translate("Social Links")} : ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              SocialMediaButton.whatsapp(
                  onTap: () async {
                    final Uri _url = Uri.parse(widget.user.whatsapp);
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  size: 20,
                  color: Colors.green),
              SocialMediaButton.facebook(
                  onTap: () async {
                    final Uri _url = Uri.parse(widget.user.facebook);
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  size: 20,
                  color: Colors.blue),
              SocialMediaButton.instagram(
                  onTap: () async {
                    final Uri _url = Uri.parse(widget.user.instagram);
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  size: 20,
                  color: Colors.orangeAccent),
              SocialMediaButton.twitter(
                  onTap: () async {
                    final Uri _url = Uri.parse(widget.user.twitter);
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  size: 20,
                  color: Colors.blueAccent),
              SocialMediaButton.dribbble(
                  onTap: () async {
                    final Uri _url = Uri.parse(widget.user.discord);
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  size: 20,
                  color: Colors.black),
            ]),
          ),
          Padding(
              padding: EdgeInsets.only(left: 19, right: 19, top: 2),
              child: Row(children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 2.0, // Border width
                      ),
                      color: Color(0xffff79ac),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        // specify the radius for the top-left corner
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        // specify the radius for the top-right corner
                      ),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width - 132,
                        child: MaterialButton(
                            onPressed: () async {
                              String g = FirebaseAuth
                                  .instance.currentUser!.uid ??
                                  "7";
                              final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                              if (widget.user.Clublist.contains(g)) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: ChatPageClub(user: widget.user, name_person: _user!.Name,),
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 200)));
                              } else {
                                // else we need to add uid to the likes array
                                await _firestore
                                    .collection('clubs')
                                    .doc(widget.user.uid)
                                    .update({
                                  'ClubList': FieldValue.arrayUnion([g])
                                });
                              }
                            },
                            child: Text(
                                widget.user.Clublist.contains(s)
                                    ? "Chat Now"
                                    : " Join Now ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
                SizedBox(
                  width: 10,
                ),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        // specify the radius for the top-left corner
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        // specify the radius for the top-right corner
                      ),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.report, color: Colors.black))),
              ]))
        ],
      ),
    ),
  );

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('clubs').doc(postId).update({
          'ClubList': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        await _firestore.collection('clubs').doc(postId).update({
          'ClubList': FieldValue.arrayUnion([uid])
        });
      }
      print('sucess');
      res = 'success';
    } catch (err) {
      res = err.toString();
      print('lost');
    }
    return res;
  }
}
