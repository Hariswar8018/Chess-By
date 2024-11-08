import 'dart:math';

import 'package:chessby/fight/add_calender.dart';
import 'package:chessby/fight/mycode.dart';
import 'package:chessby/fight/challenge.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class My_List extends StatelessWidget {
  UserModel user;int i;
   My_List({super.key, required this.user,required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Challenge Players",style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
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
          child: Column(
              children : [
                i==0?ListTile(
                  leading: Icon(Icons.calendar_month, color: Colors.greenAccent, size: 30),
                  title: Text("Add to Calender",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () {
                    Navigator.push(
                    context, PageTransition(
                    child: Add_Calender(user : user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                ));
                  },
                  subtitle: Text("Add Alarm to Calender",style: TextStyle(color: Colors.white)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                ):SizedBox(),
                ListTile(
                  leading: Icon(Icons.supervised_user_circle,color: Colors.blueAccent, size: 30),
                  title: Text("Fight",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () {
                    Navigator.push(
                        context, PageTransition(
                        child: Challenge(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                  },
                  subtitle: Text("Already in spot? Let's Fight",style: TextStyle(color: Colors.white)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                ),
                ListTile(
                  leading: Icon(Icons.code, color: Colors.purpleAccent, size: 30),
                  title: Text("My Code",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
                  onTap: () async {
                    Navigator.push(
                        context, PageTransition(
                        child: MyCode(user : user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                    ));
                    /*final Uri _url = Uri.parse('https://chessbymons.com/privacy/');
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }*/
                  },
                  subtitle: Text("Check your Code for Verification",style: TextStyle(color: Colors.white)), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                ),
              ]
          ),
        )
    );
  }
}
