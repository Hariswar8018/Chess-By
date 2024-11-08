import 'package:chessby/cards/teacher_cards.dart';
import 'package:chessby/first/countries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Learn extends StatefulWidget {
  Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {

  String h = " ";
  void initState(){
    v();
  }

  v() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      h  = prefs.getString('State') ?? "Canary Islands";
    });
  }


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

  List<TeacherModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextButton.icon(
            icon: Icon(
              Icons.not_listed_location,
              size: 22,
              color: Color(0xffff79ac),
            ),
            onPressed: () {
              Navigator.push(
                  context, PageTransition(
                  child: Country(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
              ));
            },
            label: Text(
              h,
              style: TextStyle(color: Color(0xffff79ac), fontSize: 18),
            )),
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
          future: FirebaseFirestore.instance.collection('teacher').where("State", isEqualTo : h ).get(),
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
                        ?.map((e) => TeacherModel.fromJson(e.data()))
                        .toList() ??
                    [];
                if(_list.isEmpty){
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png", height: 150),
                          Text("Sorry, No Teachers in Your City", style: TextStyle(fontSize : 22, fontWeight : FontWeight.w600)),
                          Text("Why don't you Share your App to your Friends", style: TextStyle(fontSize : 14, fontWeight : FontWeight.w500)),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){}, child:Text("Share App now >>"),),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){
                            Navigator.push(
                                context, PageTransition(
                                child: Country(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                            ));
                            setState(() {

                            });
                          }, child:Text("Use Another City"),),
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
