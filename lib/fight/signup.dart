import 'dart:math';
import 'dart:typed_data';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:chessby/Google/my_location.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/shop/teacher.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main page/navigation.dart';
import 'package:chessby/MY_Profile/teacher_navigation.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:current_location/current_location.dart';
import 'package:current_location/model/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class ConfirmPassword extends StatefulWidget {
  ConfirmPassword({super.key,required this.email});

  TextEditingController email ;

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
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
              opacity: 0.6,
          ),
        ),
        child:done?Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
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
            ),  SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black,
                child: Icon(Icons.verified,color: Colors.yellow,size: 40,),
              ),
            ),
            Global.text1("   ${AppLocalizations.of(context)!.translate("You're All Set")} ! ", w),
            Global.text2("     ${AppLocalizations.of(context)!.translate("Thank you for Creating Account with Us")}", w),
            Global.text2("     ${AppLocalizations.of(context)!.translate("Your Account is Created Successfully")}", w),
            Global.height(20),
            InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SecondForm(email: widget.email.text,),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                },
                child: Center(child: Global.yellowwithout(w, "Login Now"))),
          ],
        ): Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
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
            ),  SizedBox(height: 50,),
            Global.text1("   ${AppLocalizations.of(context)!.translate("Create a New Password")} ", w),
            Global.text2("     ${AppLocalizations.of(context)!.translate("Please Enter New Password for your Account")}", w),
            Global.height(20),
            Global.d(pass1, " ${AppLocalizations.of(context)!.translate("Type your Password")}", "", false,false),
            Global.height(10),
            Global.d(pass2, " ${AppLocalizations.of(context)!.translate("Confirm your Password")}", "", false,false),
            Global.height(10),
            InkWell(
                onTap: () async {
                  if(pass1.text==pass2.text){
                    try{
                     final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email.text, password: pass1.text);
                      UserModel user = UserModel(
                        Email: widget.email.text, Chess_Level: "NA", State : "",
                        Name: "", Pic_link: "https://firebasestorage.googleapis.com/v0/b/smartlancer-660d4.appspot.com/o/ef722cf2-e2a0-41fd-8104-8ce8f6bcedf2.jpeg?alt=media&token=afd87757-8f7c-407b-ad70-e5b7f830943a", Bio: "", Draw: 0, Gender: "Male", Language: "English",
                        Location:"", Lose: 0, Talk: "Talk", Won: 0, uid: cred.user!.uid, age: "13", Lat: 22.2661556,
                        lastlogin:  "", Lon: 84.9088836, lastloginn: "", code: "", token: '', preference: [], language: [],
                        filterpreference: [], filterlanguage: [], filterskill: '', chesscomra: 0, lichesorgran: 0, chesscomu: '', lichessorgu: '',
                        fpreference: 'All', fgamelevel: 'All', favailable: 'All', flanguage: 'All', block: [], Report: [], fidera: 0,
                        fidetitle: '', close: [], speacialize: '', price: 0, chessplace: false, tournamentmanager: false, assetb: false, bday: '2000-02-17 00:00:00.000', maxdistance: 10000.0,);
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(cred.user!.uid).set(user.toJson());
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Created Account Successfully")}", true);
                      setState((){
                        done=true;
                      });
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  }else{
                    Send.message(context, "${AppLocalizations.of(context)!.translate("Password Not Same")} !", false);
                  }

                },
                child: Center(child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("Create new Password")}"))),
          ],
        ),
      ),
    );
  }
}

class SecondForm extends StatefulWidget {
  String email;
   SecondForm({super.key,required this.email});

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
   int i=0;

   void initState(){
     f();
     Lat.text="26.333";
     Lon.text="34.555";
   }

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
              opacity: 0.3
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: InkWell(
                    onTap: (){
                      if(i==0){
                        Navigator.pop(context);
                      }else{
                        i=i-1;
                        setState((){

                        });
                      }

                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                ),Spacer(),
                InkWell(
                  onTap: () async {
                    if(i>=3){
                      try {
                        if(preference.isEmpty){
                          Send.message(context, "${AppLocalizations.of(context)!.translate('NoPreference')}", false);
                          return ;
                        }
                        if(name.text.isEmpty){
                          Send.message(context, "${AppLocalizations.of(context)!.translate('NameEmpty')}", false);
                          return ;
                        }
                        if(chessby_level.isEmpty){
                          Send.message(context, "${AppLocalizations.of(context)!.translate('NoChessbyLevel')}", false);
                          return ;
                        }
                        if(language.isEmpty){
                          Send.message(context, "${AppLocalizations.of(context)!.translate('NoLanguage')}", false);
                          return ;
                        }
                        int fiderat = int.parse(fidera.text) ?? 0;
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        print(uid);
                        UserModel user = UserModel(
                            Email: widget.email, Chess_Level: chessby_level, State: State.text,
                            Name: name.text, Pic_link: pic, Bio: bio.text,
                            Draw: 0, Gender: n1.text.toString(), Language: n2.text.toString(),
                            Location: "", Lose: 0, Talk: "", Won: 0, uid: uid, age: "13",
                            Lat: 23.99, lastlogin: "", Lon: 56.99, lastloginn: "6789", code: "", token: '',
                            preference: preference, language: language, filterlanguage: [], filterpreference: [],
                            filterskill: '', chesscomra: raing1, lichesorgran: rating2,
                            chesscomu: chessbycom.text, lichessorgu: liches.text, fpreference: 'All', fgamelevel: "All",
                            favailable: 'All', flanguage: 'All', block: [], Report: [],
                            fidera: fiderat, fidetitle: '', close: [], speacialize: '',
                            price: 0, chessplace: false, tournamentmanager: false, assetb: assetn.isNotEmpty,assetn: assetn, bday: '2000-02-17 00:00:00.000', maxdistance: 10000.0);
                        try{
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid).set(user.toJson());
                        }catch(e){
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid).update(user.toJson());
                        }

                        Send.message(
                            context, "${AppLocalizations.of(context)!.translate('AccountUpdated')}", true);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ConfirmPassword1(email: name,),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 80)));
                      }catch(e){
                        Send.message(context,"$e",false);
                      }
                    }else{
                      i=i+1;
                      setState((){

                      });
                    }
                  },
                  child:Container(
                    color:Colors.yellow,
                    child:Padding(
                      padding: const EdgeInsets.only(left: 12,right:12,top: 6,bottom: 6),
                      child:Text("Continue",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w700)),
                    )
                  ),
                ),SizedBox(width: 9,),
              ],
            ),  SizedBox(height: 20,),
            s(w),
            Spacer(),

            SizedBox(height: 30,),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: InkWell(
              onTap: () async {
                if(i>=3){
                  try {
                    if(preference.isEmpty){
                      Send.message(context, "${AppLocalizations.of(context)!.translate('NoPreference')}", false);
                      return ;
                    }
                    if(name.text.isEmpty){
                      Send.message(context, "${AppLocalizations.of(context)!.translate('NameEmpty')}", false);
                      return ;
                    }
                    if(chessby_level.isEmpty){
                      Send.message(context, "${AppLocalizations.of(context)!.translate('NoChessbyLevel')}", false);
                      return ;
                    }
                    if(language.isEmpty){
                      Send.message(context, "${AppLocalizations.of(context)!.translate('NoLanguage')}", false);
                      return ;
                    }
                    int fiderat = int.parse(fidera.text) ?? 0;
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    print(uid);
                    UserModel user = UserModel(
                        Email: widget.email, Chess_Level: chessby_level, State: State.text,
                        Name: name.text, Pic_link: pic, Bio: bio.text,
                        Draw: 0, Gender: n1.text.toString(), Language: n2.text.toString(),
                        Location: "", Lose: 0, Talk: "", Won: 0, uid: uid, age: "13",
                        Lat: 23.99, lastlogin: "", Lon: 56.99, lastloginn: "6789", code: "", token: '',
                        preference: preference, language: language, filterlanguage: [], filterpreference: [],
                        filterskill: '', chesscomra: raing1, lichesorgran: rating2,
                        chesscomu: chessbycom.text, lichessorgu: liches.text, fpreference: 'All', fgamelevel: "All",
                        favailable: 'All', flanguage: 'All', block: [], Report: [],
                        fidera: fiderat, fidetitle: '', close: [], speacialize: '',
                        price: 0, chessplace: false, tournamentmanager: false, assetb: assetn.isNotEmpty,assetn: assetn, bday: age.text, maxdistance: 10000.0);
                    try{
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid).set(user.toJson());
                    }catch(e){
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid).update(user.toJson());
                    }

                    Send.message(
                        context, "${AppLocalizations.of(context)!.translate('AccountUpdated')}", true);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ConfirmPassword1(email: name,),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 80)));
                  }catch(e){
                    Send.message(context,"$e",false);
                  }
                }else{
                  i=i+1;
                  setState((){

                  });
                }
              },
              child: Global.yellow(w, "${AppLocalizations.of(context)!.translate('SaveAndNext')}")),
        ),
      ],
    );
  }
   TextEditingController age=TextEditingController();
   f() async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     String gh = FirebaseAuth.instance.currentUser!.email ?? "h" ;
     final Location? userLocation = await UserLocation.getValue();
     String country = userLocation!.country ?? "INDIA";
     String state = userLocation.regionName ?? "ODISHA";
     String sip = userLocation.isp ?? "IP" ;
     double lat = userLocation.latitude ?? 677.22;
     double lon = userLocation.longitude ?? 567.9;
     print(state);
     String address = " ";
     List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat!, lon!);
     if (placemarks != null && placemarks.isNotEmpty) {
       geocoding.Placemark placemark = placemarks.first;
       // Access the address components
       address = "${placemark.street}, ${placemark.locality}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.isoCountryCode}";
       print("User's address: $address");
     }

     setState(() {
       h  = prefs.getString('State') ?? "Canary Islands";
       State = TextEditingController(text : h);
       Email = TextEditingController(text : gh);
       Address = TextEditingController(text : address);
       Lat = TextEditingController(text : lat.toString());
       Lon = TextEditingController(text : lon.toString());
     });
   }

   String h="";
  TextEditingController State=TextEditingController();
   TextEditingController Email=TextEditingController();
   TextEditingController Address=TextEditingController();
   TextEditingController Lat=TextEditingController(); TextEditingController Lon=TextEditingController();

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

  TextEditingController name=TextEditingController();
   Uint8List? file;
  TextEditingController bio=TextEditingController();
   TextEditingController n1=TextEditingController();
   TextEditingController n2=TextEditingController();
String pic="https://firebasestorage.googleapis.com/v0/b/smartlancer-660d4.appspot.com/o/ef722cf2-e2a0-41fd-8104-8ce8f6bcedf2.jpeg?alt=media&token=afd87757-8f7c-407b-ad70-e5b7f830943a";
   TextEditingController play=TextEditingController();
   TextEditingController win=TextEditingController();
   TextEditingController loss=TextEditingController();
   TextEditingController draw=TextEditingController();

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
   String assetn ="assets/avatar/avatar/avatar11.jpg";
  Widget s(double w){
    if(i==0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding:EdgeInsets.only(left: 15,right: 15),
              child:  Global.text11("${AppLocalizations.of(context)!.translate('TellUsAboutYou')}", w),
          ),
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
                  Send.message(context, "${AppLocalizations.of(context)!.translate('Uploading')}.........", true);
                  String photoUrl =  await StorageMethods().uploadImageToStorage('users', _file!, true);
                  setState(() {
                    file = _file ;
                    pic = photoUrl ;
                    assetn="";
                  });
                  Send.message(context, "${AppLocalizations.of(context)!.translate('Uploaded')}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child:file==null&&assetn.isEmpty? CircleAvatar(
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
              height:120,
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
          Padding(
            padding:EdgeInsets.only(left: 15,right: 15),
            child:     Global.text12(AppLocalizations.of(context)!.translate('YourName'), w),
          ),
          Global.d(name, AppLocalizations.of(context)!.translate('YourName'), "", false, false),
          SizedBox(height: 9,),
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
                        age.text=_dates.first.toString();
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
          Center(child: r("Begineer",w)),
          Center(child: r("Intermediate",w)),
          Center(child: r("Advance",w)),
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
                        image: NetworkImage("https://www.chess-chivalry.com/cdn/shop/articles/FIDE-Tile.webp?v=1673516071"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                num4(fidera, AppLocalizations.of(context)!.translate('FIDERanking'), w),
              ],
            ),
          ),
          SizedBox(height: 18,),
          Container(
            width: w-15,
            height: 160,
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
          SizedBox(height: 12,),
          InkWell(
              onTap: () async {
                try {
                  getchessbyComRating(chessbycom.text);
                  getLichessbyRating(liches.text);
                  Send.message(context, AppLocalizations.of(context)!.translate('APICallSent'), true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child: Center(child: Global.yellowwithout(w, AppLocalizations.of(context)!.translate('ImportScores')))),
        ],
      );
    }else{
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
  TextEditingController fidera=TextEditingController(text: "0");
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
           Send.message(context, "Lichessby request failed with status: ${response.statusCode}", false);
         }
       } else {
         Send.message(context, "Chess.com request failed with status: ${response.statusCode}", false);
         print("Chess.com request failed with status: ${response.statusCode}");
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
           Send.message(context, "Lichess request failed with status: ${response.statusCode}", false);
         }
       } else {
         Send.message(context, "Lichess request failed with status: ${response.statusCode}", false);
         print("Lichess request failed with status: ${response.statusCode}");
       }
     } catch (e) {
       Send.message(context, "$e", false);
     }
   }

  TextEditingController chessbycom =TextEditingController();
  TextEditingController liches=TextEditingController();

  String chessby_level="";
  List preference=[];
   Widget r1(String r1, double w){
     return InkWell(
       onTap: (){
         setState(() {
           if(preference.contains(r1)){
             preference.remove(r1);
           }else{
             preference=preference+[r1];
           }
         });
       },
       child:Padding(
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
     );
   }

  Widget r(String r1, double w){
    return InkWell(
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
    );
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
              labelText: AppLocalizations.of(context)!.translate('YourBio'),
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

   Widget num2(TextEditingController c, String label,double w){
     return Padding(
       padding: const EdgeInsets.only(left: 14.0,right: 14,bottom: 5),
       child:Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(" "+label,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 13),),
           Container(
             height: 50,
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
         ],
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
   Widget num4(TextEditingController c, String label,double w){
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
}


class ConfirmPassword1 extends StatefulWidget {
  ConfirmPassword1({super.key,required this.email});

  TextEditingController email ;

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
            opacity: 0.6,
          ),
        ),
        child:done?Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
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
            ),  SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black,
                child: Icon(Icons.verified,color: Colors.yellow,size: 40,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child:  Global.text1(AppLocalizations.of(context)!.translate('YoureAllSet'), w),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child:   Global.text2(AppLocalizations.of(context)!.translate('AccountCreatedSuccessfully'), w),
            ),  Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child: Global.text2(AppLocalizations.of(context)!.translate('ChoosePublicArea'), w),
            ),
            Global.height(20),
            InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Home(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                  Navigator.push(
                      context, PageTransition(
                      child: My_Location(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                  ));
                  Navigator.push(
                      context, PageTransition(
                      child: Countryy(justname: true,), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 80)
                  ));
                },
                child: Center(child: Global.yellowwithout(w, AppLocalizations.of(context)!.translate('YesFetchLocation')))),
           /* TextButton(onPressed: (){
              done=false;
              setState(() {

              });
            }, child:Text("Change"))*/
          ],
        ): Column(
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
            Global.text1("${ AppLocalizations.of(context)!.translate('CreateSchool')} /", w),
            Global.text1("${AppLocalizations.of(context)!.translate('TeacherProfile')}} ?", w),
            Global.text2(AppLocalizations.of(context)!.translate('ConnectChessStudents'), w),
            Global.height(20),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Home(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                  Navigator.push(
                      context, PageTransition(
                      child: TeacherS(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                  ));
                  Navigator.push(
                      context, PageTransition(
                      child: My_Location(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                  ));
                  Navigator.push(
                      context, PageTransition(
                      child: Countryy(justname: true,), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 80)
                  ));
                },
                child: Global.yellowwithout(w, AppLocalizations.of(context)!.translate('CreateTeacherProfile'))),
            Global.height(18),
            InkWell(
                onTap: (){
                  setState(() {
                    done=true;
                  });
                },
                child: Global.yellowcustomcentetr(w, 58,  Colors.white,Colors.black,  AppLocalizations.of(context)!.translate('SkipTeacherProfile'))),
            Global.height(10),
          ],
        ),
      ),
    );
  }
}
