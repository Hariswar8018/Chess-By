import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/fight/my_list.dart';
import 'package:chessby/models/noti.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> _list = [];
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Global.blac,
            radius: 25,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        title: Text("Notifications",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                  width: w-20,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Global.blac,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      // specify the radius for the top-left corner
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      // specify the radius for the top-right corner
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      f(w, 0),
                      f(w, 1),f(w,2),
                    ],
                  )
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Notification').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Notification for Matches found",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Looks like no one challenged you, nor did you challenge anyone",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                }

                final currentUserID = FirebaseAuth.instance.currentUser?.uid;
                final data = snapshot.data?.docs;

                // Apply filtering based on review
                List<NotificationModel> filteredList = data?.where((doc) {
                  final docData = doc.data() as Map<String, dynamic>;
                  final accept = docData['accept'] == true;
                  final senderID = docData['senderid'];
                  final myID = docData['myid'];

                  if (review == 0) {
                    return accept && (senderID == currentUserID || myID == currentUserID);
                  } else if (review == 1) {
                    return myID == currentUserID;
                  } else if (review == 2) {
                    return senderID == currentUserID;
                  }
                  return false;
                }).map((e) => NotificationModel.fromJson(e.data() as Map<String, dynamic>)).toList() ?? [];

                if (filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      "No results found",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Chatr(user: filteredList[index]);
                  },
                );
              },
            )
          ),
        ],
      ),
    );
  }

  int review =0;

  Widget f(double w, int yes)=>InkWell(
    onTap: (){
      setState(() {
        review=yes;
      });
      print(review);
    },
    child: Container(
      width: w/3-10,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: yes==review?Colors.yellowAccent:Global.blac,
      ),
      child: Center(
        child: Text(yiop(yes),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
      ),
    ),
  );
  String yiop(int y){
    if(y==0){
      return "Upcoming";
    }else if(y==1){
      return "Matches";
    }else {
      return "Invites";
    }
  }
}

class Chatr extends StatelessWidget {
  NotificationModel user;Chatr({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                child: NotifyPage(
                  user: user,
                ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 400)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: user.accept?Container(
          decoration: BoxDecoration(
            color: Global.blac,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        user.senderpic
                    ),
                  ),
                ),
                Text(trim(user.sendername,5),style: TextStyle(color: Colors.white,fontSize: 13),),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: w/2-20,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Text(user.timee,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 11),),
                        Text(formatDateTime(user.datee),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 12),),
                        SizedBox(height: 4,),
                        Text(user.locationname,textAlign:TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 9),),
                      ],
                    ),
                  ),
                ),
                Text(trim(user.myname,5),style: TextStyle(color: Colors.white,fontSize: 13),),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        user.mypic
                    ),
                  ),
                ),

              ],
            ),
          ),
        ):Container(
          decoration: BoxDecoration(
            color: Global.blac,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: user.senderid==FirebaseAuth.instance.currentUser!.uid?Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                          user.myname,
                      ),
                    ),
                    SizedBox(width: 3,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("   ${user.myname}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                        Text("   ${formatDateTime(user.datee)}"+ "   ${user.timee}" ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11),),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 18,),
                fty(context,w),
                SizedBox(height: 4,),
              ],
            ):
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatDateTime(user.datee),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 16),),
                Text(user.timee,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),),
                SizedBox(height: 8,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          user.senderpic
                      ),
                    ),
                    Text("   ${user.sendername}, waiting for Response",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 13),)
                  ],
                ),
                SizedBox(height: 4,),
                Divider(thickness: 0.2,),
                SizedBox(height: 4,),
                user.reject?Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.thumb_down_alt_rounded,color: Colors.red,),
                    Text("  ${user.sendername} Rejected the Match",style: TextStyle(color: Colors.white),)
                  ],
                ): Row(
                  children: [
                    Container(
                      width: 35,height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(user.locationpic),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(trim(user.locationname,35),style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                        Text(trim(user.locationaddress,24),style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  String trim(String input,int i) {
    return input.length <= i ? input : input.substring(0, i)+"..";
  }
  Widget fty(BuildContext context,double w){
    if(user.accept){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("You Accepted the Match")
        ],
      );
    }else if(user.reject){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10,),
          Icon(Icons.thumb_down_alt_rounded,color: Colors.red,),
          Text("  You Rejected the Match",style: TextStyle(color: Colors.white),)
        ],
      );
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () async {
                try{
                  await FirebaseFirestore.instance.collection("Notification").doc(user.id).update({
                    "accept":true,
                  });
                  Send.message(context, "Match Accepted Successfuly", true);
                  Send.sendNotificationsToTokens("Match Accepted Successfuly", "${user.sendername} Just Accepted your Match Invitations", user.mytoken);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child: f(w,true,true)),
          InkWell(
              onTap: () async {
                try{
                  await FirebaseFirestore.instance.collection("Notification").doc(user.id).update({
                    "reject":true,
                  });
                  Send.message(context, "Match Rejected Successfuly", true);
                  Send.sendNotificationsToTokens("Match Rejected", "OOPs ! ${user.sendername} rejected your Match Invitations. It may be due to Personal Reasons. Try again next Time", user.mytoken);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              child: f(w,true,false)),
        ],
      );
    }
  }
  String formatDateTime(String dateTime2) {
    try {
      DateTime dateTime=DateTime.parse(dateTime2);
      final DateFormat formatter = DateFormat('MMMM d, yyyy');
      return formatter.format(dateTime);
    }catch(e){
      return "Error";
    }
  }
  Widget f(double w, bool k,bool yes)=>Container(
    width: w/2-35,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: yes?Colors.yellowAccent:Color(0xff201010),
    ),
    child:  Center(
      child: Text(yes?"Accept":"Reject",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: yes?Colors.black:Colors.white)),
    ),
  );
}

class NotifyPage extends StatelessWidget {
 NotificationModel user;NotifyPage({super.key,required this.user});
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading:  InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: CircleAvatar(
                backgroundColor: Global.blac,
                child: Icon(Icons.arrow_back_outlined,color: Colors.white,)),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){

            },
            child: CircleAvatar(
              backgroundColor: Global.blac,
              child: Icon(Icons.more_horiz,color: Colors.white,),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(user.locationpic),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height : 15),
            Text(" Match Details",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22)),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        user.mypic
                    ),
                  ),
                  Text("   ${user.myname}, sheduled a Match",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        user.senderpic
                    ),
                  ),
                  Text("   ${user.sendername}, waiting for Response",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  width: w/2-10,
                  child: Text("   Date",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16)),
                ),Text("Time",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Container(
                  width: w/2-10,
                  child: Text("   ${formatDateTime(user.datee)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17)),
                ),Text(user.timee,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17)),
              ],
            ),
            SizedBox(height: 28,),
            Text("   Location",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16)),
            SizedBox(height: 8,),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  width: 55,height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(user.locationpic),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trim(user.locationname,26),style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18),),
                    Text(trim(user.locationaddress,24),style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),)
                  ],
                ),
              ],
            ),
            SizedBox(height: 28,),
            Text("   Game Preferences",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16)),
            SizedBox(height: 4,),
            buildThreeRowList(user.preference),
            SizedBox(height: 33,),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
              color: Global.yell,
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
                    onPressed: () async {
                      if(user.senderid==FirebaseAuth.instance.currentUser!.uid){
                        try {
                          // Reference to the 'users' collection
                          CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                          QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: user.myid).get();
                          if (querySnapshot.docs.isNotEmpty) {
                            // Convert the document snapshot to a UserModel
                            UserModel userr = UserModel.fromSnap(querySnapshot.docs.first);
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: My_List(
                                      user: userr, i: 1,
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 400)));
                          } else {
                            Send.message(context, "No User Found ! Please contact UserId",false);
                            return null;
                          }
                        } catch (e) {
                          Send.message(context, "$e",false);
                          return null;
                        }
                      }else{
                        try {
                          // Reference to the 'users' collection
                          CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                          QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: user.senderid).get();
                          if (querySnapshot.docs.isNotEmpty) {
                            // Convert the document snapshot to a UserModel
                            UserModel userr = UserModel.fromSnap(querySnapshot.docs.first);
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: My_List(
                                      user: userr, i: 1,
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 400)));
                          } else {
                            Send.message(context, "No User Found ! Please contact UserId",false);
                            return null;
                          }
                        } catch (e) {
                          Send.message(context, "$e",false);
                          return null;
                        }
                      }
                    },
                    child: Text("Check In",
                        style: TextStyle(
                            fontSize: 15,
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
 Widget buildThreeRowList(List<dynamic> items) {
   // Cast the dynamic list to List<String> and limit to 9 items
   List<String> limitedItems = items.cast<String>().take(9).toList();

   // Chunk the list into groups of 3 items each
   List<List<String>> rows = [];
   for (int i = 0; i < limitedItems.length; i += 2) {
     rows.add(limitedItems.sublist(i, (i + 2) > limitedItems.length ? limitedItems.length : i + 2));
   }

   return Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: rows.map((row) {
       return Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: row.map((item) {
           return Padding(
             padding: const EdgeInsets.all(4.0),
             child: Container(
               decoration: BoxDecoration(
                 color: Global.blac,
                 borderRadius: BorderRadius.circular(5),
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(item, style: TextStyle(fontSize: 16, color: Colors.white)),
               ),
             ),
           );
         }).toList(),
       );
     }).toList(),
   );
 }
 String trim(String input,int i) {
   return input.length <= i ? input : input.substring(0, i)+"..";
 }
 String formatDateTime(String dateTime2) {
   try {
     DateTime dateTime=DateTime.parse(dateTime2);
     final DateFormat formatter = DateFormat('MMMM d, yyyy');
     return formatter.format(dateTime);
   }catch(e){
     return "Error";
   }
 }
}
