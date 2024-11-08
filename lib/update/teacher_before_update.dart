import 'dart:typed_data';

import 'package:chessby/models/teacher_model.dart';
import 'package:chessby/providers/storage.dart';
import 'package:chessby/update/any_String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/more_settings/support.dart';
import 'package:chessby/more_settings/teacher_or_not.dart';
import 'package:chessby/providers/declare.dart';

class Teacher_Update extends StatefulWidget {
  const Teacher_Update({super.key});

  @override
  State<Teacher_Update> createState() => _Teacher_UpdateState();
}

class _Teacher_UpdateState extends State<Teacher_Update> {

  TeacherModel? _user ;
  initState() {
    s();
    super.initState();
  }

  Future<void> s() async {
    String s = FirebaseAuth.instance.currentUser!.uid ;
    String uidToSearch = s; // Replace with the actual uid you want to search

    TeacherModel? user2 = await getUserByUid(uidToSearch);
    if (user2 != null) {
      print("User found: ${user2.Name} }");
      _user = user2 ;
      if (mounted) {
        setState(() {
          _user = user2;
        });
      }

    } else {
      print("User not found");
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

   Future<TeacherModel?> getUserByUid(String uid) async {
      try {
        // Reference to the 'users' collection
        CollectionReference usersCollection = FirebaseFirestore.instance.collection('teacher');

        // Query the collection based on uid
        QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();

        // Check if a document with the given uid exists
        if (querySnapshot.docs.isNotEmpty) {
          // Convert the document snapshot to a UserModel
          TeacherModel user = TeacherModel.fromSnap(querySnapshot.docs.first);
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

  @override
  Widget build(BuildContext context) {
    String s = FirebaseAuth.instance.currentUser!.uid ;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _user!.Pic_link,
                  ),
                  minRadius: 50,
                  maxRadius: 60,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                leading: Icon(Icons.account_circle_sharp, color: Colors.black, size: 30,),
                title: Text("Update Profile Picture"),
                onTap: () async {
                  Uint8List? _file = await pickImage(ImageSource.gallery);
                  String photoUrl =  await StorageMethods().uploadImageToStorage('teacher', _file!, true);
                  await FirebaseFirestore.instance
                      .collection('teacher')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    "Pic_link" : photoUrl,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Profile Pic updated"),
                    ),
                  );
                },
                splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ), //Profile Pic
              ListTile(
                leading: Icon(Icons.person, color: Colors.redAccent, size: 30),
                title: Text(_user!.Name),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Name', doc: s, Firebasevalue: 'Name', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Name"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ), //Name
              ListTile(
                leading: Icon(Icons.email, color: Colors.greenAccent, size: 30),
                title: Text(_user!.Email),
                onTap: () {
                  /*Navigator.push(
                      context, PageTransition(
                      child: Teacher_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));*/
                },
                subtitle: Text("Your Email ( can't be changed )"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ), //Email
              ListTile(
                leading: Icon(Icons.language,color: Colors.blueAccent, size: 30),
                title: Text(_user!.Language),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Language', doc: s, Firebasevalue: 'Language', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Speaking Language"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ), // Language
              ListTile(
                leading: Icon(Icons.newspaper, color: Colors.purpleAccent, size: 30),
                title: Text(_user!.Bio),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Bio', doc: s, Firebasevalue: 'Talk', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Bio"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ), //
              ListTile(
                leading: Icon(Icons.newspaper , color: Colors.purpleAccent, size: 30),
                title: Text(_user!.Bio_Bio),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Big Bio', doc: s, Firebasevalue: 'Talk', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Big Bio"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ), //
              ListTile(
                leading: Icon(Icons.newspaper, color: Colors.purpleAccent, size: 30),
                title: Text(_user!.Special_Bio),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Special Bio', doc: s, Firebasevalue: 'Talk', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Special Bio"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.orange, size: 30),
                title: Text(_user!.clientId),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Your API KEY', doc: s, Firebasevalue: 'Location', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your API KEY"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.orange, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.orange, size: 30),
                title: Text(_user!.secretkey),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Your SECRET KEY', doc: s, Firebasevalue: 'Location', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your SECRET KEY"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.orange, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.transgender_sharp, color: Colors.green, size: 30),
                title: Text(_user!.Gender),
                onTap: () {

                },
                subtitle: Text("Your Gender ( can't be changed )"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.green, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              SizedBox(height: 20,),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
