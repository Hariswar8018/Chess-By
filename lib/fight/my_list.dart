import 'dart:async';
import 'dart:math';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/chess_game_download.dart';
import 'package:chessby/fight/add_calender.dart';
import 'package:chessby/fight/mycode.dart';
import 'package:chessby/fight/challenge.dart';
import 'package:chessby/fight/verify.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
class My_List extends StatelessWidget {
  UserModel user;int i;
   My_List({super.key, required this.user,required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(i==0?AppLocalizations.of(context)!.translate("ChallengePlayer"):AppLocalizations.of(context)!.translate("FightWithPlayer"),style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
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
          child: Column(
              children : [
                i==0?ListTile(
                  leading:CircleAvatar(
                    child: SvgPicture.asset(
                        "assets/svg/chess-svgrepo-com.svg",
                        semanticsLabel: 'Acme Logo'
                    ),
                  ),
                  title: Text(AppLocalizations.of(context)!.translate("ScheduleFight"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () {
                    Navigator.push(
                    context, PageTransition(
                    child: Add_Calender(user : user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                ));
                  },
                  subtitle: Text("${AppLocalizations.of(context)!.translate("ScheduleFightWith")} ${user.Name}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                ):SizedBox(),
                ListTile(
                  leading:CircleAvatar(
                    child: SvgPicture.asset(
                        "assets/svg/chess-svgrepo-com (1).svg",
                        semanticsLabel: 'Acme Logo'
                    ),
                  ),
                  title: Text(AppLocalizations.of(context)!.translate("FightNowWithChessboard"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () {
                    Navigator.push(
                        context, PageTransition(
                        child: ChessBoar(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  },
                  subtitle: Text(AppLocalizations.of(context)!.translate("AlreadyInSpotFight"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                ),
                ListTile(
                  leading:CircleAvatar(
                    child: SvgPicture.asset(
                        "assets/svg/chess-stopwatch-svgrepo-com.svg",
                        semanticsLabel: 'Acme Logo'
                    ),
                  ),
                  title: Text(AppLocalizations.of(context)!.translate("FightNowWithTimer"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () {
                    Navigator.push(
                        context, PageTransition(
                        child: Challenge(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  },
                  subtitle: Text(AppLocalizations.of(context)!.translate("AlreadyInSpotFight"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                ),
                ListTile(
                  leading:CircleAvatar(
                    child: SvgPicture.asset(
                        "assets/svg/trophy-svgrepo-com.svg",
                        semanticsLabel: 'Acme Logo'
                    ),
                  ),
                  title: Text(AppLocalizations.of(context)!.translate("VerifyWin"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () async {
                    Navigator.push(
                        context, PageTransition(
                        child: Verify(user :user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  },
                  subtitle: Text(AppLocalizations.of(context)!.translate("YouOrWin"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                ),
                ListTile(
                  leading:CircleAvatar(
                    child: SvgPicture.asset(
                        "assets/svg/transaction-password-otp-verification-code-security-svgrepo-com.svg",
                        semanticsLabel: 'Acme Logo'
                    ),
                  ),
                  title: Text(AppLocalizations.of(context)!.translate("MyCodeForVerification"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () async {
                    Navigator.push(
                        context, PageTransition(
                        child: MyCode(user : user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  },
                  subtitle: Text(AppLocalizations.of(context)!.translate("CheckCodeForVerification"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                ),
              ]
          ),
        )
    );
  }
}

class ChessBoar extends StatefulWidget {
  UserModel user;
  ChessBoar({super.key,required this.user});

  @override
  State<ChessBoar> createState() => _ChessBoarState();
}

class _ChessBoarState extends State<ChessBoar> {
  ChessBoardController controller = ChessBoardController();

  bool start=false;

  bool boardwhite=true,sound=true;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return WillPopScope(
      onWillPop: () async {
        if(start){
          bool shouldClose = await _showExitConfirmationDialog(context);
          return shouldClose;
        }else{
          return true;
        }
      },
      child: Scaffold(
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
                      "   ${AppLocalizations.of(context)!.translate("Chess Game")}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.translate("Cheesboard for Offline InPerson")}",
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
                        setState(() {
                          hide=!hide;
                        });
                      },
                      icon:hide? Icon(Icons.close, color: Colors.red): Icon(Icons.blur_linear, color: Colors.white),
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
        body: !hide?(
            start?Container(
          width: w,height: h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back.png"),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Center(
                child: ChessBoard(
                  controller: controller,
                  boardColor: BoardColor.orange,
                  boardOrientation:boardwhite? PlayerColor.white:PlayerColor.black,
                  onMove: (){
                    gh1();
                    if(controller.isCheckMate()){
                      visible=true;
                      visibl="Checkmate ! Well Played";
                      _timer!.cancel();
                      yesdone=true;
                    }else if(controller.isInCheck()){
                      visible=true;
                      visibl="King is in Check";
                    }else if(controller.isGameOver()){
                      visible=true;
                      yesdone=true;
                      visibl="Game Over";
                      _timer!.cancel();
                    }else if(controller.isDraw()){
                      visible=true;
                      yesdone=true;
                      visibl="Game is Draw";
                      _timer!.cancel();
                    }else if(controller.isThreefoldRepetition()){
                      visible=true;
                      visibl="3 Fold Repetition ! Watch Out !";
                    }else{
                      visible=false;
                    }
                    setState(() {
                      white=!white;
                    });
                    if(autorotate){
                      if(white){
                        setState(() {
                          boardwhite=true;
                        });
                      }else{
                        setState(() {
                          boardwhite=false;
                        });
                      }
                    }else{
                      setState(() {
                        boardwhite=true;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                child:chessby_level?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    yesch(_user!, true),
                    yesch(widget.user, false),
                  ],
                ): Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    yesch(widget.user, true),
                    yesch(_user!, false),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 149,height: 5,color: white?Colors.yellow:Colors.transparent,),
                    Container(width: 149,height: 5,color: !white?Colors.yellow:Colors.transparent,),
                  ],
                ),
              ),
             Visibility(
               visible: visible,
               child: Center(
                 child: Padding(
                   padding: const EdgeInsets.only(top: 8.0),
                   child: Container(
                     width: w-20,
                     height: 40,
                     decoration: BoxDecoration(
                       color: Colors.red
                     ),
                     child: Center(child: Text(visibl,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)),
                   ),
                 ),
               ),
             ),
             Spacer(),
              Row(
                children: [
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){

                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 25,
                      child: Icon(Icons.pause,color: Colors.white,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        autorotate=!autorotate;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: autorotate?Colors.blue:Colors.grey,
                      radius: 25,
                      child: Icon(Icons.auto_mode_rounded,color: autorotate?Colors.white:Colors.black),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      hide=!hide;
                      setState(() {

                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: hide?Colors.green:Colors.grey,
                      radius: 25,
                      child: Icon(Icons.blur_linear,color: hide?Colors.white:Colors.black),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      toggleTimer();
                      if(!isTimerStarted){
                        visible=true;
                        visibl="Timer is Stop";
                      }
                      setState(() {

                      });
                    },
                    child: CircleAvatar(
                      radius: 25,backgroundColor: Colors.white,
                      child:isTimerStarted?Icon(Icons.pause,color: Colors.red,size: 28,): Icon(Icons.play_arrow,color: Colors.green,size: 28,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      sound=!sound;
                      setState(() {

                      });
                    },
                    child: CircleAvatar(
                      radius: 25,backgroundColor: sound?Colors.white:Colors.grey,
                      child:sound?Icon(Icons.volume_up,color: Colors.blue,size: 28,): Icon(Icons.volume_off_rounded,color: Colors.black,size: 28,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      try{
                        controller.undoMove();
                        setState(() {
                          visible=true;
                          visibl="Last Move is Undo";
                        });
                        if(autorotate){
                          if(white){
                            setState(() {
                              boardwhite=true;
                            });
                          }else{
                            setState(() {
                              boardwhite=false;
                            });
                          }
                        }else{
                          setState(() {
                            boardwhite=true;
                          });
                        }
                      }catch(e){

                      }

                    },
                    child: CircleAvatar(
                      radius: 25,backgroundColor: Colors.indigo,
                      child:Icon(Icons.lock_reset_outlined,color: Colors.white,size: 28,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ):
        Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Global.text12("    ${AppLocalizations.of(context)!.translate("Choose Player Color")}", w),
              Global.text2("     ${AppLocalizations.of(context)!.translate("Let's Start by Choosing Black or White")}", w),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    r(_user!,w,chessby_level),
                    SizedBox(width: 10,),
                    r(widget.user,w,!chessby_level),
                  ],
                ),
              ),
              Global.text12("    ${AppLocalizations.of(context)!.translate("Game Time")}", w),
              Global.text2("     ${AppLocalizations.of(context)!.translate("Choose a Time Limit for Each Player")}", w),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    availt(0),availt(10),availt(20),availt(30),
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
              Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12),
                child: Row(
                  children: [
                    availt(3),availt(1),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Global.text12("    ${AppLocalizations.of(context)!.translate("Extra")}", w),
              Global.text2("     ${AppLocalizations.of(context)!.translate("Extra Functions for Game Preference")}", w),
              Global.text2("    (  ${AppLocalizations.of(context)!.translate("Could be Change Later during Game")} )", w),
              Row(
                children: [
                  Container(
                  width: w/2,
                  child: Text("${AppLocalizations.of(context)!.translate("AutoRoate Screen")}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),)),
                  Switch(value: autorotate, onChanged: (value){
                    setState(() {
                      autorotate=!autorotate;
                    });
                  }),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: w/2,
                      child: Text("    ${AppLocalizations.of(context)!.translate("Sound")}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),)),
                  Switch(value: sound, onChanged: (value){
                    setState(() {
                      sound=!sound;
                    });
                  }),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: w/2,
                      child: Text("    ${AppLocalizations.of(context)!.translate("Center Board")}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),)),
                  Switch(value:center, onChanged: (value){
                    setState(() {
                      center=!center;
                    });
                  }),
                ],
              ),
            ],
          ),
        )):
        Container(
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
                height: h-240,
                width: w,
                child: ValueListenableBuilder<Chess>(
                  valueListenable: controller,
                  builder: (context, game, _) {
                    // Retrieve and format the SAN data
                    final moves = controller.getSan().where((e) => e != null).toList();

                    return Container(
                      margin: const EdgeInsets.all(9.0), // Outer spacing
                      padding: const EdgeInsets.all(7.0), // Inner spacing
                      decoration: BoxDecoration(
                        color: Colors.grey[900], // Background color of the container
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.white, width: 1), // Optional border
                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 columns
                          childAspectRatio: 2, // Adjust for visual proportions
                        ),
                        itemCount: moves.length.clamp(0, 24), // Max 6 rows x 4 columns
                        itemBuilder: (context, index) {
                          return Text(
                            moves[index]!,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        hide=!hide;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 25,
                      child: Icon(Icons.close,color: Colors.white,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      final moves = controller.getSan().where((e) => e != null).map((e) => e!).toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovesPage(moves: moves, players: widget.user.Name+"x"+_user!.Name,),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 25,
                      child: Icon(Icons.download,color: Colors.white,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
        persistentFooterButtons: [
          start?InkWell(
              onTap: (){
                if(yesdone){
                  Navigator.push(
                      context, PageTransition(
                      child: Verify(user : widget.user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:  Text("${AppLocalizations.of(context)!.translate("Confirmation")}"),
                        content: Text("${AppLocalizations.of(context)!.translate("Are you sure the Game is Over?")}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              print("No selected");
                            },
                            child:  Text("${AppLocalizations.of(context)!.translate("No")}",
                          ),),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, PageTransition(
                                  child: Verify(user : widget.user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                              ));
                            },
                            child:  Text("${AppLocalizations.of(context)!.translate("Yes")}",
                          ),),
                        ],
                      );
                    },
                  );
                }
              },
              child: Center(child: !yesdone?Global.yellowcustomcentetr(w, 50, Colors.grey, Colors.black, " ${AppLocalizations.of(context)!.translate("Force Game Complete")}" ):Global.yellowwithout(w, " ${AppLocalizations.of(context)!.translate("End Game")}"))):InkWell(
              onTap: (){
                start=true;
                startt();
                setState(() {
                  avail=avail*60;
                  go=go*60;
                });
              },
              child: Center(child: Global.yellow(w, " ${AppLocalizations.of(context)!.translate("Start Game")}"))),
        ],
      ),
    );
  }
  bool yesdone=false;
  bool visible=false;String visibl="";
  final player = AudioPlayer();
  void gh1()async{
    try {
      if (sound) {
        if (controller.isInCheck()) {
          await player.play(AssetSource("move-check.mp3"));
        } else {
          await player.play(AssetSource("move-self.mp3"));
        }
      }
    }catch(e){
      print(e);
    }
  }

  /*   Expanded(
          child: ValueListenableBuilder<Chess>(
            valueListenable: controller,
            builder: (context, game, _) {
              // Retrieve and format the SAN data
              final moves = controller.getSan().where((e) => e != null).toList();

              return Container(
                margin: const EdgeInsets.all(9.0), // Outer spacing
                padding: const EdgeInsets.all(7.0), // Inner spacing
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Background color of the container
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.white, width: 1), // Optional border
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 4 columns
                    childAspectRatio: 2, // Adjust for visual proportions
                  ),
                  itemCount: moves.length.clamp(0, 24), // Max 6 rows x 4 columns
                  itemBuilder: (context, index) {
                    return Text(
                      moves[index]!,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              );
            },
          ),
        ),*/
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    bool result = false; // Default action: Don't close
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("${AppLocalizations.of(context)!.translate("Exit Confirmation")}"),
          content:  Text("${AppLocalizations.of(context)!.translate("Do you really want to close the Game?")}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                result = false; // Stay on the screen
              },
              child:  Text("${AppLocalizations.of(context)!.translate("No")}",
            ),),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                result = true; // Allow exiting
              },
              child: Text("${AppLocalizations.of(context)!.translate("Yes")}",
            ),),
          ],
        );
      },
    );
    return result; // Return the user's choice
  }
  Widget yesch(UserModel user,bool check){
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
          color: check?Colors.white:Colors.black,
          border: Border.all(
            color: check?Colors.black:Colors.white,
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 5,),
          CircleAvatar(
            backgroundImage: NetworkImage(user!.Pic_link),
          ),
          SizedBox(width: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(textAlign: TextAlign.start,trim(user.Name),style: TextStyle(color: check?Colors.black:Colors.white),),
              Text(check?"${forS(avail)}":"${forS(go)}",style: TextStyle(color:check?Colors.black: Colors.white,fontSize: 20),),
            ],
          )
        ],
      ),
    );
  }
  String forS(int seconds) {
    int minutes = seconds ~/ 60; // Calculate minutes
    int remainingSeconds = seconds % 60; // Calculate remaining seconds

    // Format as MM:SS
    String formatted = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formatted;
  }
  bool white=true;
  Timer? _timer; // Timer instance

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

  Future<void> changeti() async {
    if (avail == 0 && go == 0) {
   if (controller.isStaleMate()||controller.isDraw()) {
      await player.play(AssetSource("mixkit-fantasy-game-success-notification-270.wav"));
    } else if (controller.isCheckMate()||controller.isGameOver()) {
      await player.play(AssetSource("mixkit-winning-notification-2018.wav"));
    }
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


  @override
  Future<void> dispose() async {
    if (controller.isStaleMate()||controller.isDraw()) {
      await player.play(AssetSource("mixkit-fantasy-game-success-notification-270.wav"));
    } else if (controller.isCheckMate()||controller.isGameOver()) {
      await player.play(AssetSource("mixkit-winning-notification-2018.wav"));
    }
    _timer?.cancel();
    super.dispose();
  }
  bool autorotate=false;
  bool center = false ;
  bool hide = false ;
 bool chessby_level=false;
  int avail =0;
  int go=0;

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

  void initState(){

  }

  Widget r(UserModel user, double w,bool t){
    return Center(
      child: InkWell(
        onTap: (){
          setState(() {
            chessby_level=!chessby_level;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 55,
            width: w/2-30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: t?Colors.black:Colors.grey,
                ),
                color: t?Colors.white:Colors.transparent
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                CircleAvatar(
                  backgroundImage: NetworkImage(user.Pic_link),
                ),
                SizedBox(width: 8,),
                Text(trim(user.Name),style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: t?Colors.black:Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String trim(String input) {
    return input.length <= 7 ? input : input.substring(0, 7)+"....";
  }
}
