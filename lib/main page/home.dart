import 'dart:math';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:chessby/fight/my_list.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chessby/Google/map_card.dart';
import 'package:chessby/Google/my_location.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/update/user_profile_before_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/message_models.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_tinder_swipe/flutter_tinder_swipe.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text("Market Corner")),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child:
                Center(child: Text("Find Everything in our Market. Top Below to view our Store")),
          )
        ],
      ),
      actions: <Widget>[
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
            width: MediaQuery.of(context).size.width - 132,
            child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("View Store",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)))),
      ],
    );
  }
  int indexx = 0;
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
                    "   Discover",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "     Find Players around your City",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
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
                          child: Country(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                      ));
                    },
                    icon: Icon(CupertinoIcons.location_fill, color: Colors.white),
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
            opacity: 0.2,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-230,
              child: FutureBuilder(
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
                        bool preferenceMatches = (_user?.fpreference == "All") ||
                            (_user?.preference?.any((pref) => (docData['preference'] as List<dynamic>?)?.contains(pref) ?? false) ?? false);

                        bool gameLevelMatches = (_user?.fgamelevel == "All") ||
                            (_user?.fgamelevel == docData['chessby_Level']);

                        bool availabilityMatches = (_user?.favailable == "All") ||
                            (_user?.favailable == docData['State']);

                        bool languageMatches = (_user?.flanguage == "All") ||
                            (_user?.language?.any((lang) => (docData['language'] as List<dynamic>?)?.contains(lang) ?? false) ?? false);
                        return preferenceMatches && gameLevelMatches && availabilityMatches && languageMatches;
                      })
                          .map((e) => UserModel.fromJson(e.data()))
                          .toList() ?? [];

                      if (_list.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png",
                                  height: 150
                              ),
                              Text("Sorry, No one's in Your City", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                              Text("Why don't you Share your App to your Friends", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Share App now >>"),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: Country(justname: true),
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 800),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Text("Use Another City"),
                              ),
                            ],
                          ),
                        );
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
                  backgroundColor: Colors.redAccent,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      if (_list.isNotEmpty) {
                        controller.swipe(CardSwiperDirection.left);
                      }else{
                        Send.message(context, "No User to Perform Action", false);
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
                      Send.message(context, "No User to Perform Action", false);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 25,
                    backgroundImage: AssetImage("assets/fightlogo.jpg"),
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
                        Send.message(context, "No User to Perform Action", false);
                      }

                    },
                    icon: Icon(CupertinoIcons.chat_bubble_2_fill, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
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
    if(widget.user.flanguage=="NA"){
      await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
        "flanguage":"All"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        height: MediaQuery.of(context).size.height - 270,
        color: Colors.black,
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
            height: MediaQuery.of(context).size.height - 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.user.Pic_link),
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
                  Text(widget.user.Name,style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800,color: Colors.white),),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      Icon(CupertinoIcons.location_fill,color: Colors.white,size: 14,),
                      SizedBox(width: 9,),
                      Text(calculateDistance(widget.user.Lat, widget.user.Lon, _user!.Lat, _user.Lon) + " km Away",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 9,),
                  Row(
                    children: [
                     c1(widget.user.Chess_Level),
                      SizedBox(width: 4,),
                      c1("Rapid chessby"),
                    ],
                  ),
                  SizedBox(height: 9,),
                  Row(
                    children: [
                      c3(" "+(widget.user.Won+widget.user.lichesorgran+widget.user.chesscomra).toString(),"https://play-lh.googleusercontent.com/A3MvSm0eEVCkHQP9rUE1Cl3ju90CqCjTxcQqt4tBDzEMT7RWixWBCFgT7mIcN0hk2Q"),
                      SizedBox(width: 4,),
                      c4(" "+widget.user.chesscomra.toString(),"https://play-lh.googleusercontent.com/A3MvSm0eEVCkHQP9rUE1Cl3ju90CqCjTxcQqt4tBDzEMT7RWixWBCFgT7mIcN0hk2Q"),
                      SizedBox(width: 4,),
                      c4(" "+widget.user.lichesorgran.toString(),"https://static-00.iconduck.com/assets.00/lichessby-icon-512x512-q0oh5bwk.png"),
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
  Widget c3(String str,String s4){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
        child: Row(
          children: [
            Image.asset("assets/logo.png",height: 20,width: 20,),
            Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
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

  void main() {
    // Example usage:
    double lat1 = 40.7128; // Latitude of the first position
    double lon1 = -74.0060; // Longitude of the first position

    double lat2 = 34.0522; // Latitude of the second position
    double lon2 = -118.2437; // Longitude of the second position

    String distance = calculateDistance(lat1, lon1, lat2, lon2);

    print('Distance between the two positions: $distance km');
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

  void initState(){
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    preference=_user!.fpreference;
    level=_user.fgamelevel;
    avail=_user.favailable;
    language=_user.flanguage;
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
                "   Update Card Preference",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     Filter the Cards, and update what you See",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12,),
          Text("    Game Preferences",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                se("All"),se("Rapid chessby"),se("Classical chessby")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Row(
              children: [
                se("Bitz chessby"),se("Bullet chessby"),se("chessby 960"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                se("Corresponding chessby"),se("Equal chessby"),
              ],
            ),
          ),
          SizedBox(height: 12,),
          Text("    Game Level",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                levelo("All"),levelo("Begineer"),levelo("Intermediate"),levelo("Advance")
              ],
            ),
          ),
          SizedBox(height: 12,),
          Text("    Availability",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                availt("My City"),availt("All"),
              ],
            ),
          ),
          SizedBox(height: 12,),
          Text("    Language Preference",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
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
      persistentFooterButtons: [
        Center(child: InkWell(
            onTap: () async {
              try{
                await FirebaseFirestore.instance.collection("users").doc(_user!.uid).update({
                  "fpreference":preference,
                  "fgamelevel":level,
                  "favailable":avail,
                  "flanguage":language,
                });
                Navigator.pushReplacement(
                    context, PageTransition(
                    child: Home(), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 80)
                ));
              }catch(e){
                Send.message(context, "$e", false);
              }
            },
            child: Global.yellow(w, "Save Filter"))),
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
