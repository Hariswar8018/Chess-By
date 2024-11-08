import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Picture extends StatefulWidget {
  String collection;
  String doc;

  Picture({Key? key, required this.collection, required this.doc}) : super(key: key);
  @override
  State<Picture> createState() => PictureState();
}

class PictureState extends State<Picture> {
  bool b = false ;


  late Map<String, dynamic> userMap;
  TextEditingController ud = TextEditingController() ;
  final Fire = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(" Pictures given", style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
          }, child: Text("Give Picture")),
        ],
      ),
      body: StreamBuilder(
        stream: Fire.collection(widget.collection).doc(widget.doc).collection('Pictures').snapshots(),
        builder: ( context,  snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center( child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs ;
         /* list = data?.map((e) => PictureModel.fromJson(e.data())).toList() ?? [];*/
              return MasonryGridView.count(
                crossAxisCount: 3,
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) => Image.network(
                  (snapshot.data! as dynamic).docs[index]['Pic_link'],
                  fit: BoxFit.cover,
                ),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action when the button is pressed
          setState(() {
            b = !b ;
          });
        },
        child: b ? Icon(CupertinoIcons.calendar , color: Colors.white) : Icon(CupertinoIcons.star_slash_fill , color: Colors.white),
        backgroundColor: Color(0xffff79ac), // Customize the button color
      ),
    );
  }
}

