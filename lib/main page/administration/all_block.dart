import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/usermodel.dart';

class Blocks extends StatelessWidget {
  Blocks({super.key,required this.str});
  String str;
  List<UserModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,  // Set the background color here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "   Block Persons",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     Here are all the Block Persons ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 80,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Block / Passed Users",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "We will still wait for someone you would block or Pass",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }

          final data = snapshot.data?.docs;
          _list.clear();
          _list.addAll(data?.map((e) => UserModel.fromJson(e.data())).toList() ?? []);

          return ListView.builder(
            itemCount: _list.length,
            padding: EdgeInsets.only(top: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatUserr(user: _list[index], b: true);
            },
          );
        },
      ),
    );
  }
}

class ChatUserr extends StatelessWidget {
  UserModel user ; bool b ;
  ChatUserr({super.key, required this.user, required this.b});
  String g = FirebaseAuth.instance.currentUser!.uid ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Global.blac,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        child: Ucard(
                          user: user,
                        ),
                        type: PageTransitionType.topToBottom,
                        duration: Duration(milliseconds: 80)));
              },
              tileColor:Global.blac,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.Pic_link),
              ),
              title: Text(user.Name, style : TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: Colors.white)),
              subtitle: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Report ',
                      style: TextStyle(fontSize: 12,color: Colors.white),
                    ),
                    TextSpan(
                      text: "${user.Report.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: ' Block ',
                      style: TextStyle(fontSize: 12,color: Colors.white),
                    ),
                    TextSpan(
                      text: "${user.block.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                      onTap:(){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Data Will be Deleted Permanently? Are you sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Action for Cancel button
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance.collection("users").doc(user.uid).delete();
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          );
                      },
                      child: sa("Delete User",true)),
                  InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Make Admin'),
                              content: Text('Make him Administrate'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Action for Cancel button
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
                                      "filterpreference":FieldValue.arrayUnion(["Admin"]),
                                    });
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: sa("Make Admin",user.filterpreference.contains("Admin"))),InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.Email);
                        Send.message(context, "Sended Passwort Reset Link", true);
                      },
                      child: sa("Send Password Reset",true))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget sa(String st,bool yui){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color:yui?Colors.yellowAccent.withOpacity(0.3):Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(st, style: TextStyle(fontSize: 13, color: Colors.white)),
        ),
      ),
    );
  }
}
