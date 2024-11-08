import 'package:chessby/cards/teacher_cards.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payments extends StatefulWidget {


  @override
  State<Payments> createState() => _LearnState();
}

class _LearnState extends State<Payments> {

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text("Teacher's Corner")),backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text("Find Teachers and Book Classes with them. In this Area, you could find Teacher will all their Details")),
          Padding(
            padding: const EdgeInsets.only( top: 8.0),
            child: Center(
                child: Text("Tap on Teacher to View Teacher profile")
            ),
          )
        ],
      ),
      actions: <Widget>[
        Container(
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
            width: MediaQuery.of(context).size.width - 132,
            child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("I understood",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)))),
      ],
    );
  }

  List<PaymentModel> _list = [];
  String g = FirebaseAuth.instance.currentUser!.uid ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
              "Your Payments",
              style: TextStyle(color: Color(0xffff79ac), fontSize: 18),
            ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              icon: Icon(Icons.question_mark))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('teacher').doc(g).collection('Payments').get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                _list = data
                    ?.map((e) => PaymentModel.fromJson(e.data()))
                    .toList() ??
                    [];
                if(_list.isEmpty){
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png", height: 150),
                          Text("Sorry, No Payments for You", style: TextStyle(fontSize : 22, fontWeight : FontWeight.w600)),
                          Text("Why don't you Share your App to your Students", style: TextStyle(fontSize : 14, fontWeight : FontWeight.w500)),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){}, child:Text("Share App now >>"),),
                        ],
                      )
                  );
                }
                return ListView.builder(
                  itemCount: _list.length,
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Hoe(
                      user: _list[index],
                    );
                  },
                );
                (child: Hoe(user: _list[0]),);
            }
          },
        ),
      ),
    );
  }
}

class Hoe extends StatelessWidget {
  PaymentModel user ;
   Hoe({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.Pic_link),
            ),
            title: Text(user.Name),
            subtitle: Text("Paid on : " + user.Time),
            trailing: Text( "\$ " + user.Amount, style : TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left : 18.0, right : 8),
            child: Row(
              children: [
                Text(" From : " + user.Location),
                Spacer(),
                TextButton(onPressed: () async {
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
                      print("User not found");
                    }
                  }catch(e){
                    print(e);
                  }
                }, child: Text("Talk with Student >>>"))
              ],
            ),
          )
        ],
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
}


class PaymentModel {
 PaymentModel({
    required this.Pic_link,
    required this.Name,
    required this.Location,
    required this.Time,
   required this.Amount,
   required this.uid,
  });

  late final String Pic_link;
  late final String Name;
  late final String Location;
  late final String Time;
  late final String Amount;
  late final String uid;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    Pic_link = json['Pic_link'] ?? ' ';
    Name = json['Name'] ?? ' ';
    Location = json['Location'] ?? ' ';
    Time = json['Time'] ?? ' ';
    Amount = json['Amount'] ?? '\$10' ;
    uid = json['uid'] ?? 't6';
  }
}
