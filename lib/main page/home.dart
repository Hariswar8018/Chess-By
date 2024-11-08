import 'dart:math';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:chessby/fight/my_list.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chessby/Google/map_card.dart';
import 'package:chessby/Google/my_location.dart';
import 'package:chessby/providers/declare.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/message_models.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'new_home.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  List<UserModel> _list = [];
  final CardSwiperController controller = CardSwiperController();
  int indexx = 0;


  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

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

  String calculateW(double lat1, double lon1, double lat2, double lon2) {
    const walkingSpeed = 5.0; // Average walking speed in km/h

    double distance = calculateDistance1(lat1, lon1, lat2, lon2);
    // Calculate time in hours
    double time = distance * walkingSpeed;
    if( time  > 100 ){
      return "100+" ;
    }
    return time.toStringAsFixed(1);
  }

  String calculateC( double lat1, double lon1, double lat2, double lon2 , bool isHighway ) {
    // Set average car speeds based on the type of road
    double carSpeed = isHighway ? 100.0 : 40.0; // Adjust speeds as needed
    double distance = calculateDistance1(lat1, lon1, lat2, lon2);
    // Calculate time in hours
    double time = distance * carSpeed;

    return time.toStringAsFixed(1);
  }

  double calculateDistance1(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    // Format the distance as a string
    return distance ; // Adjust the precision as needed
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "   ${AppLocalizations.of(context)!.translate("Discover")}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "      ${AppLocalizations.of(context)!.translate("FindPlayersAroundYourCity")}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,fontSize: 10
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: CircleAvatar(
                  backgroundColor: Global.blac,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, PageTransition(
                          child: Preference(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    },
                    icon: Icon(Icons.filter_list_outlined, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: CircleAvatar(
                  backgroundColor: Global.blac,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, PageTransition(
                          child: Countryy(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                      ));
                    },
                    icon: Icon(FontAwesomeIcons.mapLocation, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10,),
            ],
          ),
        ),
        toolbarHeight:65,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,  // Keep the background transparent
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
        child:Container(
          width: w,
          height: 365,
           child: FutureBuilder(
             future: FirebaseFirestore.instance
                 .collection('users')
                 .where("chessplace", isEqualTo: false)
                 .get(),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return Center(child: CircularProgressIndicator());
               }
               if (snapshot.hasError) {
                 return Center(child: Text('Error: ${snapshot.error}'));
               }
               final List<UserModel> _list = (snapshot.data as QuerySnapshot<Map<String, dynamic>>)
                   .docs
                   .map((doc) => UserModel.fromJson(doc.data()))
                   .toList();
               if (_list.isEmpty) {
                 return Global.emptypic(context, "${AppLocalizations.of(context)!.translate("Players")}");
               }
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
                   .where((entry) => entry.value < _user!.maxdistance) // Filter by max distance
                   .toList();

               if (filteredList.isEmpty) {
                 return Global.emptypic(context, "${AppLocalizations.of(context)!.translate("Players")}");
               }
               filteredList.sort((a, b) => a.value.compareTo(b.value));
               return ListView.builder(
                 itemCount: filteredList.length,
                 padding: EdgeInsets.only(left: 10),
                 scrollDirection: Axis.horizontal,
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) {
                   return ChatUser(user: filteredList[index].key);
                 },
               );
             },
           )



        ),
      /*  child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-230,
              child:  FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            final data = snapshot.data?.docs;

            _list = data
                ?.where((doc) {
              final docData = doc.data();

              // Filter conditions
              bool preferenceMatches = (_user?.fpreference == "All") ||
                  (_user?.preference?.any((pref) => (docData['preference'] as List<dynamic>?)?.contains(pref) ?? false) ?? false);

              bool gameLevelMatches = (_user?.fgamelevel == "All") ||
                  (_user?.fgamelevel == docData['chessby_Level']);

              bool availabilityMatches = (_user?.favailable == "All") ||
                  (_user?.favailable == docData['State']);

              bool isChessPlaceValid = !(docData['chessplace'] ?? false); // Defaults to false if null
              bool isTournamentManagerValid = !(docData['tournamentmanager'] ?? false); // Defaults to false if null

              bool languageMatches = (_user?.flanguage == "All") ||
                  (_user?.language?.any((lang) => (docData['language'] as List<dynamic>?)?.contains(lang) ?? false) ?? false);

              return preferenceMatches &&
                  gameLevelMatches &&
                  availabilityMatches &&
                  languageMatches &&
                  isChessPlaceValid &&
                  isTournamentManagerValid;
            })
                .map((doc) {
              final docData = doc.data();

              // Calculate distance (returning double)
              final lat = (docData['Lat'] as num?)?.toDouble() ?? 0.0;
              final lon = (docData['Lon'] as num?)?.toDouble() ?? 0.0;

              // Get the distance as double (calculateDistance already returns double)
              final distance = calculateDistance(
                _user!.Lat,
                _user.Lon,
                lat,
                lon,
              );

              // Add distance to UserModel (you can modify the UserModel to include a distance field)
              return UserModel.fromJson(docData)..distance = distance;
            })
                .toList() ?? [];

// Sort the list by distance (ascending order)
            _list.sort((a, b) => a.distance.compareTo(b.distance));

            if (_list.isEmpty) {
              return Global.emptybox(context, "${AppLocalizations.of(context)!.translate("User")}");
            } else {

              return CardSwiper(
                cardsCount: _list.length,
                numberOfCardsDisplayed: _list.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                controller: controller,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  return Container(
                    child: ChatUser(user: _list[index]),
                  );
                },
              );
            }
        }
      },
    ),

    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      controller.undo();
                    },
                    icon: Icon(CupertinoIcons.restart, color: Colors.black),
                  ),
                ),
                SizedBox(width: 8,),
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      if (_list.isNotEmpty) {
                        controller.swipe(CardSwiperDirection.left);
                      }else{
                        Send.message(context, "${AppLocalizations.of(context)!.translate("No User to Perform Action")}", false);
                      }
                    },
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ),
                SizedBox(width: 8,),
                InkWell(
                  onTap:(){
                    if (_list.isNotEmpty) {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: My_List(
                                user: _list.elementAt(indexx), i: 0,
                              ),
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 400)));
                    }else{
                      Send.message(context, "${AppLocalizations.of(context)!.translate("No User to Perform Action")}", false);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 25,
                    backgroundImage: AssetImage("assets/icon/L i c h e s s (1)/578566a8-867a-4f01-80b0-8812429913de.jpeg"),
                  ),
                ),
                SizedBox(width: 8,),
                CircleAvatar(
                  backgroundColor: Global.blac,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      if (_list.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(user: _list.elementAt(indexx)),
                          ),
                        );
                      }else{
                        Send.message(context, "${AppLocalizations.of(context)!.translate("No User to Perform Action")}", false);
                      }

                    },
                    icon: Icon(CupertinoIcons.chat_bubble_2_fill, color: Colors.white),
                  ),
                ),
                SizedBox(width: 8,),
                CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      controller.moveTo(indexx-1);
                      indexx=indexx-1;
                    },
                    icon: Icon(CupertinoIcons.return_icon, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),*/
      ),
    );
  }
  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (indexx >= _list.length - 1) {
      indexx = 0;
    } else {
      indexx += 1;
    }
    return true;
  }

  bool _onUndo(int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    indexx = 0;
    setState(() {});
    return true;
  }
}

class ChatUser extends StatefulWidget {
  UserModel user;

  ChatUser({required this.user});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  InterstitialAd? _interstitialAd;
  void initState(){
    gh();
  }
  Future<void> gh() async {

    if(widget.user.Chess_Level.isEmpty||widget.user.Chess_Level=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "chessby_Level":"Begineer"
      });
    }
    if(widget.user.State=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "State":"Canary Islands"
      });
    }
    if(widget.user.language.isEmpty){
      List ft=["English","Spanish"];
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "language":ft,
      });
    }
    if(widget.user.preference.isEmpty){
      List ft=["Rapid chessby","chessby 960","Bitz chessby"];
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "preference":ft,
      });
    }

    if(widget.user.favailable=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "favailable":"All"
      });
    }
    if(widget.user.fgamelevel=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "fgamelevel":"All"
      });
    }
    if(widget.user.fpreference=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "fpreference":"All"
      });
    }
    print(widget.user.Pic_link);

    if(widget.user.flanguage=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "flanguage":"All"
      });
    }
    if(widget.user.Name=="No Name"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "chessplace":true
      });
    }else{
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "chessplace":false,
        "tournamentmanager":false,
      });
    }
  }
  String getFirstElementOrNone(List list) {
    if (list != null && list.isNotEmpty) {
      return list[0];
    } else {
      return "Rapid Chess";
    }
  }
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        height: MediaQuery.of(context).size.height ,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
            color: Colors.lightBlueAccent,
            width: 3
        ),
        borderRadius: BorderRadius.circular(23),
      ),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    child: Ucard(
                      user: widget.user,
                    ),
                    type: PageTransitionType.topToBottom,
                    duration: Duration(milliseconds: 80)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 80,
            height: MediaQuery.of(context).size.height ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image:  widget.user.assetb?AssetImage(widget.user.assetn):NetworkImage(widget.user.Pic_link),
                fit: BoxFit.cover,
                opacity: 0.8
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(widget.user.Name+" ( "+calculateAge(widget.user.bday).toString()+" )",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800,color: Colors.white),),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      Icon(CupertinoIcons.location_fill,color: Colors.white,size: 14,),
                      SizedBox(width: 9,),
                      Text(calculateDistance(widget.user.Lat, widget.user.Lon, _user!.Lat, _user.Lon) + AppLocalizations.of(context)!.translate("kmsAway"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 9,),
                  Row(
                    children: [
                     c1(widget.user.Chess_Level),
                      SizedBox(width: 4,),
                      c1(getFirstElementOrNone(widget.user.preference)),
                    ],
                  ),
                  SizedBox(height: 9,),
                  Row(
                    children: [
                      c3(widget.user.Won+widget.user.lichesorgran+widget.user.chesscomra,"assets/logoi.png"),
                      SizedBox(width: 4,),
                      c3(widget.user.chesscomra,"assets/anewchesscom.png"),
                      SizedBox(width: 4,),
                      c3(widget.user.lichesorgran,"assets/newliches.png"),
                      SizedBox(width: 4,),
                      c3(widget.user.fidera,"assets/newfide.png"),
                    ],
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
          ),
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
      // If the number is in the thousands, format with 'K' and one decimal place
      double formatted = number / 1000;
      return '${formatted.toStringAsFixed(1)}K';
    } else if (number < 1000000000) {
      // If the number is in the millions, format with 'M' and one decimal place
      double formatted = number / 1000000;
      return '${formatted.toStringAsFixed(1)}M';
    } else {
      // If the number is in the billions, format with 'B' and one decimal place
      double formatted = number / 1000000000;
      return '${formatted.toStringAsFixed(1)}B';
    }
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

  Widget c3(int str,String s4){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
        child: Row(
          children: [
            Image.asset(s4,height: 20,width: 20,),
            Text(" "+format(str).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }
  Widget c4(String str,String s4){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
        child: Row(
          children: [
            Image.network(s4,height: 20,width: 20,),
            Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }

  Widget c1(String str){
    return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(4)
    ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
        child: Text(str.isEmpty?"Rapid chessby":str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
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


  String calculateW(double lat1, double lon1, double lat2, double lon2) {
    const walkingSpeed = 5.0; // Average walking speed in km/h

    double distance = calculateDistance1(lat1, lon1, lat2, lon2);
    // Calculate time in hours
    double time = distance * walkingSpeed;
    if( time  > 100 ){
      return "100+" ;
    }
    return time.toStringAsFixed(1);
  }

  String calculateC( double lat1, double lon1, double lat2, double lon2 , bool isHighway ) {
    // Set average car speeds based on the type of road
    double carSpeed = isHighway ? 100.0 : 40.0; // Adjust speeds as needed
    double distance = calculateDistance1(lat1, lon1, lat2, lon2);
    // Calculate time in hours
    double time = distance * carSpeed;

    return time.toStringAsFixed(1);
  }

  double calculateDistance1(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    // Format the distance as a string
    return distance ; // Adjust the precision as needed
  }
}


class Preference extends StatefulWidget {
  Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  String preference='',level="",avail="",language="";
  late double i,j ;
  void initState(){
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    preference=_user!.fpreference;
    level=_user.fgamelevel;
    avail=_user.favailable;
    language=_user.flanguage;
    i=_user.maxdistance;
    j=10000.0;
  }
  String t5(double j){
    int h = j.toInt();
    return h.toString();
  }
  Widget t(String ti){
    return Text(ti, style : TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color: Colors.white));
  }
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,  // Set the background color here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "   ${AppLocalizations.of(context)!.translate("Update Card Preference")}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     ${AppLocalizations.of(context)!.translate("Filter the Cards, and update what you See")}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 80,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7,),
            Text("    ${AppLocalizations.of(context)!.translate("Maximum Distance")}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
            SizedBox(height: 4,),
            Row(
              children: [
                SizedBox(width : 10),
                t(" "+AppLocalizations.of(context)!.translate("Radius of Discovery")),
                Spacer(),
                t(t5(i) + " ${AppLocalizations.of(context)!.translate("km")}  "),
                SizedBox(width : 10),
              ],
            ),
            Container(
              width:w,
              child: FlutterSlider(
                values: [i, j],
                max: 10000,
                min: 100,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  i = lowerValue;
                  j = upperValue;
                  setState(() {
        
                  });
                },
              ),
            ),
            SizedBox(height: 7,),
            Text("    ${AppLocalizations.of(context)!.translate("Game Preferences")}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  se("All"),se("Rapid Chess"),se("Classical Chess")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: Row(
                children: [
                  se("Bitz Chess"),se("Bullet Chess"),se("Chess 960"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  se("Corresponding Chess"),se("Equal Chess"),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Text("    ${AppLocalizations.of(context)!.translate("Game Level")}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  levelo("All"),levelo("Begineer"),levelo("Intermediate"),levelo("Advance")
                ],
              ),
            ),
            SizedBox(height: 12,),
            Text("    ${AppLocalizations.of(context)!.translate("Availability")}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  availt("My City"),availt("All"),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Text("    ${AppLocalizations.of(context)!.translate("Language Preference")}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  languag("All"),languag("English"),languag("Hindi"),languag("Russian")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: Row(
                children: [
                  languag("Spanish"),languag("Portugese"),languag("Chinese"),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(child: InkWell(
            onTap: () async {
              try{
                await FirebaseFirestore.instance.collection("users").doc(_user!.uid).update({
                  "fpreference":preference,
                  "fgamelevel":level,
                  "favailable":avail,
                  "flanguage":language,
                  "maxdistance":i,
                });
                Navigator.pushReplacement(
                    context, PageTransition(
                    child: Home(), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 80)
                ));
              }catch(e){
                Send.message(context, "$e", false);
              }
            },
            child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("Save Filter")}"))),
      ],
    );
  }
  Widget levelo(String st){
    return InkWell(
      onTap: (){
        setState(() {
          level=st;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color:st==level?Colors.yellowAccent.withOpacity(0.3): Global.blac,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(st, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget availt(String st){
    return InkWell(
      onTap: (){
        setState(() {
         avail=st;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color:st==avail?Colors.yellowAccent.withOpacity(0.3): Global.blac,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(st, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }
  Widget languag(String st){
    return InkWell(
      onTap: (){
        setState(() {
          language=st;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color:st==language?Colors.yellowAccent.withOpacity(0.3): Global.blac,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(st, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }
  Widget se(String st){
    return InkWell(
      onTap: (){
        setState(() {
          preference=st;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color:st==preference?Colors.yellowAccent.withOpacity(0.3): Global.blac,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(st, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget buildThreeRowList(List<dynamic> items) {
    // Cast the dynamic list to List<String> and limit to 9 items
    List<String> limitedItems = items.cast<String>().take(9).toList();

    // Chunk the list into groups of 3 items each
    List<List<String>> rows = [];
    for (int i = 0; i < limitedItems.length; i += 3) {
      rows.add(limitedItems.sublist(i, (i + 3) > limitedItems.length ? limitedItems.length : i + 3));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: row.map((item) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Global.blac,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item, style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
