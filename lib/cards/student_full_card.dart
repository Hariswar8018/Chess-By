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
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localization.dart';

class Ucard extends StatefulWidget {
  UserModel user;
  bool teacherp;
  Ucard({super.key, required this.user,this.teacherp=false});

  @override
  State<Ucard> createState() => _UcardState();
}

class _UcardState extends State<Ucard> {
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
                            builder: (context) => ChatPage(user: widget.user),
                          ),
                        );
                      },
                      child: list(Icon(Icons.chat_outlined,color: Colors.white,), "Chat ")),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: widget.user.Lat ,
                              ulong: widget.user.Lon, uName:widget.user.Name, uPic: widget.user.Pic_link, mPic: _user.Pic_link,
                            ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                        ));
                      },
                      child: list(Icon(Icons.map,color: Colors.white,), "Locate Player")),
                  Divider(color: Colors.grey.shade100.withOpacity(0.2),),
                  InkWell(
                      onTap: () async {
                        try {
                          await FirebaseFirestore.instance.collection("users")
                              .doc(widget.user.uid)
                              .update({
                            "block": FieldValue.arrayUnion([_user!.uid]),
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Send.message(
                              context, "${AppLocalizations.of(context)!.translate("User Blocked Successfully")}", false);
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
                          await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
                            "block":FieldValue.arrayUnion([_user!.uid]),
                            "Report":FieldValue.arrayUnion([_user!.uid]),
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Send.message(context, "${AppLocalizations.of(context)!.translate("User Blocked & Reported Successfully")}", false);
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

  String format(int number) {
    if (number == 0) {
      // If the number is 0, return "0"
      return "0";
    } else if (number < 1000) {
      // If the number is less than 1000, return it as a three-digit number
      return number.toString().padLeft(3, '0');
    } else if (number < 1000000) {
      // If the number is in the thousands, format with 'K' and no decimal places
      double formatted = number / 1000;
      return '${formatted.toStringAsFixed(0)}K';
    } else if (number < 1000000000) {
      // If the number is in the millions, format with 'M' and no decimal places
      double formatted = number / 1000000;
      return '${formatted.toStringAsFixed(0)}M';
    } else {
      // If the number is in the billions, format with 'B' and no decimal places
      double formatted = number / 1000000000;
      return '${formatted.toStringAsFixed(0)}B';
    }
  }

  @override
  void initState() {
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
                      image: widget.user.assetb?AssetImage(widget.user.assetn): NetworkImage(widget.user.Pic_link),
                      fit: BoxFit.cover,
                    )
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          c3((widget.user.Won+widget.user.lichesorgran+widget.user.chesscomra),"assets/logoi.png",context),
                          c3(widget.user.chesscomra,"assets/anewchesscom.png",context),
                          c3(widget.user.lichesorgran,"assets/newliches.png",context),
                          c3(widget.user.fidera,"assets/newfide.png",context),
                        ],
                      ),
                      SizedBox(height: 15,)
                    ],
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
                        Text("   "+widget.user.Name,style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800,color: Colors.white),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 15,),
                            Icon(CupertinoIcons.location_fill,color: Colors.white,size: 14,),
                            SizedBox(width: 9,),
                            Text(calculateDistance(widget.user.Lat, widget.user.Lon, _user!.Lat, _user.Lon) + AppLocalizations.of(context)!.translate("kmsAway"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
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
                            builder: (context) => ChatPage(user: widget.user),
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
              if (_bannerAd != null&&Send.premium==false)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ),
              Row(
                children: [
                  SizedBox(width: 15,),
                  c1(widget.user.Chess_Level),
                  SizedBox(width: 4,),
                  c1("Age : "+calculateAge(widget.user.bday).toString()+"  "),
                ],
              ),
              SizedBox(height: 15,),
              widget.user.public?Center(
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
                                  child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: widget.user.Lat ,
                                    ulong: widget.user.Lon, uName: widget.user.Name, uPic: widget.user.Pic_link, mPic: _user.Pic_link,
                                  ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                              ));
                            },
                            icon: Icon(CupertinoIcons.location_fill,
                                color: Colors.white),
                            label: Text("${AppLocalizations.of(context)!.translate("Locate Me")}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))))),
              ):SizedBox(),
              SizedBox(height: 15,),

              ft(AppLocalizations.of(context)!.translate("AboutMe")),
              fr(widget.user.Bio,context),
              SizedBox(height: 20,),
              ft(AppLocalizations.of(context)!.translate("Language")),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: buildThreeRowList1(widget.user.language),
              ),
              SizedBox(height: 20,),
              ft(AppLocalizations.of(context)!.translate("GameStats")),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  f1(AppLocalizations.of(context)!.translate("Played"),(widget.user.Won+widget.user.Draw+widget.user.Lose).toString(),context),
                  f1(AppLocalizations.of(context)!.translate("Won"),widget.user.Won.toString(),context),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  f1(AppLocalizations.of(context)!.translate("Lose"),(widget.user.Lose).toString(),context),
                  f1(AppLocalizations.of(context)!.translate("Draw"),widget.user.Draw.toString(),context),
                ],
              ),
              SizedBox(height: 20,),
              ft(AppLocalizations.of(context)!.translate("PlayersStats")),
              SizedBox(height: 8,),
              fil(widget.user.chesscomra.toString(), context, "https://images.chesscomfiles.com/uploads/v1/images_widget.users/tiny_mce/PedroPinhata/phpwlfNic.png", false),
              fil(widget.user.lichesorgran.toString(), context, "https://ebastonblanco.com/wp-content/uploads/2023/12/Lichess_logo.png", false),
              fil(widget.user.fidera.toString(), context, "https://www.englishchess.org.uk/wp-content/uploads/2021/02/fidey.jpg", false),
              fil((widget.user.Won+widget.user.chesscomra+widget.user.lichesorgran).toString(), context, "assets/logoi.png", true),
              SizedBox(height: 20,),
              ft(AppLocalizations.of(context)!.translate("GamePreferences")),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: buildThreeRowList(widget.user.preference),
              ),
              SizedBox(height: 20,),
            ],
          ),
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
                      if(widget.teacherp){
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ConfirmPassword1(),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 400)));
                        Send.sendNotificationsToTokens("${AppLocalizations.of(context)!.translate("New Student Contact for Requirment")}","${_user.Name} just contacted you for Classes of Chess By",widget.user.token);
                      }else{
                        Navigator.push(
                            context,
                            PageTransition(
                                child: My_List(
                                  user: widget.user, i: 0,
                                ),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 400)));
                      }
                    },
                    child: Text(widget.teacherp?"Ask for Requirment":AppLocalizations.of(context)!.translate("ChallengePlayer"),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))))),
      ],
    );
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
  Widget c3(int str,String s4,BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width/4-15,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
        child: Row(
          children: [
            Image.asset(s4,height: 30,width: 30,),
            Text(" "+ format(str).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14),),
          ],
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

  Widget fil(String s2,BuildContext context,String sty,bool gh){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
            width:  MediaQuery.of(context).size.width-20,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade50,
                width: 0.1
              ),
              borderRadius: BorderRadius.circular(15),
              color:Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gh?Image.asset(sty,height: 90,width: MediaQuery.of(context).size.width/2,fit: BoxFit.contain,):
                  Image.network(sty,height: 50,width: MediaQuery.of(context).size.width/2,fit: BoxFit.contain,),
                  SizedBox(width: 18,),
                  Text(s2,style: TextStyle(color: Colors.white,fontSize: 22),),
                  Spacer(),
                ],
              ),
            )
        ),
      ),
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



class ConfirmPassword1 extends StatefulWidget {
  ConfirmPassword1({super.key,});


  @override
  State<ConfirmPassword1> createState() => _ConfirmPasswordState1();
}

class _ConfirmPasswordState1 extends State<ConfirmPassword1> {
  TextEditingController pass1=TextEditingController();

  TextEditingController pass2=TextEditingController();

  bool done=false;

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),  SizedBox(height: 50,),
            Global.text1(" ${AppLocalizations.of(context)!.translate("Thanks for Contact")}", w),
            Global.text2(" ${AppLocalizations.of(context)!.translate("He will soon Contact you for")} ", w),
            Global.text2("${AppLocalizations.of(context)!.translate("Chess Classes")}", w),
            Global.height(25),
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Global.yellowwithout(w, "${AppLocalizations.of(context)!.translate("Back to Finder")}"),),
            Global.height(18),
            Spacer(),
            Global.text11(" ${AppLocalizations.of(context)!.translate("Advice")}", w),
            Global.text2(" ${AppLocalizations.of(context)!.translate("ChessBy don't Interfere between")} ", w),
            Global.text2(" ${AppLocalizations.of(context)!.translate("Teacher's Payment")}", w),
            Global.height(30),
          ],
        ),
      ),
    );
  }
}
