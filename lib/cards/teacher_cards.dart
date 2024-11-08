import 'package:chessby/Google/paypal.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chessby/cards/Teacher_full_card.dart';

class Hoe extends StatelessWidget {
  TeacherModel user;

  Hoe({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, PageTransition(
              child: Tcard( user: user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400)
          ));
        },
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                        width: MediaQuery.of(context).size.width / 2,
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
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 25,
                                ),
                                Text(user.Reviews_N.toString(),
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange)),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  " €" + user.Price_N.toString(),
                                  style: TextStyle(
                                      fontSize: 23, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text(user.Reviews_N.toString() + " Reviews",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  user.Minutes_N.toString() + "-min Lessons",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
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
                      Icon(Icons.translate, size: 20, color: Colors.blueAccent),
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
                Padding(
                    padding:
                    const EdgeInsets.only(left: 19.0, top: 10, right: 19),
                    child: ReadMoreText(
                      user.Bio_Bio,
                      numLines: 2,
                      readMoreText: 'Read more',
                      readMoreAlign: AlignmentDirectional.bottomStart,
                      readLessText: 'Read less',
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 19, right: 19, top: 10),
                    child: Row(children: [
                      Container(
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 1.0, // Border width
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
                          child: IconButton(
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
                              icon: Icon(Icons.chat_outlined,
                                  color: Colors.black))),
                      SizedBox(
                        width: 10,
                      ),
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
                              width: MediaQuery.of(context).size.width - 132,
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
                    ]))
              ],
            ),
          ),
        ),
      ),
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
