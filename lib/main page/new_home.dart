import 'dart:math';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:chessby/main%20page/Notifications/mynavigation.dart';
import 'package:chessby/main%20page/home.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/noti.dart';
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
      .collection('users')
      .get()
      .then((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  final Future<List<ClubModel>> _clubFuture = FirebaseFirestore.instance
      .collection('clubs')
      .get()
      .then((snapshot) => snapshot.docs.map((doc) => ClubModel.fromJson(doc.data() as Map<String, dynamic>)).toList());

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,
          height: 95,
          width: w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 10),
                child: CircleAvatar(
                  backgroundColor: Global.yell,
                  radius: 25,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(_user!.Pic_link),
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
                    ),
                  ),
                  Text(
                    "  " + _user.Name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 1),
                child: Center(
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
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 1),
                child: CircleAvatar(
                  backgroundColor: Global.blac,
                  radius: 22,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Notifications(),
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 80)));
                    },
                    icon: Icon(Icons.notification_add, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10),
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
            opacity: 0.2,
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
                  Text("   Nearby Players",
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
                    child: Text("   Filter >  ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.yellow, fontSize: 14)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: w,
                height: 265,
                child: FutureBuilder<List<UserModel>>(
                  future: _userFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final _list = snapshot.data ?? [];
                    if (_list.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("No Block / Passed Users",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                            Text(
                              "We will still wait for someone you would block or Pass",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: _list.length,
                      padding: EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserr(user: _list[index]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Text("   Nearby Places",
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
                    final list = snapshot.data ?? [];
                    if (list.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png",
                                height: 150),
                            Text("Sorry, No Clubs in Your City",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                            Text(
                              "Why don't you Share your App to your Friends",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Share App now >>"),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: 1),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Hoye(user: list[index]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Text("   Upcoming Matches",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
             SizedBox(height: 20,),
              Container(
                width: w,
                height: 400,
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Notification for Matches found",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Looks like no one challenged you, nor did you challenge anyone",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    }

                    final notificationList = snapshot.data!;

                    return ListView.builder(
                      itemCount: notificationList.length,
                      padding: EdgeInsets.only(top: 1),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Chatr(user: notificationList[index]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
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
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(user.Pic_link),
                  fit: BoxFit.cover
                )
              ),
            ),
            Text(user.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
            Row(
              children: [
                Icon(CupertinoIcons.location,color: Colors.grey,size: 14,),
                SizedBox(width: 9,),
                Text(calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " km Away",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 11),),
              ],
            ),
          ],
        ),
      ),
    );
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
