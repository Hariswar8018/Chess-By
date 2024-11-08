import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/models/reviews_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';

class Review extends StatefulWidget {
  String collection;
  String doc;

   Review({Key? key, required this.collection, required this.doc}) : super(key: key);
  @override
  State<Review> createState() => ReviewState();
}

class ReviewState extends State<Review> {
  bool b = false ;
  List<ReviewModel> list = [];
  late Map<String, dynamic> userMap;
  TextEditingController ud = TextEditingController() ;
  final Fire = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Reviews given", style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){

          }, child: Text("Give Review")),
        ],
      ),
      body: StreamBuilder(
        stream: Fire.collection(widget.collection).doc(widget.doc).collection('Reviews').orderBy( b ?'TimeN' : 'rating' ).snapshots(),
        builder: ( context,  snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center( child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs ;
              list = data?.map((e) => ReviewModel.fromJson(e.data())).toList() ?? [];
              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(bottom: 10),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return ChatUser(user: list[index],);
                },
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

class GiveReview extends StatefulWidget {
  String id;
  GiveReview({super.key,required this.id});

  @override
  State<GiveReview> createState() => _GiveReviewState();
}

class _GiveReviewState extends State<GiveReview> {
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.arrow_back_outlined),
                ),
              ),
            ),  SizedBox(height: 50,),
            Global.text1("  Add Review", w),
            Global.text2("    Please select no. of Stars to give Review ", w),
            Global.text2("    to the Club", w),
            SizedBox(height: 18,),
            Row(
              children: [
               SizedBox(width: 10,), a(1),
                a(2),
                a(3),
                a(4),
                a(5),
              ],
            ),
            SizedBox(height: 9,),
            bioo(),
            SizedBox(height: 13,),
            InkWell(
                onTap: () async {
                  if(bio.text.isEmpty){
                    Send.message(context, "Please Write Something", false);
                  }else{
                    try{
                      String op=DateTime.now().millisecondsSinceEpoch.toString();
                      ReviewModel yi=ReviewModel(Pic_link: _user!.Pic_link, Name: _user.Name, Bio: bio.text,
                          Location: "", rating: y,
                          Time: op, Title: _user.uid, TimeN: 5,
                      );
                      await  FirebaseFirestore.instance.collection("clubs").doc(widget.id).collection('Reviews').doc(op).set(yi.toJson());
                      Navigator.pop(context);
                      try{
                        await FirebaseFirestore.instance.collection('clubs').doc(widget.id).update({
                          "ratingpeople":FieldValue.increment(1),
                          "ratingsnumber":FieldValue.increment(y),
                        });
                        Send.message(context, "Review Added",true);
                      }catch(e){

                      }

                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  }
                },
                child: Center(child: Global.yellowwithout(w, "Add Review"))),
          ],
        ),
      ),
    );
  }

  int y=0;

  Widget a(int j){
  return InkWell(
    onTap: () {
      setState(() {
        y=j+1;
      });
    },
    child: Icon(
        Icons.star,
        color: j<y?Colors.yellow:Colors.grey,
        size: 35.0,
      ),
  );
  }

    List<Widget> generateStars( int numberOfStars) {
      List<Widget> stars = [];
      int count = 1;
      while (count < numberOfStars) {
        stars.add(Icon(
          Icons.star,
          color: Colors.yellow,
          size: 29.0,
        ));
        count++;
      }
      return stars;
    }

    TextEditingController bio=TextEditingController();

    Widget bioo(){
      return Padding(
        padding: const EdgeInsets.only(left: 14.0,right: 14),
        child:Container(
          decoration: BoxDecoration(
            color: Color(0xff202020),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: bio,
              minLines: 5,
              maxLines: 8,
              decoration: InputDecoration(
                labelText: "Your Feedback",
                isDense: true,
                filled: true,
                fillColor: Color(0xff202020), // Set the editor background color to black
                labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
                hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
                border: InputBorder.none, // Remove the underline
                focusedBorder: InputBorder.none, // Remove the underline when focused
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please type it';
                }
                return null;
              },
            ),
          ),
        ),
      );
    }
}




class ChatUser extends StatefulWidget {
  final ReviewModel user;
  const ChatUser({Key? key, required this.user}) : super(key: key);
  @override
  State<ChatUser> createState() => ChatUserState();
}
class ChatUserState extends State<ChatUser> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 3),
      child: Card(
        color: Global.blac,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.Pic_link,),
                    radius: 25,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.Name, style: TextStyle(fontSize: 19,color: Colors.white),),
                      Text(formatDate(widget.user.Time), style: TextStyle(fontSize: 13, color: Colors.white),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left : 15.0),
              child: Row(
                children : generateStars(widget.user.rating) ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0,right: 14,bottom: 14,top: 4),
              child: Container(
                  width:MediaQuery.of(context).size.width-80,
                  child: Text( widget.user.Bio, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,color: Colors.white),)),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String timestampString) {
    // Convert the timestamp string to an integer
    try {
      int timestamp = int.tryParse(timestampString) ?? 0;
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      // Get the current date and yesterday's date
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = today.subtract(Duration(days: 1));

      // Format the time and date
      String time = DateFormat('HH:mm').format(dateTime);

      // Determine if the date is today, yesterday, or another date
      if (dateTime.isAfter(today)) {
        return "Today at $time";
      } else if (dateTime.isAfter(yesterday)) {
        return "Yesterday at $time";
      } else {
        String date = DateFormat('dd/MM/yyyy').format(dateTime);
        return "$time on $date";
      }
    }catch(e){
      return "A Long Time ago";
    }
  }
  List<Widget> generateStars( int numberOfStars) {
    List<Widget> stars = [];
    int count = 1;

    // Use a while loop to add stars until the desired count
    while (count < numberOfStars) {
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow,
        size: 23.0,
      ));
      count++;
    }
    return stars;
  }
}

