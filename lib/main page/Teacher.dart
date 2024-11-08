import 'dart:math';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/home.dart';
import 'package:chessby/main%20page/shop/navigation.dart';
import 'package:chessby/main%20page/shop/teacher_see.dart' as d;
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clubs extends StatefulWidget {
  int y;
  Clubs({super.key,this.y=0});

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  String h = " ";

  late Future<QuerySnapshot> _userFuture;

  late Future<QuerySnapshot> _userFuture1;
  void initState(){
    v();
    review=widget.y;
    _userFuture = FirebaseFirestore.instance
        .collection('users')
        .where('xx', isEqualTo: true) // Ensures 'Ses' is not null
        .get();
    _userFuture1=FirebaseFirestore.instance.collection('clubs').where('status', isEqualTo : "Active").get();
    setState(() {

    });
  }

  v() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      h  = prefs.getString('State') ?? "Canary Islands";
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text("Teacher's Corner")),backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text("Find Teachers and Book Classes with them. In this Area, you could find Teacher will all their Details")),
          Padding(
            padding: const EdgeInsets.only( top: 8.0),
            child: Center(
                child: Text("Tap on Teacher to View Teacher profile")
            ),
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
                child: Text("I understood",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)))),
      ],
    );
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

  List<ClubModel> _list = [];
  List<UserModel> list=[];
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
                    review==0?"   ${AppLocalizations.of(context)!.translate("NearbyChessPlaces")}":"   ${AppLocalizations.of(context)!.translate("NearbyTeachers")}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    review==0?"     ${AppLocalizations.of(context)!.translate("FindPlayersAroundYourCity")}":"     ${AppLocalizations.of(context)!.translate("LearnChessInYourCity")}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                        fontSize: 11
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
                          child: ShopM(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    },
                    icon: Icon(CupertinoIcons.shopping_cart, color: Colors.white),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: Container(
                  width: w-20,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Global.blac,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      // specify the radius for the top-left corner
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      // specify the radius for the top-right corner
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      f(w, 0),
                      f(w, 1),
                    ],
                  )
              ),
            ),
          ),
          review==0?Container(
            height: MediaQuery.of(context).size.height-230,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.png"),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: FutureBuilder(
              future: _userFuture1,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final List<ClubModel> list = (snapshot.data as QuerySnapshot<Map<String, dynamic>>)
                      .docs
                      .map((doc) => ClubModel.fromJson(doc.data()))
                      .toList();
                  if (list.isEmpty) {
                    return Global.emptypic(context, "${AppLocalizations.of(context)!.translate("Clubs")}");
                  }
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
                      .where((entry) => entry.value < _user!.maxdistance) // Filter users within max distance
                      .toList();

                  if (filteredList.isEmpty) {
                    return Center(child: Text("No clubs within the selected distance"));
                  }

// Sort the filtered list by distance
                  filteredList.sort((a, b) => a.value.compareTo(b.value));

                  return ListView.builder(
                    itemCount: filteredList.length,
                    padding: EdgeInsets.only(top: 1),
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Hoyee(user: filteredList[index].key);
                    },
                  );
                }
              },
            ),
          ):Container(
            height: MediaQuery.of(context).size.height-230,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.png"),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),
            child: FutureBuilder(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final data = snapshot.data?.docs;
                final list = data
                    ?.where((doc) {
                  final docData = doc.data() as Map<String, dynamic>?; // Cast safely to Map<String, dynamic>
                  if (docData == null) {
                    return false; // Return false if docData is null, so this entry is excluded
                  }

                  bool availabilityMatches = (_user?.favailable == "All") || (_user?.favailable == docData['State']);

                  bool languageMatches = (_user?.flanguage == "All") ||
                      (_user?.language?.any((lang) => (docData['language'] as List<dynamic>?)?.contains(lang) ?? false) ?? false);

                  return availabilityMatches && languageMatches;
                })
                    .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)) // Safely cast e.data()
                    .toList() ?? [];

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                            "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png",
                            height: 150),
                        Text("${AppLocalizations.of(context)!.translate("Sorry, No Clubs in Your City")}",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        Text(
                          "${AppLocalizations.of(context)!.translate("Why don't you Share your App to your Friends")}",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("${AppLocalizations.of(context)!.translate("Share App now >>")}"),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: 1),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return d.Hoyee(user: list[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  late int review ;
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  Widget f(double w, int yes)=>InkWell(
    onTap: (){
      setState(() {
        review=yes;
      });
      print(review);
    },
    child: Container(
      width: w/2-14,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: yes==review?Colors.yellowAccent:Global.blac,
      ),
      child: Center(
        child: Text(yiop(yes),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:yes==review? Colors.black:Colors.white)),
      ),
    ),
  );
  String yiop(int y){
    if(y==0){
      return AppLocalizations.of(context)!.translate("Places");
    }else if(y==1){
      return AppLocalizations.of(context)!.translate("Teachers");
    }else {
      return "Invites";
    }
  }
}
