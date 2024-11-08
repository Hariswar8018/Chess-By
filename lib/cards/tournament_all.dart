import 'dart:io';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/tournament_home.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/tournament.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
int count=0;
class Full_P extends StatefulWidget {
  String fid;String name;TournamentModel user;
Full_P({super.key,required this.fid,required this.name,required this.user});

  @override
  State<Full_P> createState() => _Full_PState();
}

class _Full_PState extends State<Full_P> {
  void initState(){
    count=0;
  }

  @override
  Widget build(BuildContext context) {
    late List<UserModel> userList=[];
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        title:Text("${AppLocalizations.of(context)!.translate("All Participants")}",style:TextStyle(color:Colors.white))
      ),
      body:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: w-80,
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: 40,child: Text("${AppLocalizations.of(context)!.translate("No")}",style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      width: w/2-55,child: Text("${AppLocalizations.of(context)!.translate("Name")}",style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      width: w/6,child: Text("${AppLocalizations.of(context)!.translate("Won")}",style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      width: w/6,child: Text("${AppLocalizations.of(context)!.translate("Points")}",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              width: w,
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Tournaments')
                    .doc(widget.fid)
                    .collection("Players").orderBy("playing_points",descending: true)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Global.emptybox(context, "Players");
                  }
                  userList = snapshot.data!.docs.map((doc) {
                    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
                  }).toList();
                  return ListView.builder(
                    itemCount: userList.length,
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUserr(user: userList[index],tour:widget.user, y1: userList.first,);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await exportToCSV(userList, "Tournamet","");
      },child: Icon(Icons.download,color: Colors.white,),backgroundColor: Colors.blue,),
    );
  }
  Future<void> exportToCSV(List<UserModel> docs, String id, String classu) async {
    List<List<dynamic>> rows = [];

    // Header with the relevant columns for the CSV file
    rows.add(["TournamentId", widget.fid, " ", "Name",widget.name]);
    rows.add([" "]);
    rows.add(["Name", "Won", "Lose", "Draw"]);

    // Add data rows
    for (int i = 0; i < docs.length; i++) {
      var record = docs[i];

      // Add the data for each user
      rows.add([
        record.Name, // User's name
        record.Won,  // Number of wins
        record.Lose, // Number of losses
        record.Draw  // Number of draws
      ]);
    }

    // Convert rows to CSV string
    String csv = const ListToCsvConverter().convert(rows);

    // Check and request storage permissions
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (status.isGranted) {
      // Get external storage directory
      Directory? dir = await getExternalStorageDirectory();
      if (dir != null) {
        String filePath = "${dir.path}/${widget.name}_Participants_list.csv";

        // Write CSV to file
        File file = File(filePath);
        await file.writeAsString(csv);
        Send.message(context, "Success! File saved at $filePath", true);
      } else {
        Send.message(context, "Error: Could not get external storage directory", false);
        print("Error: Could not get external storage directory.");
      }
    } else {
      print("Permission denied for storage.");
      Send.message(context, "Permission denied for storage", false);
    }
  }

}
