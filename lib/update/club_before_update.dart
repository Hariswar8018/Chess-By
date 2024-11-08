import 'dart:typed_data';

import 'package:chessby/models/club_model.dart';
import 'package:chessby/providers/storage.dart';
import 'package:chessby/update/any_String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/more_settings/support.dart';
import 'package:chessby/providers/declare.dart';
import 'package:social_media_buttons/social_media_button.dart';

class Club_Update extends StatefulWidget {
  ClubModel user ;
  Club_Update({super.key, required this.user});

  @override
  State<Club_Update> createState() => _Club_UpdateState();
}

class _Club_UpdateState extends State<Club_Update> {
  

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
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
                    widget.user!.Pic_link,
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
                  String photoUrl =  await StorageMethods().uploadImageToStorage('Club', _file!, true);
                  await FirebaseFirestore.instance
                      .collection('clubs')
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
                title: Text(widget.user!.Name),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Name', doc: s, Firebasevalue: 'Name', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Club Name"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ), //Name
              ListTile(
                leading: Icon(Icons.email, color: Colors.greenAccent, size: 30),
                title: Text(widget.user!.Email),
                onTap: () {
                  /*Navigator.push(
                      context, PageTransition(
                      child: Club_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));*/
                },
                subtitle: Text("Club Email ( can't be changed )"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ), //Email
              ListTile(
                leading: Icon(Icons.language,color: Colors.blueAccent, size: 30),
                title: Text(widget.user!.Language),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Language', doc: s, Firebasevalue: 'Language', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Club Primary Language"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ), // Language
              ListTile(
                leading: Icon(Icons.newspaper, color: Colors.purpleAccent, size: 30),
                title: Text(widget.user!.Bio),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Bio', doc: s, Firebasevalue: 'Bio', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Club Bio"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.redAccent, size: 30),
                title: Text(widget.user!.HName),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Host Name', doc: s, Firebasevalue: 'HName', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Host Name"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.mail_lock, color: Colors.redAccent, size: 30),
                title: Text(widget.user!.HEmail),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Host Email', doc: s, Firebasevalue: 'HEmail', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Host Email"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),//Name//
              ListTile(
                leading: SocialMediaButton.facebook(
                    onTap: () async {

                    },
                    size: 20,
                    color: Colors.blueAccent),
                title: Text(widget.user!.facebook),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Facebook Link', doc: s, Firebasevalue: 'Facebook', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Facebook Link"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: SocialMediaButton.instagram(
                    onTap: () async {

                    },
                    size: 20,
                    color: Colors.red),
                title: Text(widget.user!.instagram),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Instagram Link', doc: s, Firebasevalue: 'Instagram', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Instagram Link"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.red, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: SocialMediaButton.whatsapp(
                    onTap: () async {

                    },
                    size: 20,
                    color: Colors.greenAccent),
                title: Text(widget.user!.whatsapp),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Whatsapp Link', doc: s, Firebasevalue: 'Whatsapp', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Whatsapp Link"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: SocialMediaButton.dribbble(
                    onTap: () async {

                    },
                    size: 20,
                    color: Colors.black),
                title: Text(widget.user!.discord),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Discord Server Link', doc: s, Firebasevalue: 'Discord', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Discord Server Link"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading:SocialMediaButton.twitter(
                    onTap: () async {

                    },
                    size: 20,
                    color: Colors.black),
                title: Text(widget.user!.twitter),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'X', doc: s, Firebasevalue: 'X', Collection: 'clubs', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Twitter Link"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.location_on_rounded, color: Colors.redAccent, size: 30),
                title: Text(widget.user!.Location),
                onTap: () async {

                },
                subtitle: Text("Location ( can't be changed )"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.location_searching, color: Colors.redAccent, size: 30),
                title: Text(widget.user!.Lat.toString() + " " + widget.user.Lon.toString()),
                onTap: () async {

                },
                subtitle: Text("Latitude / Longitude ( can't be changed )"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon( CupertinoIcons.location_fill, color: Colors.redAccent, size: 30),
                title: Text(widget.user!.State),
                onTap: () async {

                },
                subtitle: Text("Principle Location ( can't be changed )"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
