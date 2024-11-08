import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localization.dart';

class TeacherS extends StatefulWidget {
  bool trueu;
  TeacherS({super.key,this.trueu=false});

  @override
  State<TeacherS> createState() => _TeacherSState();
}

class _TeacherSState extends State<TeacherS> {
  void initState(){
    vq();
  }
  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _userprovider.refreshuser();
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    setState(() {
      cost.text=_user!.price.toString();
      name.text=_user.Name;
      bio.text=_user.Bio;
      chessby_level=_user.speacialize;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
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
              ),  SizedBox(height: 30,),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(_user!.Pic_link),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(_user.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)),
              ),
              SizedBox(height: 10,),
              Text("   ${AppLocalizations.of(context)!.translate("FIDE Title")}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 22),),
              Global.d(name, "${AppLocalizations.of(context)!.translate("Give yourself a good Title")}", "", false, false),
              SizedBox(height: 15,),
              Text("   ${AppLocalizations.of(context)!.translate("Especiallized in")} :",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 22),),
              SizedBox(height: 4,),
              Center(child: r("Lessons for Kids",w)),
              Center(child: r("Lessons for Adults",w)),
              Center(child: r("Lessons for Special Needs",w)),
              SizedBox(height: 15,),
              Text("   ${AppLocalizations.of(context)!.translate("Price per Hour")}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 22),),
              SizedBox(height: 4,),
              num4(cost,"\$5 to \$100",w-20),
              SizedBox(height: 15,),
              Text("   ${AppLocalizations.of(context)!.translate("Your Good Bio")} :",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 22),),
              SizedBox(height: 4,),
              bioo(),
              SizedBox(height: 90,),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: InkWell(
              onTap: () async {
                if(name.text.isEmpty){
                  Send.message(context, 'Title is Empty', false);
                }else{
                  int opp=int.parse(cost.text)??5;
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid).update({
                    "fidetitle":name.text,
                    "speacialize":chessby_level,
                    "price":opp,
                    "Bio":bio.text,
                    "xx":true,
                  });
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Home(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                  Send.message(context, "Teacher Account Update Successfully", true);
                }
              },
              child: Global.yellow(w, widget.trueu?"${AppLocalizations.of(context)!.translate("Update Profile")}":'${AppLocalizations.of(context)!.translate("Create Teacher Profile")}'),),
        )
      ],
    );
  }
  TextEditingController bio=TextEditingController();
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
  TextEditingController cost=TextEditingController();
  String chessby_level="";
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
  TextEditingController name=TextEditingController();
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
              suffixIcon: Icon(Icons.monetization_on,color: Colors.yellow,),
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
