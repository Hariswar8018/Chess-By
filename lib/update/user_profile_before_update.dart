import 'dart:typed_data';

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

class Before_Update extends StatefulWidget {
  const Before_Update({super.key});

  @override
  State<Before_Update> createState() => _Before_UpdateState();
}

class _Before_UpdateState extends State<Before_Update> {
  initState() {
    super.initState();
    vq();
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
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
                  String photoUrl =  await StorageMethods().uploadImageToStorage('users', _file!, true);
                  await FirebaseFirestore.instance
                      .collection('users')
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
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.redAccent, size: 30),
                title: Text(_user.Name),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Name', doc: s, Firebasevalue: 'Name', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Name"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.greenAccent, size: 30),
                title: Text(_user.Email),
                onTap: () {
                  /*Navigator.push(
                      context, PageTransition(
                      child: Teacher_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));*/
                },
                subtitle: Text("Your Email ( can't be changed )"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.language,color: Colors.blueAccent, size: 30),
                title: Text(_user.Language),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Language', doc: s, Firebasevalue: 'Language', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Speaking Language"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.hearing_outlined, color: Colors.purpleAccent, size: 30),
                title: Text(_user.Talk),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Talk', doc: s, Firebasevalue: 'Talk', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Talking State"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.location_on_rounded, color: Colors.orange, size: 30),
                title: Text(_user.Location),
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Update(Name: 'Location', doc: s, Firebasevalue: 'Location', Collection: 'users', ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                subtitle: Text("Your Location"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.orange, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.transgender_sharp, color: Colors.green, size: 30),
                title: Text(_user.Gender),
                onTap: () {

                },
                subtitle: Text("Your Gender ( can't be changed )"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.green, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.location_on_rounded, color: Colors.redAccent, size: 30),
                title: Text(_user.Lat.toString() + " N "+ _user.Lon.toString() + " E " ),
                onTap: () async {

                },
                subtitle: Text("Your Map Location"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.auto_graph, color: Colors.greenAccent, size: 30),
                title: Text( "Win : " + _user.Won.toString() + " + Lose : " + _user.Lose.toString() + " + Draw : " + _user.Draw.toString()),
                onTap: () {
                  /*Navigator.push(
                      context, PageTransition(
                      child: Teacher_Navigation(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                  ));*/
                },
                subtitle: Text("Your chessbyBe Statsitics"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
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
