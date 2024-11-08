import 'package:chessby/Google/my_location.dart';
import 'package:chessby/MY_Profile/Club_Not_Update.dart';
import 'package:chessby/MY_Profile/TeacherNot.dart';
import 'package:chessby/MY_Profile/club_navigation.dart';
import 'package:chessby/MY_Profile/club_or_not.dart';
import 'package:chessby/MY_Profile/teacher_navigation.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/main%20page/Notifications/mynavigation.dart';
import 'package:chessby/main%20page/administration/adminstration.dart';
import 'package:chessby/main%20page/premium.dart';
import 'package:chessby/main%20page/profile_second/block.dart';
import 'package:chessby/main%20page/profile_second/details.dart';
import 'package:chessby/main%20page/profile_second/points.dart';
import 'package:chessby/main%20page/shop/navigation.dart';
import 'package:chessby/main%20page/shop/teacher.dart';
import 'package:chessby/main.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/more_settings/support.dart';
import 'package:chessby/more_settings/teacher_or_not.dart';
import 'package:chessby/providers/declare.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localization.dart';

class Profile extends StatefulWidget {
  bool on;
  Profile({super.key,this.on=false});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  initState() {
    super.initState();
    vq();
    op();
  }
  void op(){
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    sound=_user!.public;
  }
  late bool sound;
  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Global.buildDrawer(context),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Global.blac,
              radius: 25,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context, PageTransition(
                      child:Notifications(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                  ));
                },
                icon: Icon(Icons.notification_add, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,right: 8),
            child: CircleAvatar(
              backgroundColor: Global.blac,
              radius: 25,
              child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(Icons.more_vert_outlined, color: Colors.white),
              ),
            ),
          ),
        ],
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                height : 130,
                width : MediaQuery.of(context).size.width,
                child: Center(
                  child: _user!.assetb?CircleAvatar(
                    backgroundImage: AssetImage(
                      _user!.assetn,
                    ),
                    minRadius: 50,
                    maxRadius: 60,
                  ):CircleAvatar(
                    backgroundImage: NetworkImage(
                      _user!.Pic_link,
                    ),
                    minRadius: 50,
                    maxRadius: 60,
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Text(_user.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),),
              Text(_user.Email,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 17),),
              SizedBox(height : 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Global.blac,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.subscriptions,color: Colors.yellowAccent,),
                          SizedBox(width: 8,),
                          Text((_user.Won+_user.lichesorgran+_user.chesscomra).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Center(
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.account_balance_wallet,color: Colors.yellowAccent,),
                          SizedBox(width: 8,),
                          Text("0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  f(AppLocalizations.of(context)!.translate("Played"),(_user.Won+_user.Lose+_user.Draw).toString(),context),
                  f(AppLocalizations.of(context)!.translate("Won"),_user.Won.toString(),context),
                  f(AppLocalizations.of(context)!.translate("Lose"),_user.Lose.toString(),context),
                  f(AppLocalizations.of(context)!.translate("Draw"),_user.Draw.toString(),context),
                ],
              ),
              SizedBox(height : 25),
              InkWell(
                onLongPress: (){
                  if(_user.Email=="diego@chessby.com"||_user.filterpreference.contains("Admin")||_user.Email=="haka@g.com"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Administration()),
                    );
                  }
                },
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Details(i: 0,)),
                  );
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Global.blac,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    width: w-20,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Icon(Icons.person,color: Colors.white),
                          SizedBox(width: 7,),
                          Text(AppLocalizations.of(context)!.translate("UserProfile"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Details(i: 1,)),
                  );
                },
                child: r1(w,AppLocalizations.of(context)!.translate("SkillLevelAndLanguage"), Icon(Icons.edit,color: Colors.white),Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.green,
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                    child: Text(_user.Chess_Level,style: TextStyle(color: Colors.white),),
                  ),
                )),
              ),
              InkWell(
                onTap: () async {
                  if(sound){
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_user!.uid)
                        .update({
                      "public":false,
                    });
                    Send.message(context, "${AppLocalizations.of(context)!.translate("Your Account is Private Now")}", true);
                  }else{
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_user!.uid)
                        .update({
                      "public": true,
                    });
                    Send.message(context, "${AppLocalizations.of(context)!.translate("Your Account is Public Now")}", true);
                  }
                  setState(() {
                    sound=!sound;
                  });
                },
                child: r1(w,sound?AppLocalizations.of(context)!.translate("PublicProfile"):AppLocalizations.of(context)!.translate("PrivateProfile"),sound? Icon(Icons.public,color: Colors.white):Icon(Icons.public_off,color: Colors.white),Switch(value: sound, onChanged: (value) async {
                  if(sound){
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_user!.uid)
                        .update({
                      "public":false,
                    });
                    Send.message(context, "${AppLocalizations.of(context)!.translate("Your Account is Private Now")}", true);
                  }else{
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_user!.uid)
                        .update({
                      "public": true,
                    });
                    Send.message(context, "${AppLocalizations.of(context)!.translate("Your Account is Public Now")}", true);
                  }
                  setState(() {
                    sound=!sound;
                  });
                })),
              ),
              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>MyPremium()),
                    );
                  },
                  child: r1(w,AppLocalizations.of(context)!.translate("ChessByPremium"), Icon(Icons.workspace_premium,color: Colors.white),Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.workspace_premium,color: Colors.yellow)
                  ),),),
              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Details(i: 4,)),
                    );
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("Other"), Icon(Icons.gavel_rounded,color: Colors.white),)),
              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Details(i: 2,)),
                    );
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("ChessComAndLichessOrgPoints"), Icon(Icons.gamepad,color: Colors.white),)),
              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Details(i: 3,)),
                    );
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("GamePreference"), Icon(Icons.gavel_rounded,color: Colors.white),)),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Points()),
                  );
                },
                child: r1(w,AppLocalizations.of(context)!.translate("ChessByPoints"), Icon(Icons.leaderboard,color: Colors.white),Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Global.blac,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star_outline_sharp,color: Colors.yellowAccent,),
                      SizedBox(width: 8,),
                      Text((_user.Won+_user.lichesorgran+_user.chesscomra).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),),
              ),
              InkWell(
                onTap: () async {
                  final Uri _url = Uri.parse('http://gamicoin.com/');
                  if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                  }
                },
                child: r1(w,"GamiCoins", Icon(Icons.account_balance_wallet,color: Colors.white),Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Global.blac,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("${AppLocalizations.of(context)!.translate("COMING SOON")}",style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.w700),),
                ),),
              ),
              InkWell(
                  onTap: () async {
                      Navigator.push(
                          context, PageTransition(
                          child: ClubNot(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                      ));
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("YourChessByClub"), Icon(Icons.supervised_user_circle,color: Colors.white),)),
              InkWell(
                  onTap: (){
                    if(_user.fidetitle.isEmpty){
                      Navigator.push(
                          context, PageTransition(
                          child: TeacherS(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    }else{
                      Navigator.push(
                          context, PageTransition(
                          child: TeacherS(trueu: true,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    }
                  },
                  child: _user.fidetitle.isNotEmpty? r1(w,AppLocalizations.of(context)!.translate("UpdateTeacherProifile"), Icon(Icons.bookmark,color: Colors.white),Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.admin_panel_settings_sharp,color: Colors.tealAccent,),
                        SizedBox(width: 8,),
                        Text(AppLocalizations.of(context)!.translate("Teacher"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)
                      ],
                    ),
                  ),):r(w,AppLocalizations.of(context)!.translate("TeacherProfile"), Icon(Icons.bookmark,color: Colors.white),)),
              InkWell(
                  onTap: (){
                    Navigator.push(
                        context, PageTransition(
                        child: ShopM(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                    ));
                  },
                  child: r1(w,AppLocalizations.of(context)!.translate("ChessShopAndCourses"), Icon(Icons.shop_2,color: Colors.white),Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.discount,color: Colors.red,),
                        SizedBox(width: 8,),
                        Text(AppLocalizations.of(context)!.translate("New"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)
                      ],
                    ),
                  ),)),
              InkWell(
                  onTap: (){
                    Navigator.push(
                        context, PageTransition(
                        child: My_Location(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                    ));
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("UpdateLocation"), Icon(Icons.location_on_rounded,color: Colors.white),)),
              InkWell(
                  onTap: () async {
                    final Uri _url = Uri.parse('https://chessby.com/privacy/');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("PrivacyPolicy"), Icon(Icons.privacy_tip,color: Colors.white),)),
              InkWell(
                  onTap: () async {
                    final Uri _url = Uri.parse('https://chessby.com/');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("OurWebsite"), Icon(Icons.language,color: Colors.white),)),
              InkWell(
                  onTap: () async {
                    Navigator.push(
                        context, PageTransition(
                        child: Block(str: _user.uid,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("BlockAndReportedUsers"), Icon(Icons.lock_reset,color: Colors.white),)),
              InkWell(
                  onTap: () async {
                    try{
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.sendPasswordResetEmail(email: _user.Email);
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Sent ! Please check Email to Reset Password")}", true);
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("ResetPassword"), Icon(Icons.lock_reset,color: Colors.white),)),
              InkWell(
                  onTap: (){
                    Navigator.push(
                        context, PageTransition(
                        child: Support(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: r(w,AppLocalizations.of(context)!.translate("Support"), Icon(Icons.support_agent,color: Colors.white),)),
              InkWell(
                onTap: (){
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => First()),
                    );
                  });
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        )
                    ),
                    width: w-20,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Icon(Icons.login,color: Colors.red),
                          SizedBox(width: 7,),
                          Text(AppLocalizations.of(context)!.translate("LogOut"),style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(height: 60,),
              /*ListTile(
                leading: Icon(Icons.my_library_books_sharp, color: Colors.greenAccent, size: 30),
                title: Text("Teacher Profile"),
                onTap: () async {
                  bool t = false;
                  await FirebaseFirestore.instance
                      .collection('teacher')
                      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((value) => value.size > 0 ? t = true : t = false );
                  if(t){
                    Navigator.push(
                        context, PageTransition(
                        child: Teacher_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));

                  }else{
                    Navigator.push(
                        context, PageTransition(
                        child: TecaherNot(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  }
                },
                subtitle: Text("Check your Teacher Dashboard"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              SizedBox(height: 20,),
              Text("chessby BEE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic)),
              Text("Made with ❤️ in Spain & India", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Image.asset("assets/chessbybe.jpg", height: 80,),
              Text("chessbyBe version : 1.2", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
              SizedBox(height: 20,),*/
            ],
          ),
        ),
      ),
    );
  }
  Widget r1(double w, String str,Widget r,Widget r1)=>Center(
    child: Container(
      decoration: BoxDecoration(
        color: Global.blac,
      ),
      width: w-20,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            r,
            SizedBox(width: 7,),
            Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            Spacer(),
            r1,
          ],
        ),
      ),
    ),
  );
  Widget r(double w, String str,Widget r)=>Center(
    child: Container(
      decoration: BoxDecoration(
          color: Global.blac,
      ),
      width: w-20,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
           r,
            SizedBox(width: 7,),
            Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    ),
  );
  Widget f(String str, String str2,BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Global.blac,
        borderRadius: BorderRadius.circular(15)
      ),
      width: MediaQuery.of(context).size.width/4-9,
      height: MediaQuery.of(context).size.width/4-15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str,style: TextStyle(fontSize: 17,color: Colors.grey),),
          SizedBox(height: 4,),
          Text(str2,style: TextStyle(fontSize: 21,color: Colors.white),),
        ],
      ),
    );
  }
}
