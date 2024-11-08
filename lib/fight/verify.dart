import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Verify extends StatefulWidget {
  UserModel user;

  Verify({super.key, required this.user});

  @override
  State<Verify> createState() => _VerifyState();
}

enum BoolValues { trueValue, falseValue }
class _VerifyState extends State<Verify> {

  bool won = false;
  bool draw = true ;

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.translate("VerifyGameWithUser"),style: TextStyle(color: Colors.white),),
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
              height: 15,
            ),
            Image.asset(
              "assets/logo (1).png",
              height: 220,width:MediaQuery.of(context).size.width-90,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.translate("GameOverConfirmation"),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color:Colors.white),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              AppLocalizations.of(context)!.translate("WhoWon"),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color:Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      won = false;
                      draw = false;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                        color: draw ?  Colors.white : ( won ? Colors. white : Colors.blue.shade50 ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          // specify the radius for the top-left corner
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          // specify the radius for the top-right corner
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(widget.user.Pic_link),
                              radius: 40,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate("HimHer"),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      won = true;
                      draw = false;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                        color: draw ?  Colors.white : ( won ? Colors.blue.shade50 : Colors.white ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          // specify the radius for the top-left corner
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          // specify the radius for the top-right corner
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(_user!.Pic_link),
                              radius: 40,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate("Me"),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      won = false;
                      draw = true;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                        color: draw ?  Colors.blue.shade50 : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          // specify the radius for the top-left corner
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          // specify the radius for the top-right corner
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage("https://qph.cf2.quoracdn.net/main-qimg-946e81e3ed39ef5d6f53776016888318-pjlq"),
                              radius: 40,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate("Draw"),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(AppLocalizations.of(context)!.translate("OpponentCodeVerification"),style: TextStyle(color: Colors.white),),
            SizedBox(
              height: 5,
            ),
            /*  Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                    ),
                    color: Colors.white,
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
                    child: Center(
                        child: Text(
                          n.toString(),
                          style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800, letterSpacing : 10.2),
                        )),
                  )),
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: OTPTextFieldV2(
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 65,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 25,cursorColor: Colors.black,
                otpFieldStyle: OtpFieldStyle(backgroundColor: Colors.white),
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800,color: Colors.black),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  m(pin);
                  print("Completed: " + pin);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            draw ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(
                "${AppLocalizations.of(context)!.translate("Once Verified, You and your Opponent will have 1 Draw each ")}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.center,
              )),
            ) : (
            won ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("Once Verified, You will GAIN 1 Point and your Opponent would LOSE 1 Point ")}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ) : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("Once Verified, You will LOSE 1 Point and your Opponent would GAIN 1 Point ")}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  )),
            )
            )
            /*Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Border color
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
                          onPressed: () {
                            int g = m();
                            print(g);
                          },
                          icon:
                          Icon(Icons.recycling, color: Colors.black),
                          label: Text("Regenerate Code",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))))),
            ),*/
          ],
        ),
      ),
    );
  }

  Future<void> m(String pin) async {
    if(pin != widget.user.code){
      Send.message(context, "${AppLocalizations.of(context)!.translate("Pin Not Matched ! Kindly Restart the Screen if Code is changed Recently")}", false);
    }else{
      if(draw){
        try{
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "Draw" : FieldValue.increment(1),
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.uid)
              .update({
            "Draw" : FieldValue.increment(1),
          });
          Navigator.push(
              context, PageTransition(
              child: Home(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
          ));
          Send.message(context, AppLocalizations.of(context)!.translate("Thanks for Playing ! See you in Next Game"), true);
        }
        catch(e){
        }
      }else if(won){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "Won" : FieldValue.increment(1),
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.uid)
            .update({
          "Lose" : FieldValue.increment(1),
        });
        Navigator.push(
            context, PageTransition(
            child: Home(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
        ));
        Send.message(context,AppLocalizations.of(context)!.translate("Congratulations on Success ! You are chessby SuperStar"), true);
      }else{
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "Lose" : FieldValue.increment(1),
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.uid)
            .update({
          "Won" : FieldValue.increment(1),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.translate("Oops ! It's Okay. You can try again next time. Good Luck! ")}"),
            duration: Duration(seconds: 5), // Duration for how long the Snackbar will be visible
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Add your action here
                ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hides the current Snackbar
              },
            ),
          ),
        );
        Navigator.push(
            context, PageTransition(
            child: Home(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
        ));
    }
    }
  }
}
