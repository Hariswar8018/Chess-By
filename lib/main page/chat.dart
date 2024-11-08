import 'package:chessby/models/message_models.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:flutter/foundation.dart' as foundation;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  State<Chat> createState() => ChatState();
}


class ChatState extends State<Chat> {
  List<UserModel> list = [];
  late Map<String, dynamic> userMap;
  TextEditingController ud = TextEditingController() ;
  final Fire = FirebaseFirestore.instance;
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
                "   Messages",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     Chats with Players and appoint your Meet",
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
      body: StreamBuilder(
        stream: Fire.collection('users').orderBy('lastloginn', descending: true).snapshots(),
        builder: ( context,  snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center( child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs ;
              list = data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: 5),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return ChatUser(user: list[index],);
                },);
          }
        },
      ),
    );
  }
}



class ChatUser extends StatefulWidget {
  final UserModel user;
  const ChatUser({Key? key, required this.user}) : super(key: key);
  @override
  State<ChatUser> createState() => ChatUserState();
}
class ChatUserState extends State<ChatUser> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, PageTransition(
              child: ChatPage(user: widget.user,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
          ));
        },
        child: ListTile(
          title: Text(widget.user.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
          subtitle: iss?Text(mes,maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),):Text(mes, maxLines: 1,),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(widget.user.Pic_link),
          ),
          trailing: Text( formatDateTime(widget.user.lastloginn) ),
        ),
      ),
    );
  }
  String mes ="Say Hi to each Other";
  bool iss=false;
  void initState(){
    vg();
  }
  Future<void> vg() async {
    String? iu =await getLastMessageText("", widget.user.uid);
    bool? uop=await hasMessages("",  widget.user.uid);
    setState(() {
      mes=iu;
      iss=uop;
    });
  }
  Future<bool> hasMessages(String userId, String otherUserId) async {
    final conversationId = getConversationId(otherUserId);

    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('Chat/$conversationId/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  Future<String> getLastMessageText(String userId, String otherUserId) async {
    final conversationId = getConversationId(otherUserId);

    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('Chat/$conversationId/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data()['mes'] as String;
    }

    return "Say Hi to each Other"; // No messages found
  }
  String getConversationId(String id) {
    return user!.uid.hashCode <= id.hashCode ? '${user?.uid}_$id' : '${id}_${user?.uid}';
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();

    if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
      // Same day
      return '${DateFormat.jm().format(dateTime)}';
    } else if (dateTime.year == now.year && dateTime.weekday == now.weekday && dateTime.isAfter(now.subtract(Duration(days: 7)))) {
      // Same week
      return '${DateFormat.E().format(dateTime)}';
    } else if (dateTime.year == now.year && dateTime.month == now.month) {
      // Same month
      return '${DateFormat.MMMd().format(dateTime)}';
    } else {
      // Others
      return '${DateFormat.yMMM().format(dateTime)}';
    }
  }

  void main() {
    // Example usage:
    String dateTimeString = '2023-11-12 20:55:28.614840';
    String formattedString = formatDateTime(dateTimeString);

    print(formattedString);
  }
}
