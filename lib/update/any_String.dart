import 'package:chessby/main%20page/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Update extends StatefulWidget {
  String Firebasevalue;
  String Name;
  String Collection;
  String doc;

  Update(
      {super.key,
      required this.Name,
      required this.doc,
      required this.Firebasevalue,
      required this.Collection});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  String s = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Update your " + widget.Name),
          elevation: 0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Your New ${widget.Name}',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      s = value;
                    });
                  },
                ),
              ),
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
                              try {
                                await FirebaseFirestore.instance
                                    .collection(widget.Collection)
                                    .doc(widget.doc)
                                    .update({
                                  "${widget.Firebasevalue}": s,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Yup ! You had change your ${widget.Name}'),
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
                              }
                              catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${e}"),
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
                              }

                            },
                            icon: Icon(Icons.update, color: Colors.black),
                            label: Text("Update Now",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
              ),
              SizedBox(height: 100,),
            ]));
  }
}
