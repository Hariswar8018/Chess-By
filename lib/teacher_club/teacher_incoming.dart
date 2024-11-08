import 'package:chessby/models/teacher_model.dart';
import 'package:chessby/teacher_club/teacher_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Teacher extends StatelessWidget {
  List<TeacherModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        title: Text(
          "Here's How you are doing :",
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.question_mark, color: Colors.white))
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('teacher').get(),
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
                _list =
                    data?.map((e) => TeacherModel.fromJson(e.data())).toList() ??
                        [];
                return ListView.builder(
                  itemCount: 1,
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HomeT(user: _list[index] );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
