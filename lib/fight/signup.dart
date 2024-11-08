import 'dart:math';
import 'dart:typed_data';
import 'package:chessby/Google/my_location.dart';
import 'package:chessby/first/countries.dart';
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
            Global.text1("  You're All Set ! ", w),
            Global.text2("    Thank you for Creating Account with Us", w),
            Global.text2("    Your Account is Created Successfully", w),
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
            Global.text1("  Create a New Password ", w),
            Global.text2("    Please Enter New Password for your Account", w),
            Global.height(20),
            Global.d(pass1, "Type your Password", "", false,false),
            Global.height(10),
            Global.d(pass2, "Confirm your Password", "", false,false),
            Global.height(10),
            InkWell(
                onTap: () async {
                  if(pass1.text==pass2.text){
                    try{
                     final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email.text, password: pass1.text);
                      UserModel user = UserModel(
                        Email: widget.email.text, Chess_Level: "NA", State : "",
                        Name: "", Pic_link: "", Bio: "", Draw: 0, Gender: "Male", Language: "English",
                        Location:"", Lose: 0, Talk: "Talk", Won: 0, uid: cred.user!.uid, age: "13", Lat: 22.2661556,
                        lastlogin:  "", Lon: 84.9088836, lastloginn: "", code: "", token: '', preference: [], language: [],
                        filterpreference: [], filterlanguage: [], filterskill: '', chesscomra: 0, lichesorgran: 0, chesscomu: '', lichessorgu: '',
                        fpreference: 'All', fgamelevel: 'All', favailable: 'All', flanguage: 'All', block: [], Report: [],);
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(cred.user!.uid).set(user.toJson());
                      Send.message(context, "Created Account Successfully", true);
                      setState((){
                        done=true;
                      });
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  }else{
                    Send.message(context, "Password Not Same !", false);
                  }

                },
                child: Center(child: Global.yellow(w, "Create new Password"))),
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
                ),
              ],
            ),  SizedBox(height: 20,),
            s(w),
            Spacer(),
            InkWell(
                onTap: () async {
                  if(i>=3){
                    String uid=FirebaseAuth.instance.currentUser!.uid;
                    UserModel user = UserModel(
                      Email: widget.email, Chess_Level: chessby_level, State : State.text,
                      Name: name.text, Pic_link: pic, Bio: bio.text, Draw: 0, Gender: n1.text.toString(), Language: n2.text.toString(),
                      Location:"", Lose: 0, Talk: "", Won: 0, uid: uid, age: "13", Lat: 23.99,
                      lastlogin:  "", Lon: 56.99, lastloginn: "6789", code: "", token: '', preference:preference, language: language,
                      filterlanguage: [], filterpreference: [], filterskill: '', chesscomra: raing1, lichesorgran:rating2, chesscomu: chessbycom.text, lichessorgu: liches.text,
                      fpreference: 'All', fgamelevel: "All", favailable: 'All', flanguage: 'All', block: [], Report: [],);
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid).update(user.toJson());
                    Send.message(context, "Account Update Successfully", true);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ConfirmPassword1(email: name,),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 80)));
                  }else{
                    i=i+1;
                    setState((){

                    });
                  }
                },
                child: Global.yellow(w, "Save & Next")),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

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
String pic="";
   TextEditingController play=TextEditingController();
   TextEditingController win=TextEditingController();
   TextEditingController loss=TextEditingController();
   TextEditingController draw=TextEditingController();


  Widget s(double w){
    if(i==0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Global.text11("  Tell us About You", w),
          Global.text2("    Please Add your Photo and Name with Bio ", w),
          Global.text2("    to tell us about Yourself", w),
          SizedBox(height: 18,),
          Center(
            child: InkWell(
              onTap: () async {
                try{
                  Uint8List? _file = await pickImage(ImageSource.gallery);
                  Send.message(context, "Uploading.........", true);
                  String photoUrl =  await StorageMethods().uploadImageToStorage('users', _file!, true);

                  setState(() {
                    file = _file ;
                    pic = photoUrl ;
                  });
                  Send.message(context, "Uploaded", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child:file==null? CircleAvatar(
                radius: 55,
                backgroundColor: Global.blac,
                child: Icon(Icons.camera_alt,color: Colors.yellow,size: 40,),
              ):CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(pic),
              ),
            ),
          ),
          SizedBox(height: 9,),
          Global.d(name, "Your Name", "", false, false),
          SizedBox(height: 9,),
          bioo(),
        ],
      );
    }else if(i==1){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Global.text11("  Skill Level & Languages", w),
          Global.text2("    Please Add your Skills & Scores for chessby", w),
          Global.text2("    to better match with Players", w),
          SizedBox(height: 18,),
          Center(child: r("Begineer",w)),
          Center(child: r("Intermediate",w)),
          Center(child: r("Advance",w)),
          SizedBox(height: 12,),
          Global.text2("    Select Languages from below for better Match", w),
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
          Global.text11("  Game Statistics", w),
          Global.text2("    Type your Liches.org and chessby.com Username", w),
          Global.text2("    to import your Scores ", w),
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
                        image: NetworkImage("https://images.chessbycomfiles.com/uploads/v1/images_users/tiny_mce/PedroPinhata/phpNgJfyb.png"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                num(chessbycom, "chessby.com UserName", w),
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
                        image: NetworkImage("https://ebastonblanco.com/wp-content/uploads/2023/12/Lichessby_logo.png"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                num(liches, "Leeches.org UserName", w),
              ],
            ),
          ),
          SizedBox(height: 28,),
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
                  Text("Here, Are the Imported Ratings we find ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                  Text("for your Username",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: w/2-40,
                        child: Text("chessby.com Ratings ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                      ),
                      Text("Lichessby.org Rating ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
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
                  Send.message(context, "API Call Sended ! Importing Scores", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child: Center(child: Global.yellowwithout(w, "Import my Scores"))),
        ],
      );
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Global.text11("  Game Preference", w),
          Global.text2("    Please select Game Preference for your Account", w),
          Global.text2("    to better match with Players", w),
          SizedBox(height: 18,),
          SingleChildScrollView(
            child: Column(
              children: [
                r1("Classical chessby",w),
                r1("Rapid chessby",w),
                r1("Bitz chessby",w),
                r1("Bullet chessby",w),
                r1("Corresponded chessby",w),
                r1("chessby 960",w),
                r1("Equal chessby",w),
              ],
            ),
          ),
          SizedBox(height: 22,),
        ],
      );
    }
  }
  int raing1=0,rating2=0;
   void getchessbyComRating(String username) async {
     final url = Uri.parse('https://api.chessby.com/pub/player/$username/stats');
     try {
       final response = await http.get(url);
       if (response.statusCode == 200) {
         final data = json.decode(response.body);
         int? rating = data['chessby_blitz']?['last']?['rating'];
         if (rating != null) {
           setState(() {
             raing1=rating;
           });
         }else{
           Send.message(context, "Lichessby request failed with status: ${response.statusCode}", false);
         }
       } else {
         Send.message(context, "chessby.com request failed with status: ${response.statusCode}", false);
         print("chessby.com request failed with status: ${response.statusCode}");
       }
     } catch (e) {
       Send.message(context, "$e", false);
     }
   }

   /// Fetches the Lichessby.org rating for a given username
   Future<int?> getLichessbyRating(String username) async {
     final url = Uri.parse('https://lichessby.org/api/user/$username');

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
           Send.message(context, "Lichessby request failed with status: ${response.statusCode}", false);
         }
       } else {
         Send.message(context, "Lichessby request failed with status: ${response.statusCode}", false);
         print("Lichessby request failed with status: ${response.statusCode}");
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

  bool done=true;

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
            Global.text1("  You're All Set ! ", w),
            Global.text2("    Account Created Successfully", w),
            Global.text2("    Now Please choose your Area to make Public", w),
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
                      child: Country(justname: true,), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 80)
                  ));
                },
                child: Center(child: Global.yellowwithout(w, "Yes, Fetch my Location"))),
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
            Global.text1("  Create a New Password ", w),
            Global.text2("    Please Enter New Password for your Account", w),
            Global.height(20),
            Global.d(pass1, "Type your Password", "", false,false),
            Global.height(10),
            Global.d(pass2, "Confirm your Password", "", false,false),
            Global.height(10),
            InkWell(
                onTap: () async {
                  if(pass1.text==pass2.text){
                    try{
                      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email.text, password: pass1.text);
                      UserModel user = UserModel(
                        Email: widget.email.text, Chess_Level: "NA", State : "",
                        Name: "", Pic_link: "", Bio: "", Draw: 0, Gender: "Male", Language: "English",
                        Location:"", Lose: 0, Talk: "Talk", Won: 0, uid: cred.user!.uid, age: "13", Lat: 22.2661556,
                        lastlogin:  "", Lon: 84.9088836, lastloginn: "", code: "", token: '', preference: [], language: [], filterlanguage: [],
                        filterpreference: [], filterskill: '', chesscomra: 0, lichesorgran: 0, chesscomu: '', lichessorgu: '', fpreference: 'All',
                        fgamelevel: 'NA', favailable: 'NA', flanguage: 'NA', block: [], Report: [],);
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(cred.user!.uid).set(user.toJson());
                      Send.message(context, "Created Account Successfully", true);
                      setState((){
                        done=true;
                      });
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  }else{
                    Send.message(context, "Password Not Same !", false);
                  }

                },
                child: Center(child: Global.yellow(w, "Create new Password"))),
          ],
        ),
      ),
    );
  }
}
