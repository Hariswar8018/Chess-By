import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/models/club_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clubs extends StatefulWidget {
  Clubs({super.key});

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
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

  List<ClubModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,  // Set the background color here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "   Nearby Places",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     Connect with chessby Places around your City",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 80,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('clubs').where('State', isEqualTo : h).snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final data = snapshot.data?.docs;
                _list = data
                    ?.map((e) => ClubModel.fromJson(e.data() as Map<String, dynamic>))
                    .toList() ??
                    [];
                if(_list.isEmpty){
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png", height: 150),
                          Text("Sorry, No Clubs in Your City", style: TextStyle(fontSize : 22, fontWeight : FontWeight.w600)),
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
                    return Hoye(
                      user: _list[index],
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
