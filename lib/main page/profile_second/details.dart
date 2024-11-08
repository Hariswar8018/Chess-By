import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';


class Details extends StatefulWidget {
  Details({super.key,required this.i
  });
  int i=0;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController name=TextEditingController();

  Uint8List? file;

  void initState(){
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    name.text=_user!.Name;
    bio.text=_user.Bio;
    preference=_user.preference;
    chessby_level=_user.Chess_Level;
    language=_user.language;
    chessbycom.text=_user.chesscomu;
    liches.text=_user.lichessorgu;
    raing1=_user.chesscomra;
    rating2=_user.lichesorgran;
    bn(_user);
    if(_user.assetb){
      assetn=_user.assetn;
    }else{
    pic=_user!.Pic_link;
    }
    fideh.text=_user.fidera.toString();
  }

  void bn(UserModel user){
    try {
      DateTime gh = DateTime.parse(user.bday);
      age.text=calculateAge(gh).toString();
    }catch(e){

    }
  }
  TextEditingController fideh=TextEditingController();
  TextEditingController bio=TextEditingController();
  TextEditingController n1=TextEditingController();
  TextEditingController n2=TextEditingController();
  TextEditingController bday=TextEditingController();
  String pic="";
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
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
              opacity: 0.5
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
              ],
            ),  SizedBox(height: 5,),
            tyu(widget.i,w),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(child: InkWell(
            onTap: () async {
              if(widget.i==0){
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "Name": name.text,
                    "Pic_link":pic,
                    "assetb":assetn.isNotEmpty,
                    "assetn":assetn,
                    "Bio":bio.text
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Profile Change Successful")}",true);
              }else if(widget.i==1){
                try{
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "Chess_Level": chessby_level,
                    "language":language,
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Profile Change Successful")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }else if(widget.i==2){
                try{
                  int iopu=int.parse(fideh.text)??0;
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "chesscomra": raing1,
                    "lichesorgran":rating2,
                    "chesscomu":chessbycom.text,
                    "lichessorgu":liches.text,
                    "fidera":iopu,
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Profile Change Successful")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }else if(widget.i==4){
                try{
                  int iopu=int.parse(fideh.text)??0;
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "bday": bday.text,
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Profile Change Successful")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }else{
                try{
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "preference": preference,
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Profile Change Successful")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }
            },
            child: Global.yellowwithout(w, "${AppLocalizations.of(context)!.translate('SaveAndNext')}")))
      ],
    );
  }
Widget c(String str){
    return  InkWell(
      onTap: (){
        setState(() {
          assetn=str;
        });
      },
      child: assetn==str? CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        child: Center(
          child: CircleAvatar(
            radius:20,
            backgroundImage: AssetImage(str),
          ),
        ),
      ):CircleAvatar(
        radius:22,
        backgroundImage: AssetImage(str),
      ),
    );
}
String assetn ="";
  Widget tyu(int i,double w){
    if(i==0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:  Global.text2("${AppLocalizations.of(context)!.translate('AddPhotoNameBio')} ", w),
          ),
          SizedBox(height: 18,),
          Center(
            child: InkWell(
              onTap: () async {
                try{
                  Uint8List? _file = await pickImage(ImageSource.gallery);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Uploading")}.........", true);
                  String photoUrl =  await StorageMethods().uploadImageToStorage('users', _file!, true);

                  setState(() {
                    file = _file ;
                    pic = photoUrl ;
                    assetn="";
                  });
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Uploaded")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child:pic.isEmpty&&assetn.isEmpty? CircleAvatar(
                radius: 55,
                backgroundColor: Global.blac,
                child: Icon(Icons.camera_alt,color: Colors.yellow,size: 40,),
              ):assetn.isEmpty?CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(pic),
              ):CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage(assetn),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10,bottom: 10),
            child: Container(
              height:140,
              decoration: BoxDecoration(
                color: Color(0xff202020),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      c("assets/avatar/avatar/avatar4.jpg"),
                      c("assets/avatar/avatar/avatar5.jpg"),
                      c("assets/avatar/avatar/avatar6.jpg"),
                      c("assets/avatar/avatar/avatar7.jpg"),
                      c("assets/avatar/avatar/avatar8.jpg"),
                      c("assets/avatar/avatar/avatar16.jpg"),                      ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      c("assets/avatar/avatar/avatar10.jpg"),
                      c("assets/avatar/avatar/xQ2V4D_UQXS0qCFSr_qHRA.webp"),
                      c("assets/avatar/avatar/avatar12.jpg"),
                      c("assets/avatar/avatar/avatar13.jpg"),
                      c("assets/avatar/avatar/avatar14.jpg"),
                      c("assets/avatar/avatar/avatar9.jpg"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 9,),
          Global.d(name, "${AppLocalizations.of(context)!.translate("Your Name")}", "", false, false),
          SizedBox(height: 9,),
          bioo(),
        ],
      );
    }else if(i==1){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:   Global.text11(AppLocalizations.of(context)!.translate('SkillLevelAndLanguages'), w),
          ),
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:    Global.text2(AppLocalizations.of(context)!.translate('AddSkillsScores'), w),
          ),

          SizedBox(height: 18,),
          r("Begineer",w),
          r("Intermediate",w),
          r("Advance",w),
          SizedBox(height: 12,),
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:     Global.text2(AppLocalizations.of(context)!.translate('SelectLanguages'), w),
          ),
          SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              lan("English",w),
              lan("Spanish",w),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              lan("Hindi",w),
              lan("Portugese",w),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              lan("Chinese",w),
              lan("Russian",w),
            ],
          ),
        ],
      );
    }else if(i==2){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:     Global.text11(AppLocalizations.of(context)!.translate('GameStatistics'), w),
          ),
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:   Global.text2(AppLocalizations.of(context)!.translate('TypeUsernames'), w),
          ),
          SizedBox(height: 18,),
          Container(
            width: w-20,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w*1/3-30,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://images.chesscomfiles.com/uploads/v1/images_users/tiny_mce/PedroPinhata/phpNgJfyb.png"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                num(chessbycom, AppLocalizations.of(context)!.translate('ChessComUsername'), w),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: w-20,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w*1/3-30,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://ebastonblanco.com/wp-content/uploads/2023/12/Lichess_logo.png"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                num(liches,  AppLocalizations.of(context)!.translate('LichessOrgUsername'), w),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: w-20,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w*1/3-30,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://www.englishchess.org.uk/wp-content/uploads/2021/02/fidey.jpg"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                nutm(fideh,AppLocalizations.of(context)!.translate('FIDERanking'), w),
              ],
            ),
          ),
          SizedBox(height: 18,),
          Container(
            width: w-15,
            height: 180,
            decoration: BoxDecoration(
              color: Global.blac,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.translate('ImportedRatings'),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: w/2-40,
                        child: Text(AppLocalizations.of(context)!.translate('ChessComRatings'),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                      ),
                      Text(AppLocalizations.of(context)!.translate('LichessOrgRating'),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                    ],
                  ),
                  //            Equal_chessby  diego_lain
                  Row(
                    children: [
                      Container(
                        width: w/2-40,
                        child: Text("$raing1",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 23),),
                      ),
                      Text("$rating2 ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 23),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          InkWell(
              onTap: () async {
                try {
                  getchessbyComRating(chessbycom.text);
                  getLichessbyRating(liches.text);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("API Call Sended ! Importing Scores")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child: Center(child: Global.yellowwithout(w, "${AppLocalizations.of(context)!.translate("Re-Update My Scores")}"))),
        ],
      );
    }else if(i==4){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:     Global.text11(AppLocalizations.of(context)!.translate('Other'), w),
          ),
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:   Global.text2(AppLocalizations.of(context)!.translate('Other Information Required'), w),
          ),
          SizedBox(height: 18,),
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:     Global.text12(AppLocalizations.of(context)!.translate('Your Age'), w),
          ),
          Container(
            width: w-20,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    List<DateTime>? _dates = [];

                    List<DateTime?>? results = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(),
                      dialogSize: const Size(325, 400),
                      value: _dates,
                      borderRadius: BorderRadius.circular(15),
                    );

                    print(results);

                    if (results != null && results.isNotEmpty) {
                      _dates = results.cast<DateTime>(); // ✅ Update _dates with the selected results
                      print(_dates);

                      if (_dates.isNotEmpty) {
                        print(_dates.first);
                        bday.text=_dates.first.toString();
                        DateTime selectedDate = _dates.first; // Get the first selected date
                        int agee = calculateAge(selectedDate);
                        print(agee);
                        setState(() {
                          age.text = agee.toString();
                        });
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: w*1/3,
                      height: 70,
                     decoration: BoxDecoration(
                       color: Colors.yellowAccent,
                       borderRadius: BorderRadius.circular(10)
                     ),
                      child:Center(child: Text(AppLocalizations.of(context)!.translate("Select DOB"),style: TextStyle(fontWeight: FontWeight.w800),)),
                    ),
                  ),
                ),
                num1(age, AppLocalizations.of(context)!.translate('Your Age'), w),
              ],
            ),
          ),
        ],
      );
    }else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding:EdgeInsets.only(left: 15,right: 15),
                child: Global.text11(AppLocalizations.of(context)!.translate('GamePreference'), w),
              ),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Container(
                width: w,
                child: Padding(
                  padding:EdgeInsets.only(left: 15,right: 15),
                  child:  Global.text2(AppLocalizations.of(context)!.translate('SelectGamePreference'), w),
                ),
              ),
              Spacer()
            ],
          ),
          SizedBox(height: 18,),
          SingleChildScrollView(
            child: Column(
              children: [
                r1("Classical Chess",w),
                r1("Rapid Chess",w),
                r1("Bitz Chess",w),
                r1("Bullet Chess",w),
                r1("Corresponded Chess",w),
                r1("Chess 960",w),
                r1("Equal Chess",w),
              ],
            ),
          ),
          SizedBox(height: 22,),
        ],
      );
    }
  }
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust if the birthday hasn't occurred this year yet
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }
  int raing1=0,rating2=0;
  void getchessbyComRating(String username) async {
    final url = Uri.parse('https://api.chess.com/pub/player/$username/stats');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int? rating = data['chess_blitz']?['last']?['rating'];
        if (rating != null) {
          setState(() {
            raing1=rating;
          });
        }else{
          Send.message(context, "${AppLocalizations.of(context)!.translate("Chessby request failed with status")}: ${response.statusCode}", false);
        }
      } else {
        Send.message(context, "${AppLocalizations.of(context)!.translate("chessby.com request failed with status")}: ${response.statusCode}", false);
        print("${AppLocalizations.of(context)!.translate("chessby.com request failed with status")}: ${response.statusCode}");
      }
    } catch (e) {
      Send.message(context, "$e", false);
    }
  }

  /// Fetches the Lichessby.org rating for a given username
  Future<int?> getLichessbyRating(String username) async {
    final url = Uri.parse('https://lichess.org/api/user/$username');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int? rating = data['perfs']?['blitz']?['rating'];

        if (rating != null) {
          setState(() {
            rating2=rating;
          });
        }else{
          Send.message(context, "${AppLocalizations.of(context)!.translate("Lichessby request failed with status")}: ${response.statusCode}", false);
        }
      } else {
        Send.message(context, "${AppLocalizations.of(context)!.translate("Lichessby request failed with status")}: ${response.statusCode}", false);
        print("${AppLocalizations.of(context)!.translate("Lichessby request failed with status")}: ${response.statusCode}");
      }
    } catch (e) {
      Send.message(context, "$e", false);
    }
  }

  TextEditingController chessbycom =TextEditingController();
  TextEditingController liches=TextEditingController();

  TextEditingController age =TextEditingController();
  List language=[];
  Widget lan(String r1, double w){
    return Center(
      child: InkWell(
        onTap: (){
          setState(() {
            if(language.contains(r1)){
              language.remove(r1);
            }else{
              language=language+[r1];
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 55,
            width: w/2-20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: language.contains(r1)?Colors.yellow:Colors.grey,
                ),
                color: language.contains(r1)?Colors.yellow.withOpacity(0.2):Colors.transparent
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                language.contains(r1)?Icon(Icons.check_circle_rounded,color: Colors.yellow,):Icon(Icons.circle,color: Colors.grey,),
                SizedBox(width: 8,),
                Text(r1,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String chessby_level="";

  Widget r(String r1, double w){
    return Center(
      child: InkWell(
        onTap: (){
          setState(() {
            chessby_level=r1;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 55,
            width: w-30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: chessby_level==r1?Colors.yellow:Colors.grey,
                ),
                color: chessby_level==r1?Colors.yellow.withOpacity(0.2):Colors.transparent
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                chessby_level==r1?Icon(Icons.check_circle_rounded,color: Colors.yellow,):Icon(Icons.circle,color: Colors.grey,),
                SizedBox(width: 8,),
                Text(r1,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }
  List preference=[];
  Widget r1(String r1, double w){
    return Center(
      child: InkWell(
        onTap: (){
          setState(() {
            if(preference.contains(r1)){
              preference.remove(r1);
            }else{
              preference=preference+[r1];
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 55,
            width: w-30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: preference.contains(r1)?Colors.yellow:Colors.grey,
                ),
                color: preference.contains(r1)?Colors.yellow.withOpacity(0.2):Colors.transparent
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                preference.contains(r1)?Icon(Icons.check_circle_rounded,color: Colors.yellow,):Icon(Icons.circle,color: Colors.grey,),
                SizedBox(width: 8,),
                Text(r1,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget num(TextEditingController c, String label,double w){
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14),
      child:Container(
        width:w*2/3-40,
        height:60,
        decoration: BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: c,
            keyboardType: TextInputType.text ,
            decoration: InputDecoration(
              labelText: "  " + label,
              isDense: true,
              filled: true,
              fillColor: Color(0xff202020), // Set the editor background color to black
              labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
              hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
              border: InputBorder.none, // Remove the underline
              focusedBorder: InputBorder.none, // Remove the underline when focused
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please type it';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
  Widget num1(TextEditingController c, String label,double w){
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14),
      child:Container(
        width:w*2/3-40,
        height:60,
        decoration: BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: c,
            readOnly: true,
            keyboardType: TextInputType.text ,
            decoration: InputDecoration(
              labelText: "  " + label,
              isDense: true,
              filled: true,
              fillColor: Color(0xff202020), // Set the editor background color to black
              labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
              hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
              border: InputBorder.none, // Remove the underline
              focusedBorder: InputBorder.none, // Remove the underline when focused
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please type it';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
  Widget nutm(TextEditingController c, String label,double w){
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14),
      child:Container(
        width:w*2/3-40,
        height:60,
        decoration: BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: c,
            keyboardType: TextInputType.number ,
            decoration: InputDecoration(
              labelText: "  " + label,
              isDense: true,
              filled: true,
              fillColor: Color(0xff202020), // Set the editor background color to black
              labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
              hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
              border: InputBorder.none, // Remove the underline
              focusedBorder: InputBorder.none, // Remove the underline when focused
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please type it';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  Widget bioo(){
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14),
      child:Container(
        decoration: BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: bio,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              labelText: "Your Bio",
              isDense: true,
              filled: true,
              fillColor: Color(0xff202020), // Set the editor background color to black
              labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
              hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
              border: InputBorder.none, // Remove the underline
              focusedBorder: InputBorder.none, // Remove the underline when focused
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please type it';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
