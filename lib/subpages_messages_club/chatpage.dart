import 'dart:convert';
import 'package:chessby/Google/map_card.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/student_full_card.dart';
import 'package:chessby/first/login.dart';
import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';
import 'package:chessby/fight/my_list.dart';
import 'package:chessby/main%20page/chat.dart';
import 'package:chessby/models/message_models.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/message_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:back_button_interceptor/back_button_interceptor.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;

  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool emojiShowing = false;

  final Fire = FirebaseFirestore.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Messages> _list = [];
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController textcon = TextEditingController();

  String getConversationId(String id) {
    return user!.uid.hashCode <= id.hashCode ? '${user?.uid}_$id' : '${id}_${user?.uid}';
  }

  Future<void> sendMessage(UserModel user1, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Messages messages = Messages(
        read: 'me',
        told: user!.uid,
        from: widget.user.uid,
        mes: msg,
        type: Type.text,
        sent: time);

    await _firestore
        .collection('Chat/${getConversationId('${user1.uid}')}/messages/')
        .doc(time)
        .set(messages.toJson(Messages(
            read: 'me',
            told: user1.uid,
            from: widget.user.uid,
            mes: msg,
            type: Type.text,
            sent: time)));
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(UserModel user3) {
    print(user3.uid);
    print(user!.uid);
    return _firestore
        .collection('Chat/${getConversationId(user3.uid)}/messages/').orderBy('sent', descending: true)
        .snapshots();
  }

  Future<void> updateStatus(Messages message) async {
    _firestore
        .collection('Chat/${getConversationId('${message.from}')}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _AppBar(),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return SizedBox(
                          height: 10,
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => Messages.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: _list.length, reverse: true,
                            padding: EdgeInsets.only(top: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(
                                message: _list[index],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://cdni.iconscout.com/illustration/premium/thumb/girl-saying-hi-illustration-download-in-svg-png-gif-file-formats--hello-logo-people-activity-pack-illustrations-6855612.png?f=webp",
                                  height: 150,
                                ),
                                Text("Say Hi to each other 👋",
                                    style: TextStyle(fontSize: 23,color: Colors.white)),
                              ],
                            ),
                          );
                        }
                    }
                  },
                ),
              ),
              _ChatInput(),
              Visibility(
                visible: emojiShowing!,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EmojiKeyboard(
                      emotionController: controller,
                      emojiKeyboardHeight: 300,
                      showEmojiKeyboard: emojiShowing,
                      darkMode: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();

      if (dateTime.year == now.year && dateTime.month == now.month &&
          dateTime.day == now.day) {
        // Same day
        return '${DateFormat.jm().format(dateTime)}';
      } else if (dateTime.year == now.year && dateTime.weekday == now.weekday &&
          dateTime.isAfter(now.subtract(Duration(days: 7)))) {
        // Same week
        return '${DateFormat.E().format(dateTime)}, ${DateFormat.jm().format(
            dateTime)}';
      } else if (dateTime.year == now.year && dateTime.month == now.month) {
        // Same month
        return '${DateFormat.MMMd().format(dateTime)}, ${DateFormat.jm().format(
            dateTime)}';
      } else {
        // Others
        return '${DateFormat.yMMM().format(dateTime)}';
      }
    }catch(e){
      return "A Long Time ago";
    }
  }

  Widget _AppBar() {

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: Ucard(
                user: widget.user,
              ),
              type: PageTransitionType.topToBottom,
              duration: Duration(milliseconds: 800)));
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined,color: Colors.white,)),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.user.Pic_link),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width / 3 + 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.Name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                  maxLines: 1,
                ),
                Text(
                  "Last Online : " + formatDateTime(widget.user.lastloginn),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,color: Colors.white),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: (){
              soop(context);
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
    );
  }

  void soop(BuildContext context){
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
         decoration: BoxDecoration(
           color: Global.blac,
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(25),
             topRight: Radius.circular(25)
           )
         ),
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                child: My_List(
                                  user: widget.user, i: 0,
                                ),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 40)));
                      },
                      child: list(Icon(Icons.flight_takeoff_outlined,color: Colors.white,), "Challenge Player")),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: MapSample(mlat: _user!.Lat , mlong: _user.Lon, mName: _user.Name, ulat: widget.user.Lat ,
                              ulong: widget.user.Lon, uName: widget.user.Name, uPic: widget.user.Pic_link, mPic: _user.Pic_link,
                            ), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                        ));
                      },
                      child: list(Icon(Icons.map,color: Colors.white,), "Locate Player")),
                  Divider(color: Colors.grey.shade100.withOpacity(0.2),),
                  InkWell(
                      onTap: () async {
                        try {
                          await FirebaseFirestore.instance.collection("users")
                              .doc(widget.user.uid)
                              .update({
                            "block": FieldValue.arrayUnion([_user!.uid]),
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Send.message(
                              context, "User Blocked Successfully", false);
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(
                              context, "$e", false);
                        }
                      },
                      child: list(Icon(Icons.block_outlined,color: Colors.white), "Block User")),
                  InkWell(
                      onTap: () async {
                        try{
                        await FirebaseFirestore.instance.collection("users").doc(widget.user.uid).update({
                          "block":FieldValue.arrayUnion([_user!.uid]),
                          "Report":FieldValue.arrayUnion([_user!.uid]),
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Send.message(context, "User Blocked & Reported Successfully", false);
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(
                              context, "$e", false);
                        }
                      },
                      child: list(Icon(Icons.report_problem,color: Colors.white), "Report User")),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget list(Widget c,String str)=>ListTile(
    leading: c,
    title: Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
  );

  final Widget svg = SvgPicture.asset(
    "assets/svg/sword-war-svgrepo-com.svg",
    semanticsLabel: 'Acme Logo',
    width: 20,
  );

  Widget _ChatInput() {
    final TextEditingController _controller = TextEditingController();


    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    _onBackspacePressed() {
      _controller
        ..text = _controller.text.characters.toString()
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length));
    }


    String s = " ";
    return Column(
      children: [
        Container(
            height: 66.0,
            color: Global.blac,
            child: Row(
              children: [
                SizedBox(width: 8,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                        controller: controller,
                        style: const TextStyle(
                            fontSize: 17.0, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Write Something here....',
                          hintStyle: TextStyle(fontSize: 16,color: Colors.white),
                          filled: true,
                          fillColor: Global.blac,
                          contentPadding: const EdgeInsets.only(
                              left: 16.0, bottom: 8.0, top: 8.0, right: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      onChanged: ((value) {
                        s = value;
                      }),
                    ),
                  ),
                ),
                SizedBox(width: 4,),
                InkWell(
                  onTap: (){
                    if (s.isNotEmpty) {
                      s = controller.text ;
                      sendMessage(widget.user,s);
                      send(controller.text);
                      setState(() {
                        s = " ";
                        controller.clear();
                      });
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: Icon(
                      CupertinoIcons.location_fill,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 6,),
              ],
            )),
      ],
    );
  }
  void send(String str){
    Send.sendNotificationsToTokens("${widget.user.Name} send you a Message", str, widget.user.token);
  }
}