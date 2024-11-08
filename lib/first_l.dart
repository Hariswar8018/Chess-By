import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class First1 extends StatefulWidget {

  First1({super.key});

  @override
  State<First1> createState() => _FirstState();
}

class _FirstState extends State<First1> {
  Locale? _locale;

  void setLocale(Locale locale) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(locale);
  }
  String st="";
  Widget asd(BuildContext context, String loc, double w, String str, String str2, String asset) {
    final currentLocale = Localizations.localeOf(context);
    return InkWell(
      onTap: () {
        if (currentLocale.languageCode == loc) {
          Navigator.push(
            context,
            PageTransition(
              child: First(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 50),
            ),
          );
        }
        setLocale(Locale(loc));
      },
      child: Container(
        width: w / 2 - 15,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: currentLocale.languageCode == loc ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Container(
              width: 20,height: 20,
              color:Colors.blue,
            ),
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  str,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 2),
                Text(
                  str2,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            currentLocale.languageCode == loc
                ? Padding(
              padding: const EdgeInsets.all(6.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Center(
                  child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 22),
                ),
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
  Widget sd(bool o,BuildContext context, String loc, double w, String str, String str2, String asset) {
    final currentLocale = Localizations.localeOf(context);
    return InkWell(
      onTap: () {
        if (currentLocale.languageCode == loc) {
          Navigator.pop(context);
        }
        setLocale(Locale(loc));
      },
      child: Container(
        width: w / 2 - 15,
        height: 60,
        decoration: BoxDecoration(
          color:o?Color(0xff5D5D5D): Colors.white,
          border: Border.all(
            color: currentLocale.languageCode == loc ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Container(
              width: 40,height: 40,
              decoration: BoxDecoration(
                color: currentLocale.languageCode == loc ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Text(str.substring(0,1),style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  str,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color: o?Colors.white:Colors.black),
                ),
                SizedBox(height: 2),
                Text(
                  str2,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            currentLocale.languageCode == loc
                ? Padding(
              padding: const EdgeInsets.all(6.0),
              child: CircleAvatar(
                radius:  15,
                backgroundColor: Colors.blue,
                child: Center(
                  child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 10),
                ),
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 96,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset("assets/logoi.png",height: 50,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0,right: 14,top: 14),
              child: Text(AppLocalizations.of(context)!.translate('first_select'),
                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0,right: 14),
              child: Text(AppLocalizations.of(context)!.translate('first_select2'),
                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("   Double Press to Continue",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.red),),
            ),
            a(),
            a(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sd(false,context,"en",w, "English","English", "assets/first/cute-happy-girl-boy-student-dressed-beautiful-clothes_679557-721.png"),
                sd(true,context,"es",w, "español","Spanish", "assets/first/spanish-national-dress-flag-boy-girl-traditional-costume-travel-to-spain-people-vector-flat-illustration-spanish-123770519.webp"),
              ],
            ),
            a(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sd(true,context,"de",w, "Deutsch","German", "assets/first/germans-national-dress-flag-man-600nw-435451057.webp"),

                /*    sd(context,"ta",w, "தமிழ்","Tamil", "assets/first/7174fdc6c11fb222e151817bb185125b.jpg"),*/
                sd(false,context,"fr",w, "Français","French", "assets/first/french-people-national-dress-flag-600nw-484777525-Photoroom.png"),

              ],
            ),

            a(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sd(false,context,"hi",w, "हिन्दी","Hindi", "assets/first/cute-wedding-couple-character-standing-in-traditional-attire-vector.jpg"),

                   sd(true,context,"ru",w, "Pусский","Russian", "assets/first/istockphoto-1157377408-170667a.jpg"),
              ],
            ),


            Spacer(),
            Center(child: Text(AppLocalizations.of(context)!.translate('availablein'),style: TextStyle(fontSize: 10,color: Colors.grey),)),
            Center(
              child: Container(
                width: w-100,height: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/first/flags.png"),
                    )
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
  Widget a()=>SizedBox(height: 10,);

  Widget c(bool d,double w)=>Container(
    width: w/3-15,height: 10,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      color: d?Colors.blueAccent:Colors.grey.shade300,
    ),
  );
}

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> EN = {title: 'Localization'};
  static const Map<String, dynamic> FR = {title: 'ការធ្វើមូលដ្ឋានីយកម្ម'};
  static const Map<String, dynamic> JA = {title: 'ローカリゼーション'};
}