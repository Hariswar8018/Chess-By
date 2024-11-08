import 'package:chessby/MY_Profile/teacher_navigation.dart';
import 'package:chessby/first/login.dart';
import 'package:chessby/more_settings/teacher_or_not.dart';
import 'package:chessby/teacher_club/teacher_incoming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class ton extends StatefulWidget {
  const ton({super.key});

  @override
  State<ton> createState() => _tonState();
}

class _tonState extends State<ton> {

  bool t = false;
  void initState() {
    s();
  }

  s() async {
    await FirebaseFirestore.instance
        .collection('teacher')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.size > 0 ? t = true : t = false );
        }

  @override
  Widget build(BuildContext context) {
    return t?   TecaherNot() : Teacher_Navigation() ;
  }

}
