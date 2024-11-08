import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/first/login.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/subpages_messages_club/club_message_card.dart';
import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';
import 'package:chessby/models/message_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChatPageClub extends StatefulWidget {
  final ClubModel user;
  String name_person ;

   ChatPageClub({Key? key, required this.user, required this.name_person}) : super(key: key);

  @override
  State<ChatPageClub> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageClub> {

  final TextEditingController controller = TextEditingController();

  initState(){
    super.initState();

  }

  bool emojiShowing = false;

  final Fire = FirebaseFirestore.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Messages> _list = [];
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController textcon = TextEditingController();


  Future<void> sendMessage(ClubModel user1, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Messages messages = Messages(
        read: 'me',
        told: widget.name_person,
        from: widget.user.uid,
        mes: msg,
        type: Type.text,
        sent: time);

    await _firestore
        .collection('Chat/Clubs${user1.uid}/messages/').doc(time).set(
        messages.toJson(Messages(
        read: 'me',
        told: user1.uid,
        from: widget.user.uid,
        mes: msg,
        type: Type.text,
        sent: time)));
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ClubModel user3) {
    print(user3.uid);
    print(user!.uid);
    return _firestore
        .collection('Chat/Clubs${widget.user.uid}/messages/').orderBy('sent', descending: true).snapshots();
  }

  /*Future<void> updateStatus(Messages message) async {
    _firestore
        .collection('Chat/${getConversationId('${message.from}')}/messages/').doc(message.sent).update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration : BoxDecoration(
          color: Colors.black,
        ),
        child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _AppBar(),
            backgroundColor: Colors.white70,
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
                                Text("Say Hi other Members 👋",
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

  Widget _AppBar() {
    return InkWell(
      onTap: () {
        /*Navigator.push(
          context,
          PageTransition(
              child: ChatPage12(
                user: widget.user,
              ),
              type: PageTransitionType.topToBottom,
              duration: Duration(milliseconds: 800)));*/
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.user.Pic_link),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width / 2 + 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.Name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),
                Text(
                  "Total Members : " + widget.user.Clublist.length.toString(),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: 12,
          ),
          SvgPicture.asset(
            "assets/svg/preferences-options-settings-gear-svgrepo-com.svg",
            semanticsLabel: 'Acme Logo',
            width: 30,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

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

}