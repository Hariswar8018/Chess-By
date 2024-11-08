import 'dart:math';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:chessby/l10n/app_localization.dart';
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
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
class New_TeacherHome extends StatefulWidget {
  String tofind;
  New_TeacherHome({super.key,required this.tofind});

  @override
  State<New_TeacherHome> createState() => _New_TeacherHomeState();
}

class _New_TeacherHomeState extends State<New_TeacherHome> {
  // Define Futures for the data

  late Future<QuerySnapshot> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = FirebaseFirestore.instance
        .collection('users')
        .where('xx', isEqualTo: true) // Ensures 'Ses' is not null
        .get();
  }
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
  List<UserModel> _list = [],list=[];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.tofind,style: TextStyle(),),
        backgroundColor: Colors.greenAccent,
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
            final _list = data
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

            if (_list.isEmpty) {
              return Global.emptybox(context, "${AppLocalizations.of(context)!.translate("Teacher")}");
;            } else {
              return ListView.builder(
                itemCount: _list.length,
                padding: EdgeInsets.only(top: 1),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Hoyee(user: _list[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
/*Widget cf()=> SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10),
      Text("   Best Teachers",
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
      SizedBox(height: 10),
      Container(
        width: w,
        height: 265,
        child: FutureBuilder(
          future:  FirebaseFirestore.instance
              .collection('users')
              .where('xx', isEqualTo: true) // Ensures 'Ses' is not null
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final data = snapshot.data?.docs ;
            list = data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
            if (list.isEmpty) {
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
              itemCount: list.length,
              padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUserr(user: list[index]);
              },
            );
          },
        ),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Text("   All Teachers in your Area",
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
      Container(
        width: w,
        height: 365,
        child: FutureBuilder(
          future:  FirebaseFirestore.instance
              .collection('users')
              .where('xx', isEqualTo: true) // Ensures 'Ses' is not null
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final data = snapshot.data?.docs;
            _list = data
                ?.where((doc) {
              final docData = doc.data();
              bool availabilityMatches = (_user?.favailable == "All") ||
                  (_user?.favailable == docData['State']);
              bool languageMatches = (_user?.flanguage == "All") ||
                  (_user?.language?.any((lang) => (docData['language'] as List<dynamic>?)?.contains(lang) ?? false) ?? false);
              return  availabilityMatches && languageMatches;
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
              itemCount: _list.length,
              padding: EdgeInsets.only(top: 1),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Hoye(user: _list[index]);
              },
            );
          },
        ),
      ),
      SizedBox(height: 8),
      SizedBox(height: 40,),
    ],
  ),
);*/
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
                  user: user,teacherp: true,
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

class Hoyee extends StatefulWidget {
  UserModel user;

  Hoyee({super.key, required this.user});

  @override
  State<Hoyee> createState() => _HoyeState();
}

class _HoyeState extends State<Hoyee> {
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
                  child: Ucard(
                    user: widget.user,teacherp: true,
                  ),
                  type: PageTransitionType.topToBottom,
                  duration: Duration(milliseconds: 80)));
        },
        child:Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                color: Global.blac,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(widget.user.Pic_link),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:5,),
                      Text(widget.user.Name,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 19),),
                      SizedBox(height:2,),
                      Text(trim(widget.user.Location),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 13),),
                      SizedBox(height:10,),
                      Row(
                        children: [
                          Icon(CupertinoIcons.location_fill,color: Colors.white,size: 20,),
                          SizedBox(width: 4,),
                          Text(calculateDistance(_user!.Lat, _user.Lon, widget.user.Lat, widget.user.Lon)+" kms Away",
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                          SizedBox(width: 15,),
                          Icon(CupertinoIcons.star_fill,color: Colors.yellow,size: 20,),
                          SizedBox(width: 4,),
                          Text(" ${doubl()}",
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String doubl() {
    return "5.6";
  //  print("Rating people: ${widget.user.ratingpeople}, Ratings number: ${widget.user.ratingsnumber}");
  //  try {
   //   if (widget.user.ratingpeople == null || widget.user.ratingpeople == 0) {
        return "0.0";
   //   }
   //   double averageRating = widget.user.ratingsnumber / widget.user.ratingpeople;
     // return averageRating.toStringAsFixed(1);
    //} catch (e) {
     // return "0.0";
    //}
  }

  String trim(String input) {
    return input.length <= 28 ? input : input.substring(0, 28)+"....";
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
