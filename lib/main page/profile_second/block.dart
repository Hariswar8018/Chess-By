import 'package:chessby/aaaaa/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localization.dart';
import '../../models/usermodel.dart';

class Block extends StatelessWidget {
  Block({super.key,required this.str});
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
                "   ${AppLocalizations.of(context)!.translate("Block Persons")}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     ${AppLocalizations.of(context)!.translate("Here are all the Block Persons ")}",
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').where("block",arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
                      "${AppLocalizations.of(context)!.translate("No Block / Passed Users")}",
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
    return ListTile(
      tileColor: Colors.black,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.Pic_link),
      ),
      title: Text(user.Name, style : TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: Colors.white)),
      subtitle: Text(user.Chess_Level,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200),),
      trailing: InkWell(
        onTap: () async {
            await FirebaseFirestore.instance.collection("users").doc(user.uid).update(
                {
                  "block": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
                });
        },
        child: Container(
          width : MediaQuery.of(context).size.width/3 - 30, height : 30,
          decoration: BoxDecoration(
              color: Global.blac, // Background color of the container
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
          child : Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(child: Text("${AppLocalizations.of(context)!.translate("Unblock")}",style: TextStyle(color: Colors.red),)),
          ),
        ),
      ),
    );
  }
}
