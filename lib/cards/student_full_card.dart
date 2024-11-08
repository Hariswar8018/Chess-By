import 'dart:math';

import 'package:chessby/Google/map_card.dart';
import 'package:chessby/Google/paypal.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/reviews.dart';
import 'package:chessby/fight/my_list.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Ucard extends StatelessWidget {
  UserModel user;

  Ucard({super.key, required this.user});
  Widget c1(String str){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
        child: Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
      ),
    );
  }
  void soop(BuildContext context){
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Global.blac,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(user: user),
                          ),
                        );
                      },
                      child: list(Icon(Icons.chat_outlined,color: Colors.white,), "Chat ")),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: user.Lat ,
                              ulong: user.Lon, uName:user.Name, uPic: user.Pic_link, mPic: _user.Pic_link,
                            ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                        ));
                      },
                      child: list(Icon(Icons.map,color: Colors.white,), "Locate Player")),
                  Divider(color: Colors.grey.shade100.withOpacity(0.2),),
                  InkWell(
                      onTap: () async {
                        try {
                          await FirebaseFirestore.instance.collection("users")
                              .doc(user.uid)
                              .update({
                            "block": FieldValue.arrayUnion([_user!.uid]),
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Send.message(
                              context, "User Blocked Successfully", false);
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(
                              context, "$e", false);
                        }
                      },
                      child: list(Icon(Icons.block_outlined,color: Colors.white), "Block User")),
                  InkWell(
                      onTap: () async {
                        try{
                          await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
                            "block":FieldValue.arrayUnion([_user!.uid]),
                            "Report":FieldValue.arrayUnion([_user!.uid]),
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Send.message(context, "User Blocked & Reported Successfully", false);
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(
                              context, "$e", false);
                        }
                      },
                      child: list(Icon(Icons.report_problem,color: Colors.white), "Report User")),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget list(Widget c,String str)=>ListTile(
    leading: c,
    title: Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
  );
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading:  InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: CircleAvatar(
              backgroundColor: Global.blac,
                child: Icon(Icons.arrow_back_outlined,color: Colors.white,)),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
              soop(context);
            },
            child: CircleAvatar(
              backgroundColor: Global.blac,
              child: Icon(Icons.more_horiz,color: Colors.white,),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 500,
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(user.Pic_link),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ),
            SizedBox(height : 15),
            Container(
              width:  MediaQuery.of(context).size.width ,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("   "+user.Name,style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800,color: Colors.white),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 15,),
                          Icon(CupertinoIcons.location_fill,color: Colors.white,size: 14,),
                          SizedBox(width: 9,),
                          Text(calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " km Away",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(user: user),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: Global.blac,
                      child: Icon(CupertinoIcons.chat_bubble_2_fill,color: Colors.white,size: 28,),
                    ),
                  ),
                  SizedBox(width: 12,)
                ],
              ),
            ),
            SizedBox(height: 9,),
            Row(
              children: [
                SizedBox(width: 15,),
                c1(user.Chess_Level),
                SizedBox(width: 4,),
                c1("Rapid chessby"),
              ],
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                    ),
                    color: Colors.black,
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
                      width: MediaQuery.of(context).size.width - 40,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context, PageTransition(
                                child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: user.Lat ,
                                  ulong: user.Lon, uName: user.Name, uPic: user.Pic_link, mPic: _user.Pic_link,
                                ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                            ));
                          },
                          icon: Icon(CupertinoIcons.location_fill,
                              color: Colors.white),
                          label: Text("Locate Me",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))))),
            ),
            SizedBox(height: 15,),

            ft("About Me"),
            fr(user.Bio,context),
            SizedBox(height: 20,),

            ft("Languages"),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildThreeRowList1(user.language),
            ),
            SizedBox(height: 20,),
            ft("Game Stats"),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                f1("Total Played",(user.Won+user.Draw+user.Lose).toString(),context),
                f1("Wins",user.Won.toString(),context),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                f1("Lose",(user.Lose).toString(),context),
                f1("Draw",user.Draw.toString(),context),
              ],
            ),
            SizedBox(height: 20,),
            ft("Players Stats"),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                fl("chessbyby ",(user.Won+user.chesscomra+user.lichesorgran).toString(),context,"assets/logo.png",true),
                fl("chessby.com",user.chesscomra.toString(),context,"https://play-lh.googleusercontent.com/A3MvSm0eEVCkHQP9rUE1Cl3ju90CqCjTxcQqt4tBDzEMT7RWixWBCFgT7mIcN0hk2Q",false),
                fl("Liches.org",user.lichesorgran.toString(),context,"https://static-00.iconduck.com/assets.00/lichessby-icon-512x512-q0oh5bwk.png",false),
              ],
            ),
            SizedBox(height: 20,),
            ft("Game Preferences"),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildThreeRowList(user.preference),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
              color: Global.yell,
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
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: My_List(
                                user: user, i: 0,
                              ),
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 400)));
                    },
                    child: Text("Challenge Player",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))))),
      ],
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
  Widget buildThreeRowList1(List<dynamic> items) {
    // Cast the dynamic list to List<String> and limit to 9 items
    List<String> limitedItems = items.cast<String>().take(9).toList();

    // Chunk the list into groups of 3 items each
    List<List<String>> rows = [];
    for (int i = 0; i < limitedItems.length; i += 4) {
      rows.add(limitedItems.sublist(i, (i + 4) > limitedItems.length ? limitedItems.length : i + 4));
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
  Widget fl(String s1, String s2,BuildContext context,String sty,bool gh){
    return Container(
        width:  MediaQuery.of(context).size.width/3-20,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Global.blac,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gh?Image.asset(sty,height: 30,width: 30,fit: BoxFit.cover,):Image.network(sty,height: 30,width: 30,fit: BoxFit.cover,),
              Text(s1,style: TextStyle(color: Colors.grey,fontSize: 12),),
              Text(s2,style: TextStyle(color: Colors.white,fontSize: 22),)
            ],
          ),
        )
    );
  }

  Widget f1(String s1, String s2,BuildContext context){
    return Container(
      width:  MediaQuery.of(context).size.width/2-20,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Global.blac,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s1,style: TextStyle(color: Colors.grey,fontSize: 17),),
            Text(s2,style: TextStyle(color: Colors.white,fontSize: 22),)
          ],
        ),
      )
    );
  }

  Widget ft(String str)=>Text("    "+str,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.yellow),);

  Widget fr(String sr,BuildContext context)=>Container(
    width:  MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 15,right: 15),
      child: Text(sr,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),),
    ),
  );


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

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    // Format the distance as a string
    return distance.toStringAsFixed(2); // Adjust the precision as needed
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


