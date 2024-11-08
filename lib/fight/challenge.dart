import 'dart:async';
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/fight/mycode.dart';
import 'package:chessby/fight/verify.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

import 'package:page_transition/page_transition.dart';

class Challenge extends StatefulWidget {
  UserModel user;
   Challenge({super.key, required this.user});

  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  String forS(int seconds) {
    int minutes = seconds ~/ 60; // Calculate minutes
    int remainingSeconds = seconds % 60; // Calculate remaining seconds

    // Format as MM:SS
    String formatted = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formatted;
  }
  bool autorotate=false,center=false,sound=true;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        automaticallyImplyLeading: true,
        backgroundColor: !start?Colors.transparent:Colors.black,
        elevation: 0,
        title:start? Text("${AppLocalizations.of(context)!.translate("Start Playing")}",style: TextStyle(color: Colors.white),):SizedBox(),
      ),
      body:start?Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 90,),
            Global.text12("   ${AppLocalizations.of(context)!.translate("Game Time")}", w),
            Global.text2("    ${AppLocalizations.of(context)!.translate("Choose a Time Limit for Each Player")}", w),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  availt(5),availt(10),availt(20),availt(30),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12),
              child: Row(
                children: [
                  availt(45),availt(60),availt(120),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Global.text12("    ${AppLocalizations.of(context)!.translate("Extra")}", w),
            Global.text2("     ${AppLocalizations.of(context)!.translate("Extra Functions for Game Preference")}" ,w),
            Global.text2("    (  ${AppLocalizations.of(context)!.translate("Could be Change Later during Game")} )", w),
            Row(
              children: [
                Container(
                    width: w/2,
                    child: Text("    ${AppLocalizations.of(context)!.translate("AutoRotate Screen")}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),)),
                Switch(value: autorotate, onChanged: (value){
                  setState(() {
                    autorotate=!autorotate;
                  });
                }),
              ],
            ),
            SizedBox(height: 25,),
            InkWell(
                onTap: (){
                  setState(() {
                    start=!start;
                    go=go*60;
                    avail=avail*60;
                  });
                  startt();
                },
                child: Center(child: Global.yellow(w, " ${AppLocalizations.of(context)!.translate("Start Timer for Chess")}"))),
          ],
        ),
      ): Container(
        width: w,height: h,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: (){
                    white=!white;
                  },
                  child: Container(
                    height: h/2,width: w,
                    color: Colors.red,
                    child: Center(
                      child: autorotate? Transform(
                        alignment: FractionalOffset.center,
                        transform: new Matrix4.identity()
                          ..rotateZ(180 * 3.1415927 / 180),
                        child: Text("${forS(avail)}",style: TextStyle(color:Colors.black,fontSize: 42,fontWeight: FontWeight.w800),
                        ),
                      ): Text("${forS(avail)}",style: TextStyle(color:Colors.black,fontSize: 42,fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    white=!white;
                  },
                  child: Container(
                    height: h/2,width: w,
                    color: Colors.blue,
                    child: Center(
                      child:  Text("${forS(go)}",style: TextStyle(color:Colors.black,fontSize: 42,fontWeight: FontWeight.w800),),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context, PageTransition(
                            child: Verify(user :widget.user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                        ));
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                            "assets/svg/chess-svgrepo-com.svg",
                            semanticsLabel: 'Acme Logo'
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          autorotate=!autorotate;
                        });
                      },
                      child: CircleAvatar(
                        radius: 25,backgroundColor: autorotate?Colors.purpleAccent:Colors.grey,
                        child: Icon(Icons.rotate_90_degrees_ccw,color: Colors.white,size: 28,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          white=!white;
                        });
                      },
                      child: CircleAvatar(
                        radius: 35,backgroundColor: white?Colors.black:Colors.white,
                        child: Icon(Icons.accessibility,color:white? Colors.white:Colors.black,size: 39,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        toggleTimer();
                        setState(() {

                        });
                      },
                      child: CircleAvatar(
                        radius: 25,backgroundColor: Colors.white,
                        child:isTimerStarted?Icon(Icons.pause,color: Colors.red,size: 28,): Icon(Icons.play_arrow,color: Colors.green,size: 28,),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context, PageTransition(
                            child: MyCode(user : widget.user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                        ));
                      },
                      child: CircleAvatar(
                        radius: 25, child: SvgPicture.asset(
                          "assets/svg/transaction-password-otp-verification-code-security-svgrepo-com.svg",
                          semanticsLabel: 'Acme Logo'
                      ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Timer? _timer; // Timer instance
  Widget availt(int st){
    return InkWell(
      onTap: (){
        setState(() {
          avail=st;
          go=st;
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
            child: Text(st==0?"No Time":" ${st} min", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }
  bool start=true;

  bool isTimerStarted = false; // Variable to check if the timer is started

  void startt() {
    if (isTimerStarted) return; // Prevent starting the timer if it's already running

    isTimerStarted = true; // Set to true when the timer starts
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (avail == 0 && go == 0) {
          timer.cancel(); // Stop the timer if both reach 0
          isTimerStarted = false; // Update the flag
          print("Both timers have reached 0. Timer stopped.");
          return;
        }

        if (white) {
          if (avail > 0) {
            avail--;
            print('Avail: $avail');
          } else {
            changeti(); // Switch to the other timer
          }
        } else {
          if (go > 0) {
            go--;
            print('Go: $go');
          } else {
            changeti(); // Switch to the other timer
          }
        }
      });
    });
  }

  void changeti() {
    if (avail == 0 && go == 0) {
      _timer?.cancel(); // Ensure timer is stopped if both values are 0
      isTimerStarted = false; // Update the flag
      print("Both timers have reached 0. Timer stopped.");
      return;
    }

    setState(() {
      white = !white; // Toggle the active timer
    });
  }

  void toggleTimer() {
    if (isTimerStarted) {
      // Stop the timer if it's already running
      _timer?.cancel();
      isTimerStarted = false;
      print("Timer stopped manually.");
    } else {
      // Start the timer if it's not running
      startt();
      print("Timer started.");
    }
  }

  bool white=false;
  int avail =5,go=5;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}
