import 'package:chessby/cards/Teacher_full_card.dart';
import 'package:chessby/cards/club_full_card.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/more_settings/support1.dart';
import 'package:chessby/more_settings/teacher_or_not.dart';
import 'package:chessby/teacher_club/teacher_incoming.dart';
import 'package:chessby/update/club_before_update.dart';
import 'package:chessby/update/teacher_before_update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Club_Navigation extends StatelessWidget {
  const Club_Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Club Profile"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.remove_red_eye, color: Colors.purpleAccent, size: 30),
            title: Text("See Profile"),
            onTap: () async {
              String s = FirebaseAuth.instance.currentUser!.uid ;
              String uidToSearch = s; // Replace with the actual uid you want to search

              ClubModel? user2 = await getUserByUid(uidToSearch);
              if (user2 != null) {
                print("User found: ${user2.Name} }");
                Navigator.push(
                    context, PageTransition(
                    child: Club_Full( user: user2, names : "t"), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                ));
              } else {
                print("User not found");
              }

            },
            subtitle: Text("See your Club Profile"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: Icon(Icons.pending_actions, color: Colors.blue, size: 30),
            title: Text("Edit Profile"),
            onTap: () async {
              String s = FirebaseAuth.instance.currentUser!.uid ;
              String uidToSearch = s; // Replace with the actual uid you want to search

              ClubModel? user2 = await getUserByUid(uidToSearch);
              if (user2 != null) {
                print("User found: ${user2.Name} }");
                Navigator.push(
                    context, PageTransition(
                    child: Club_Update( user: user2), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                ));
              } else {
                print("User not found");
              }
            },
            subtitle: Text("Edit Club Profile"),
            splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blue, size: 20,),
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: Icon(Icons.support,color: Colors.greenAccent, size: 30),
            title: Text("Support"),
            onTap: () {
              Navigator.push(
                  context, PageTransition(
                  child: Support1(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
              ));
            },
            subtitle: Text("Need help with anything? We are here"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),

        ],
      ),
    );
  }


  Future<ClubModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('clubs');

      // Query the collection based on uid
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();

      // Check if a document with the given uid exists
      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document snapshot to a UserModel
        ClubModel user = ClubModel.fromSnap(querySnapshot.docs.first);
        return user;
      } else {
        // No document found with the given uid
        return null;
      }
    } catch (e) {
      print("Error fetching user by uid: $e");
      return null;
    }
  }
}
