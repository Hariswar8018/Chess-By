import 'dart:math';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/club_full_card.dart';
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
                  "  Organised by " + widget.user.HName,
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
                      " Active Members",
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
                  "  Language " + widget.user.Language,
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
              Text("Social Links : ",
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
