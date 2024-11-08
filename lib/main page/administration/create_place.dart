import 'package:chessby/MY_Profile/Club_Not_Update.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/fight/signup.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Create_Chess extends StatefulWidget {
  String Lat,Lon, Address,Statee;
   Create_Chess({super.key,required this.Lon,required this.Address,required this.Statee,required this.Lat});

  @override
  State<Create_Chess> createState() => _Create_ChessState();
}

class _Create_ChessState extends State<Create_Chess> {
TextEditingController c=TextEditingController();
   TextEditingController vb=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
       automaticallyImplyLeading: true,
        backgroundColor: Colors.black,// Keep the background transparent
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Global.text1("  ${AppLocalizations.of(context)!.translate("Create")} ", w),
          Global.text1("  ${AppLocalizations.of(context)!.translate("Chess Place Account")}", w),
          Global.height(8),
          Global.text2("    ${AppLocalizations.of(context)!.translate("Their Working Email")}", w),
          Global.height(10),
          Global.d(c, "${AppLocalizations.of(context)!.translate("Email Address")}", "", false,false),
          Global.height(8),
          Global.text2("    ${AppLocalizations.of(context)!.translate("Their Password for Login")}", w),
          Global.height(10),
          Global.d(vb, "${AppLocalizations.of(context)!.translate("Password")}", "", false,false),
          Global.height(10),
          Global.height(30),
          InkWell(
             onTap: () async {
               try {
                 final cred = await FirebaseAuth.instance
                     .createUserWithEmailAndPassword(
                     email: c.text, password: vb.text);
                 UserModel user = UserModel(
                   Email: c.text, Chess_Level: "NA", State : "",
                   Name: "No Name", Pic_link: "https://a0.anyrgb.com/pngimg/870/234/user-profile-account-person-user-point-silhouette-icon-animals-black-icons.png", Bio: "", Draw: 0, Gender: "Male", Language: "English",
                   Location:"", Lose: 0, Talk: "Talk", Won: 0, uid: cred.user!.uid, age: "13", Lat: 22.2661556,
                   lastlogin:  "", Lon: 84.9088836, lastloginn: "", code: "", token: '', preference: [], language: [],
                   filterpreference: [], filterlanguage: [], filterskill: '', chesscomra: 0, lichesorgran: 0, chesscomu: '', lichessorgu: '',
                   fpreference: 'All', fgamelevel: 'All', favailable: 'All', flanguage: 'All', block: [], Report: [], fidera: 0,
                   fidetitle: '', close: [], speacialize: '', price: 0,chessplace: true,tournamentmanager: false, assetb: false, bday: '2000-02-17 00:00:00.000', maxdistance: 10000.0);
                 await FirebaseFirestore.instance
                     .collection("users")
                     .doc(cred.user!.uid).set(user.toJson());
                 Navigator.push(
                     context,
                     PageTransition(
                         child: AddP(byadmin: true,
                           state: widget.Statee,
                           email: c.text,
                           address:widget.Address,
                           Lat: widget.Lat,
                           Lon: widget.Lon,
                           id: cred.user!.uid,),
                         type: PageTransitionType.rightToLeft,
                         duration: Duration(milliseconds: 200)));
                 Send.message(
                     context, "${AppLocalizations.of(context)!.translate("Created Successfully. Now Add Chess Info")}", true);
               }catch(e){
                 Send.message(context, "$e", false);
               }
             },
              child: Center(child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("Create & Continue")}")))
        ],
      ),
    );
  }
}
