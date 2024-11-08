import 'dart:ffi';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/reviews.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/picture.dart';
import 'package:chessby/models/reviews_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:chessby/subpages_messages_club/club_chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class Club_Full extends StatefulWidget {
  String names ;
  ClubModel user;
  Club_Full({super.key, required this.user, required this.names});

  @override
  State<Club_Full> createState() => _Club_FullState();
}

class _Club_FullState extends State<Club_Full> {
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

  final String s = FirebaseAuth.instance.currentUser!.uid ?? "h";

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 450,
                  width: w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(widget.user.Pic_link),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
              SizedBox(height : 10),
              Container(
                width:  MediaQuery.of(context).size.width ,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("   "+widget.user.Name,style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800,color: Colors.white),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 19,),
                            Icon(CupertinoIcons.location_solid,color: Colors.white,size: 14,),
                            SizedBox(width: 9,),
                            Container(
                                width: w/2+80,
                                child: Text(widget.user.Location,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)),
                          ],
                        ),
                       ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        String g = FirebaseAuth.instance.currentUser!.uid;
                        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                        if (widget.user.Clublist.contains(g)) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ChatPageClub(user: widget.user, name_person: widget.names,),
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
                          Navigator.pop(context);
                          Send.message(context, "Wait , Adding you to Group", false);
                        }
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
              SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 19),
                  Icon(CupertinoIcons.star_fill, color: Colors.yellowAccent, size: 14),
                  SizedBox(width: 9),
                  Text(
                    "${doubl()} (based on ${doub()} Reviews)",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height:15,),
              Center(
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
                        f(w, !review,true),
                        f(w, review,false),
                      ],
                    )
                ),
              ),
              SizedBox(height:8,),
             gt(review, w),
              SizedBox(height:15,),
            ],
          ),
        ),
      ),
    );
  }
  String doub() {
    print("Rating people: ${widget.user.ratingpeople}");
    try {
      return (widget.user.ratingpeople ?? 0).toString();
    } catch (e) {
      return "0";
    }
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

  Widget gt(bool g,double w){
    if(!g){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 10),
            child: Row(
                children:[
                  Text("Social Links : ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  SocialMediaButton.whatsapp(
                      onTap: () async {
                        final Uri _url = Uri.parse(widget.user.whatsapp);
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      size: 20, color: Colors.green
                  ),
                  SocialMediaButton.facebook(
                      onTap: () async {
                        final Uri _url = Uri.parse(widget.user.facebook);
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      size: 20, color: Colors.blue
                  ),
                  SocialMediaButton.instagram(
                      onTap: () async {
                        final Uri _url = Uri.parse(widget.user.instagram);
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      size: 20, color: Colors.orangeAccent
                  ),
                  SocialMediaButton.twitter(
                      onTap: () async {
                        final Uri _url = Uri.parse(widget.user.twitter);
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      size: 20, color: Colors.blueAccent
                  ),
                  SocialMediaButton.dribbble(
                      onTap: () async {
                        final Uri _url = Uri.parse(widget.user.discord);
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      size: 20, color: Colors.black
                  ),
                ]
            ),
          ),
          SizedBox(height: 8,),
          Text("    Overview : ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Padding(
              padding:
              const EdgeInsets.only(left: 19.0, top: 10, right: 19, bottom : 20),
              child: Text(
                widget.user.Bio,
                style: TextStyle(color: Colors.white),
              )),
        ],
      );
    }else{
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0,right: 17,top: 13),
            child: Row(
              children: [
                Text("Reviews",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),),
                Spacer(),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: GiveReview(id: widget.user.uid,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    },
                    child: Text("Write a Review",style: TextStyle(color: Colors.orange),)),
              ],
            ),
          ),
          Container(
            width: w,
            height: 500,
            child: StreamBuilder(
              stream: Fire.collection("clubs").doc(widget.user.uid).collection('Reviews').snapshots(),
              builder: ( context,  snapshot) {
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center( child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs ;
                    _list = data?.map((e) => ReviewModel.fromJson(e.data())).toList() ?? [];
                    return ListView.builder(
                      itemCount: _list.length,
                      padding: EdgeInsets.only(bottom: 10),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                        return ChatUser(user: _list[index],);
                      },
                    );
                }
              },
            ),
          ),
        ],
      );
    }
  }

  List<ReviewModel> _list = [];
  late Map<String, dynamic> userMap;
  TextEditingController ud = TextEditingController() ;
  final Fire = FirebaseFirestore.instance;

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
                      onTap: () async {
                        String g = FirebaseAuth.instance.currentUser!.uid;
                        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                        if (widget.user.Clublist.contains(g)) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ChatPageClub(user: widget.user, name_person: widget.names,),
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
                          Navigator.pop(context);
                          Send.message(context, "Wait , Adding you to Group", false);
                        }
                      },
                      child: list(Icon(Icons.groups_outlined,color: Colors.white,), "Message Group")),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: Picture(collection: 'clubs', doc: widget.user.uid,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                        ));
                      },
                      child: list(Icon(Icons.camera_enhance_sharp,color: Colors.white,), "Pictures")),
                  Divider(color: Colors.grey.shade100.withOpacity(0.2),),
                  InkWell(
                      onTap: () async {
                        try{
                          String uidToSearch = widget.user!.uid; // Replace with the actual uid you want to search
                          UserModel? user2 = await getUserByUid(uidToSearch);
                          if (user2 != null) {
                            print("User found: His Name }");
                            Navigator.push(
                                context, PageTransition(
                                child: ChatPage(user: user2,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                            ));
                          } else {
                            Navigator.pop(context);
                            Send.message(context, "No Host Found with Error", false);
                            print("User not found");
                          }
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(context, "$e", false);
                          print(e);
                        }
                      },
                      child: list(Icon(Icons.message,color: Colors.white), "Message Host")),
                  InkWell(
                      onTap: () async {
                        try{
                          await FirebaseFirestore.instance
                              .collection('clubs')
                              .doc(widget.user.uid)
                              .update({
                            'blocks': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
                          });
                          Navigator.pop(context);
                          Send.message(context, "Reported Successfully", true);
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(context, "$e", true);
                        }
                      },
                      child: list(Icon(Icons.report_problem,color: Colors.white), "Report Group")),
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
  Widget f(double w, bool k,bool yes)=>InkWell(
    onTap: (){
      setState(() {
        review = !review;
      });
      print(review);
    },
    child: Container(
      width: w/2-40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: k?Colors.yellowAccent:Global.blac,
      ),
      child: TextButton.icon(
          onPressed: () {
            setState(() {
              review = !review;
            });
            print(review);
          },
          icon:yes? Icon(CupertinoIcons.location_fill,
              color: Colors.black):Icon(CupertinoIcons.star,
              color: Colors.black),
          label: Text(yes?"Overview":"Reviews",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black))),
    ),
  );

bool review = false;

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query the collection based on uid
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();

      // Check if a document with the given uid exists
      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document snapshot to a UserModel
        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
        return user;
      } else {
        // No document found with the given uid
        return null;
      }
    } catch (e) {
      print("Error fetching user by uid: $e");
      return null;
    }
  }

}
