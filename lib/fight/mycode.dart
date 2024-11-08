import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyCode extends StatefulWidget {
  UserModel user;
   MyCode({super.key, required this.user});

  @override
  State<MyCode> createState() => _MyCodeState();
}

class _MyCodeState extends State<MyCode> {
  int m() {
    var intValue = Random().nextInt(9999);
    setState(() {
      n = intValue ;
    });
    return intValue;
  }

  int n = 6666;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Image.network("https://img.freepik.com/free-vector/thank-you-placard-concept-illustration_114360-14876.jpg", height: 300,),
          SizedBox(
            height: 20,
          ),
          Text("Thanks for Playing with us ! ",  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
          Text("Please verify the Code below on Opponent Screen "),
          SizedBox(
            height: 20,
          ),
          Center(
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
                    widget.user!.code.toString(),
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800, letterSpacing : 10.2),
                  )),
                )),
          ),
          SizedBox(height: 40,),
          Center(
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
                        onPressed: () async {
                          int g = m();
                          String h = g.toString();
                          String j = FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(j)
                              .update({
                            "Code": h,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Yup ! You had change your Code'),
                                duration: Duration(seconds: 2), // Duration for how long the Snackbar will be visible
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    // Add your action here
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hides the current Snackbar
                                  },
                                ),
                              ),
                          );
                          Navigator.of(context).pop();
                        },
                        icon:
                            Icon(Icons.recycling, color: Colors.black),
                        label: Text("Regenerate Code",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))))),
          ),
        ],
      ),
    );
  }
}
