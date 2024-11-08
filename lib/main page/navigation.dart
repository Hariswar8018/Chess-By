
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/main%20page/Teacher.dart';
import 'package:chessby/main%20page/chat.dart';
import 'package:chessby/main%20page/home.dart';
import 'package:chessby/main%20page/learn.dart';
import 'package:chessby/main%20page/new_home.dart';
import 'package:chessby/main%20page/profile.dart';
import 'package:chessby/teacher_club/teacher_incoming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  
  String s = FirebaseAuth.instance.currentUser!.uid;
  void v() async{
    int millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String formattedDate = DateFormat('MMM d, HH:mm').format(dateTime);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(s)
        .update({
      "lastlogin": formattedDate,
    });
    print(formattedDate);
  }


  final user = FirebaseAuth.instance.currentUser;

  int currentTab=0;
  final Set screens ={
    HomePage(),
    Chat(),
    Clubs(),
    Profile(),
  };
  final PageStorageBucket bucket = PageStorageBucket();

  dynamic selected ;
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    Chat(),
    Learn(),
    Clubs(), Profile()
  ];
  var heart = false;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    _motionTabBarController!.dispose();
    super.dispose();
  }



  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    v();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 5,vsync: this,
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController, // Add this controller if you need to change your tab programmatically
        initialSelectedTab: "Find",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Profile", "Find","Home", "Chats", "Places"],
        icons: const [Icons.person, Icons.dashboard,Icons.view_carousel, CupertinoIcons.chat_bubble_2_fill, CupertinoIcons.location_fill],
        tabSize: 45,
        tabBarHeight: 50,
        textStyle: const TextStyle(
          fontSize: 2,
          color: Color(0xff202020),
        ),
        tabIconColor: Colors.white54,
        tabIconSize: 28.0,
        tabIconSelectedSize: 28.0,
        tabSelectedColor: Global.blac,
        tabIconSelectedColor: Colors.yellow,
        tabBarColor: Global.blac,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _motionTabBarController,
        children: <Widget>[
          Profile(),
          New_Home(),
          HomePage(),
          Chat(),
          Clubs(),
        ],
      ),
    );
  }
}

class MainPageContentComponent extends StatelessWidget {
  const MainPageContentComponent({
    required this.title,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const Text('Go to "X" page programmatically'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.index = 0,
            child: const Text(''),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 1,
            child: const Text(''),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 2,
            child: const Text('Profile Page'),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 3,
            child: const Text('Settings Page'),
          ),
        ],
      ),
    );
  }
}
