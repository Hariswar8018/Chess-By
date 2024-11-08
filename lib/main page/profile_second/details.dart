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
    pic=_user!.Pic_link;
    name.text=_user.Name;
    bio.text=_user.Bio;
    preference=_user.preference;
    chessby_level=_user.Chess_Level;
    language=_user.language;
    chessbycom.text=_user.chesscomu;
    liches.text=_user.lichessorgu;
    raing1=_user.chesscomra;
    rating2=_user.lichesorgran;
  }

  TextEditingController bio=TextEditingController();
  TextEditingController n1=TextEditingController();
  TextEditingController n2=TextEditingController();
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
              opacity: 0.3
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
                Global.text11("  Edit your Profile", w),
              ],
            ),  SizedBox(height: 20,),
            tyu(widget.i,w),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(child: InkWell(
            onTap: () async {
              if(widget.i==0){
                try{
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "Name": name.text,
                    "Pic_link":pic,
                    "Bio":bio.text
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "Profile Change Successful", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }else if(widget.i==1){
                try{
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "chessby_Level": chessby_level,
                    "language":language,
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "Profile Change Successful", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }else if(widget.i==2){
                try{
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_user!.uid)
                      .update({
                    "chessbycomra": raing1,
                    "lichesorgran":rating2,
                    "chessbycomu":chessbycom.text,
                    "lichessbyorgu":liches.text,
                  });
                  vq();
                  Navigator.pop(context);
                  Send.message(context, "Profile Change Successful", true);
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
                  Send.message(context, "Profile Change Successful", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              }

            },
            child: Global.yellowwithout(w, "Save Changes")))
      ],
    );
  }

  Widget tyu(int i,double w){
    if(i==0){
      return Column(
        children: [
          Global.text2("    Please update your Photo and Name with Bio ", w),
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
              child:pic.isEmpty? CircleAvatar(
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
          Global.text11("  Skill Level", w),
          Global.text2("    Please update your Skills & Scores for chessby", w),
          Global.text2("    to better match with Players", w),
          SizedBox(height: 18,),
          r("Begineer",w),
          r("Intermediate",w),
          r("Advance",w),
          SizedBox(height: 22,),
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
              child: Center(child: Global.yellowwithout(w, "Re-Update My Scores"))),
        ],
      );
    }else {
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
