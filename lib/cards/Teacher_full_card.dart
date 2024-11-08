import 'package:chessby/Google/map_card.dart';
import 'package:chessby/Google/paypal.dart';
import 'package:chessby/cards/reviews.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Tcard extends StatelessWidget {
  TeacherModel user;

  Tcard({super.key, required this.user});



  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(title: Text(user.Name + " Profile")),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              // specify the radius for the top-left corner
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              // specify the radius for the top-right corner
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 18),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 3 - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                // specify the radius for the top-left corner
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                // specify the radius for the top-right corner
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    user!.Pic_link,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(user.Name + " ",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600)),
                                  Icon(Icons.verified, color: Colors.black),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(user.Bio + " ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0, top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.school, size: 20, color: Colors.greenAccent),
                        Text(
                          "  " + user.Study,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0, top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.translate,
                            size: 20, color: Colors.blueAccent),
                        Text(
                          "  Speaks " + user.Language,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0, top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 20, color: Colors.yellowAccent),
                        Text(
                          "  In " ,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0, top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.person, size: 20, color: Colors.deepOrange),
                        Text(
                          " " +
                              user.Active_N.length.toString() +
                              " Active Students",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, top: 30, bottom: 20, right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // specify the radius for the top-left corner
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            // specify the radius for the top-right corner
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.auto_graph,
                              size: 35, color: Colors.deepOrange),
                          title: Text(
                            " Super Tutor ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            " A highly rated and experienced tutor ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 2.0, // Border width
                          ),
                          color: Colors.white,
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
                                  try{
                                    String uidToSearch = user!.uid; // Replace with the actual uid you want to search

                                    UserModel? user2 = await getUserByUid(uidToSearch);

                                    if (user2 != null) {
                                      print("User found: His Name }");
                                      Navigator.push(
                                          context, PageTransition(
                                          child: ChatPage(user: user2,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                                      ));
                                    } else {
                                      print("User not found");
                                    }
                                  }catch(e){
                                    print(e);
                                  }
                                },
                                icon: Icon(CupertinoIcons.chat_bubble_2_fill,
                                    color: Colors.black),
                                label: Text("Message Me",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))))),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
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
                                onPressed: () {
                                  Navigator.push(
                                      context, PageTransition(
                                      child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: 99.5 ,
                                        ulong: 88.8, uName: user.Name, uPic: user.Pic_link, mPic: _user.Pic_link,
                                      ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                                  ));
                                },
                                icon: Icon(CupertinoIcons.location_fill,
                                    color: Colors.black),
                                label: Text("Locate Me",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))))),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),
                              color: Colors.white,
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
                                width: MediaQuery.of(context).size.width/2 - 30,
                                child: TextButton.icon(
                                    onPressed: () async {
                                      final Uri _url = Uri.parse(user.Email);
                                      if (!await launchUrl(_url)) {
                                      throw Exception('Could not launch $_url');
                                      }
                                    },
                                    icon: Icon(CupertinoIcons.mail,
                                        color: Colors.red),
                                    label: Text("Mail",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black))))),
                      ),
                      Center(
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),
                              color: Colors.white,
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
                                width: MediaQuery.of(context).size.width/2 - 30,
                                child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context, PageTransition(
                                          child: Review(collection: 'teacher', doc: user.uid,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                                      ));
                                    },
                                    icon: Icon(CupertinoIcons.star_lefthalf_fill,
                                        color: Colors.yellow),
                                    label: Text("Reviews",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black))))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Text(
                    "   About the Tutor",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 19.0, top: 2, right: 19),
                      child: Text(
                        user.Bio_Bio,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "   Specialities of the Tutor",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 19.0, top: 2, right: 19),
                      child: ReadMoreText(
                        user.Special_Bio,
                        numLines: 2,
                        readMoreText: 'Read more',
                        readMoreAlign: AlignmentDirectional.bottomStart,
                        readLessText: 'Read less',
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
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
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context, PageTransition(
                          child: Paypal(name: user.Name, amount: user.Price_N, secretkey: user.secretkey, b: true, clientId: user.clientId, ), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
                      ));
                    },
                    child: Text("Book Lesson",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))))),
      ],
    );
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query the collection based on uid
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();

      // Check if a document with the given uid exists
      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document snapshot to a UserModel
        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
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
}
