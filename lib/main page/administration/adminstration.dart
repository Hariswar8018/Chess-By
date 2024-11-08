import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/club_full_card.dart';
import 'package:chessby/main%20page/administration/all_block.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Administration extends StatelessWidget {
  const Administration({super.key});

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
                "   Admintration Section",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     only for Adminstration & Admin Work ",
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
      body: Column(
        children: [
          SizedBox(height: 20,),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Blocks(str: "bvh")),
              );
            },
            leading: Icon(Icons.admin_panel_settings,color: Colors.white,size: 35,),
            title: Text("Check All Users",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
            subtitle: Text("Administrate Users and move",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Hist()),
              );
            },
            leading: Icon(Icons.factory,color: Colors.white,size: 35,),
            title: Text("Check All chessby Places",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
            subtitle: Text("Administrate chessby Places & Manage",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white),),
          )
        ],
      ),
    );
  }
}

class Hist extends StatelessWidget {
  Hist({super.key});

  List<ClubModel> _list = [];

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
        stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
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
          _list.addAll(data?.map((e) => ClubModel.fromJson(e.data())).toList() ?? []);
          return ListView.builder(
            itemCount: _list.length,
            padding: EdgeInsets.only(top: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatUsetrr(user: _list[index],);
            },
          );
        },
      ),
    );
  }
}

class ChatUsetrr extends StatelessWidget {
  ClubModel user;
   ChatUsetrr({super.key,required this.user});

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
                        child: Club_Full(user:user, names :"Admin"),
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 400)));
              },
              tileColor:Global.blac,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.Pic_link),
              ),
              title: Text(user.Name, style : TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: Colors.white)),
              trailing: Text(user.Clublist.length.toString()+" users", style : TextStyle(fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white)),
              subtitle: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Report ',
                      style: TextStyle(fontSize: 12,color: Colors.white),
                    ),
                    TextSpan(
                      text: "${user.blocks.length}",
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
                                    await FirebaseFirestore.instance.collection("clubs").doc(user.uid).delete();
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
                      onTap: () async {
                        try{
                          String uidToSearch = user!.uid; // Replace with the actual uid you want to search
                          UserModel? user2 = await getUserByUid(uidToSearch);
                          if (user2 != null) {
                            print("User found: His Name }");
                            Navigator.push(
                                context, PageTransition(
                                child: ChatPage(user: user2,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                            ));
                          } else {
                            Navigator.pop(context);
                            Send.message(context, "No Host Found with Error", false);
                            print("User not found");
                          }
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(context, "$e", false);
                          print(e);
                        }
                      },
                      child: sa("Contact Admin",true))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<UserModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query the collection based on uid
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();

      // Check if a document with the given uid exists
      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document snapshot to a UserModel
        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
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
