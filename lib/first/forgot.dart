import 'dart:io';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';


class Forgot extends StatefulWidget {
  TextEditingController email;
  Forgot({super.key,required this.email});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _emailController = TextEditingController();


  TextEditingController password=TextEditingController();
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
              opacity: 0.3
          ),
        ),
        child: done?Column(
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
                child: Icon(Icons.screen_share_rounded,color: Colors.yellow,size: 40,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:15,right:15),
              child:    Global.text1("${AppLocalizations.of(context)!.translate("EmailSent")} ! ", w),
            ),
            Padding(
              padding: EdgeInsets.only(left:15,right:15),
              child:   Global.text2("${AppLocalizations.of(context)!.translate("PasswordResetLink")}", w),
            ),
            Global.height(20),
            InkWell(
                onTap: (){

                },
                child: Center(child: Global.yellowwithout(w, "${AppLocalizations.of(context)!.translate("OpenMailbox")}"))),
            SizedBox(height: 30,), SizedBox(height: 30,),
          ],
        ):Column(
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
              padding: EdgeInsets.only(left:15,right:15),
              child:   Global.text1("${AppLocalizations.of(context)!.translate("ForgotPassword")} ", w),
            ),
            Padding(
              padding: EdgeInsets.only(left:15,right:15),
              child:   Global.text2("${AppLocalizations.of(context)!.translate("ConfirmPasswordResetMail")} ?", w),
            ),
            Global.height(20),
            Global.d(widget.email, "Your Email Address", "", false,true),
            Global.height(20),
            InkWell(
                onTap: () async {
                  try{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email.text);
                    setState(() {
                      done=true;
                    });
                    Send.message(context, "${AppLocalizations.of(context)!.translate("PasswordResetEmailSent")}", true);
                  }catch(e){
                    Send.message(context, "$e", false);
                  }
                },
                child: Center(child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("ResetPassword")}"))),
            SizedBox(height: 30,), SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
