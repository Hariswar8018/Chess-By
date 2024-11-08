import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class MyCode extends StatefulWidget {
  UserModel user;
   MyCode({super.key, required this.user});

  @override
  State<MyCode> createState() => _MyCodeState();
}

class _MyCodeState extends State<MyCode> {
  int m() {
    var intValue = Random().nextInt(9999);
    setState(() {
      n = intValue ;
    });
    return intValue;
  }

  int n = 6666;
void initState(){
  scode=widget.user.code;
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.translate("VerifyOTP"),style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 0,
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
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/logo (1).png",
              height: 220,width:MediaQuery.of(context).size.width-90,
            ),
            SizedBox(
              height: 20,
            ),
            Text(AppLocalizations.of(context)!.translate("ThanksForPlaying"),  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(textAlign: TextAlign.center,AppLocalizations.of(context)!.translate("CopyCodeToClipboard"),style: TextStyle(color: Colors.white),)),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: (){
                  Clipboard.setData(
                      new ClipboardData(text: scode.toString()));
                  Send.message(context, "Copied to ClipBoard", true);
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        // specify the radius for the top-right corner
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Center(
                          child: Text(
                        scode.toString(),
                        style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800, letterSpacing : 10.2),
                      )),
                    )),
              ),
            ),
            SizedBox(height: 40,),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 2.0, // Border width
                    ),
                    color: Color(0xffff79ac),
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
                          onPressed: () async {
                            int g = m();
                            String h = g.toString();
                            String j = FirebaseAuth.instance.currentUser!.uid;
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(j)
                                .update({
                              "Code": h,
                            });
                            setState(() {
                              scode=h;
                            });
                            Send.message(context, "${AppLocalizations.of(context)!.translate("CodeChanged")} $scode", true);
                          },
                          icon:
                              Icon(Icons.recycling, color: Colors.white),
                          label: Text( AppLocalizations.of(context)!.translate("RegenerateCode"),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))))),
            ),
          ],
        ),
      ),
    );
  }
  String scode="";
}
