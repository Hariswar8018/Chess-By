import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/tournament_all.dart';
import 'package:chessby/cards/tournament_users.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/tournaments.dart';
import 'package:chessby/models/tournament.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_countdown/slide_countdown.dart';
int count=0;
class TournamentCard extends StatefulWidget {

  TournamentModel user;
  TournamentCard({super.key,required this.user});

  @override
  State<TournamentCard> createState() => _TournamentCardState();
}

class _TournamentCardState extends State<TournamentCard> {
  List<UserModel> _list=[];

  @override
  void initState() {
    count=0;
    BannerAd(
      adUnitId:"ca-app-pub-1670674159996846/5167845048",
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  BannerAd? _bannerAd;

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
       backgroundColor: Colors.black,
       iconTheme: IconThemeData(
         color: Colors.white
       ),
       actions: [
         InkWell(
           onTap: (){
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) =>Add_T(user: widget.user, tochange: true,)),
             );
           },
           child: Container(
            decoration: BoxDecoration(
              color:Colors.yellow,
              borderRadius: BorderRadius.circular(5)
            ),
             child:Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 children: [
                   Icon(Icons.edit,color:Colors.black,size: 17,),
                   SizedBox(width: 3,),
                   Text("${AppLocalizations.of(context)!.translate("Tournament Manager")}",style:TextStyle(color:Colors.black)),
                 ],
               ),
             )
           ),
         ),
         SizedBox(width: 13,),
       ],
     ),
     body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 450,width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: widget.user.pic.isEmpty?NetworkImage("https://chessmii.com/uploads/tournaments/brochure/Chessmii-2024_10_11_10_09_07_1z0zFh.jpg"):NetworkImage(widget.user.pic[0]),
                        fit: BoxFit.cover)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/logo (1).png"))
                      ),
                    ),
                    SizedBox(width: 12,),
                    Container(
                        width: w-82,
                        child: Text(widget.user.name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),textAlign: TextAlign.start,)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SlideCountdownSeparated(
                separatorType: SeparatorType.symbol,
                decoration: BoxDecoration(color: Colors.yellowAccent),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                duration: Duration(minutes: minutesLeft(widget.user.dateTime)),
                showZeroValue: true,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: w,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xff082A69),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(height: 60,"assets/transparent-golden-cup-trophy-for-victory-win-at-contest-as-an-award-and-prize-for-achievement-png.webp"),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${AppLocalizations.of(context)!.translate("TOTAL PRIZE FUND")}",style: TextStyle(color: Colors.yellow,fontSize: 19,fontWeight: FontWeight.w600),),
                          Text(widget.user.perCard+" "+widget.user.totalPrize,style: TextStyle(color: Colors.yellowAccent,fontSize: 23,fontWeight: FontWeight.w800),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: w,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xff082A69),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(height: 50,"assets/Trophypng.parspng.com-6.png"),
                          Text(widget.user.perCard+" "+widget.user.first,style: TextStyle(color: Colors.yellowAccent,fontSize: 17,fontWeight: FontWeight.w800),)
                        ],
                      ),
                      Container(height: 60,width: 4,color:Colors.yellowAccent),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(height: 50,"assets/grand-prize-transparent-trophy-free-png.png"),
                          Text(widget.user.perCard+" "+widget.user.second,style: TextStyle(color: Colors.yellowAccent,fontSize: 17,fontWeight: FontWeight.w800),)
                        ],
                      ),
                      Container(height: 60,width: 4,color:Colors.yellowAccent),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(height: 50,"assets/user-pj.png"),
                          Text(widget.user.players.length.toString(),style: TextStyle(color: Colors.yellowAccent,fontSize: 17,fontWeight: FontWeight.w800),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              fg("Organized by",widget.user.organizer),
              fg("Event Starts",formatDateString(widget.user.dateTime)),
              fg("End Date",formatDateString(widget.user.endDateTime)),
              fg("Venue",widget.user.venue),
              fg("Reach before",formatTime(widget.user.dateTime)),
              if (_bannerAd != null)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ),
              SizedBox(height: 15,),
              widget.user.players.contains(FirebaseAuth.instance.currentUser!.uid)?InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Full_P(fid: widget.user.id, name: widget.user.name, user: widget.user,)),
                    );
                  },
                  child: Global.yellowwithout(w, " ${AppLocalizations.of(context)!.translate("See All Players")}")):InkWell(
                  onTap: () async {
                    try {
                      await FirebaseFirestore.instance.collection("Tournaments")
                          .doc(widget.user.id)
                          .update({
                        "${AppLocalizations.of(context)!.translate("players")}": FieldValue.arrayUnion([FirebaseAuth.instance
                            .currentUser!.uid
                        ]),
                      });
                      await FirebaseFirestore.instance.collection("Tournaments")
                          .doc(widget.user.id).collection("Players"
                      )
                          .doc(_user!.uid)
                          .set(_user.toJson());
                      Navigator.pop(context);
                      Send.message(context, "You entered the Contest", true);
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  },
                  child: Global.yellowwithout(w, " ${AppLocalizations.of(context)!.translate("Register Now")}")),
              SizedBox(height: 10,),
              InkWell(
                  onTap: (){
                    Share.share('Join *ChessBy* Today and Enter *${widget.user.name} Tournament* 🏆🏅🥇🎖🏁\nbeing organized on ${formatDateString(widget.user.dateTime)} by ${widget.user.organizer} at ${widget.user.venue} \n \n ♙ ♟ \n *Join Today* and Find unlimited Chess Players around you, challenge with App, and much much more 🤗 \n \n https://play.google.com/store/apps/details?id=com.starwish.chessby');
                  },
                  child: Global.yellowcustom(w,60, Icon(Icons.share_outlined),Colors.white, '${AppLocalizations.of(context)!.translate("Share Invitation")}'),),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                  child: Container(
                      width: w-10,
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
              SizedBox(height: 10,),
              review==0?Container(
                decoration: BoxDecoration(
                    color:Global.blac,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: w-80,
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40,child: Text("${AppLocalizations.of(context)!.translate("No")}",style: TextStyle(color: Colors.white),),
                            ),
                            Container(
                              width: w/2-55,child: Text("${AppLocalizations.of(context)!.translate("Name")}",style: TextStyle(color: Colors.white),),
                            ),
                            Container(
                              width: w/6,child: Text("${AppLocalizations.of(context)!.translate("Won")}",style: TextStyle(color: Colors.white),),
                            ),
                            Container(
                              width: w/6,child: Text("${AppLocalizations.of(context)!.translate("Points")}",style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      width: w,
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Tournaments')
                            .doc(widget.user.id)
                            .collection("Players")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No Users",
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                                  Text(
                                    "We will still wait for someone who Joins",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          }
                          final List<UserModel> userList = snapshot.data!.docs.map((doc) {
                            return UserModel.fromJson(doc.data() as Map<String, dynamic>);
                          }).toList();
                          return ListView.builder(
                            itemCount: userList.length,
                            padding: EdgeInsets.only(left: 10),
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatUserr(user: userList[index],tour:widget.user, y1: userList.first,);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ):
              Container(
                width: w,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0,right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${AppLocalizations.of(context)!.translate("Description")}",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w700)),
                      Text(widget.user.description,style: TextStyle(color: Colors.yellow,fontSize: 15,fontWeight: FontWeight.w700)),
                      SizedBox(height: 10,),
                      Text("${AppLocalizations.of(context)!.translate("Terms & Condition")}",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w700)),
                      Text(widget.user.terms,style: TextStyle(color: Colors.yellow,fontSize: 15,fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }


 int review =0;

  Widget f(double w, int yes)=>InkWell(
    onTap: (){
      setState(() {
        review=yes;
      });
      print(review);
    },
    child: Container(
      width: w/2-20,
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
                color: Colors.black)),
      ),
    ),
  );

  String yiop(int y){
    if(y==0){
      return "Players";
    }else if(y==1){
      return "${AppLocalizations.of(context)!.translate("Info")}";
    }else {
      return "Invites";
    }
  }

  Widget fg(String s1,String s2){
    return Padding(
      padding: const EdgeInsets.only(left:10,top: 11.0),
      child: Row(
        children: [
          Container(width:100,child: Text(s1,style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w700),textAlign: TextAlign.start,)),
          Text(":  ",style: TextStyle(color: Colors.grey),),
          Text(s2,style: TextStyle(color: Colors.yellow,fontSize: 15,fontWeight: FontWeight.w700),textAlign: TextAlign.start,),
        ],
      ),
    );
  }

  int minutesLeft(dynamic dateTime) {
    try {
      // If dateTime is a String, parse it into a DateTime object
      if (dateTime is String) {
        dateTime = DateTime.parse(dateTime);
      }

      final now = DateTime.now();
      return dateTime.difference(now).inMinutes;
    } catch (e) {
      return 9600; // Return a default value in case of error (1 hour)
    }
  }

  /// Returns a formatted time string in HH:MM AM/PM format.
  String formatTime(dynamic dateTime) {
    try {
      // If dateTime is a String, parse it into a DateTime object
      if (dateTime is String) {
        dateTime = DateTime.parse(dateTime);
      }

      final formatter = DateFormat('hh:mm a');
      return formatter.format(dateTime);
    } catch (e) {
      return "10:00 AM"; // Return default time in case of error
    }
  }

  String formatDateString(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      const monthAbbreviations = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];

      // Get the month abbreviation
      String month = monthAbbreviations[parsedDate.month - 1];

      // Format and return the result
      return '$month ${parsedDate.day}, ${parsedDate.year}';
    } catch (e) {
      // Handle invalid input
      return dateString;
    }
  }
}

class ChatUserr extends StatefulWidget {
  final UserModel user;TournamentModel tour;UserModel y1;
  ChatUserr({Key? key, required this.user,required this.tour,required this.y1}) : super(key: key);

  @override
  State<ChatUserr> createState() => _ChatUserrState();
}

class _ChatUserrState extends State<ChatUserr> {
  void initState(){
    if(widget.y1==widget.user){
      count=0;
    }
    count++;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8),
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, PageTransition(
              child:Update(user:widget.user,tour:widget.tour), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 10)
          ));
          if("UjvXgSe6yrY7hIlqcFMlKC91VuE3"==widget.user.uid||widget.user.uid==FirebaseAuth.instance.currentUser!.uid){

          }
        },
        child: Container(
          width: w-80,
          height: 60,
          child: Row(
            children: [
              SizedBox(width: 10,),
              Container(
                width: 40,child: Text(count.toString(),style: TextStyle(color: Colors.white),),
              ),
              Container(
                width: w/2-25,child: Text(widget.user.Name,style: TextStyle(color: Colors.white),),
              ),
              Container(
                width: w/6,child: Text(widget.user.playing_points.toString(),style: TextStyle(color: Colors.white),),
              ),
              Container(
                width: w/6,child: Text(widget.user.second_points.toString(),style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    ); // Replace with your actual widget code
  }
}

class Download extends StatelessWidget {
  const Download({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
