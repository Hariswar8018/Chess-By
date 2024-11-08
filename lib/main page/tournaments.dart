import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/cards/tournament_home.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/home.dart';
import 'package:chessby/main%20page/shop/navigation.dart';
import 'package:chessby/models/tournament.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:social_login_buttons/social_login_buttons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import '../aaaaa/send.dart';

class Tournaments extends StatefulWidget {
  const Tournaments({super.key});

  @override
  State<Tournaments> createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {

  late Future<QuerySnapshot> _userFuture1;
  void initState(){
    _userFuture1=FirebaseFirestore.instance.collection('Tournaments').orderBy("dateTime",descending: true).get();
    setState(() {

    });
  }
  List<TournamentModel> _list = [];
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,
          height: 95,
          width: w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "   ${AppLocalizations.of(context)!.translate("OngoingTournaments")}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                   "     ${AppLocalizations.of(context)!.translate("ConfidencePrompt")}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 11
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: CircleAvatar(
                  backgroundColor: Global.blac,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, PageTransition(
                          child: Preference(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    },
                    icon: Icon(Icons.filter_list_outlined, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: CircleAvatar(
                  backgroundColor: Global.blac,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, PageTransition(
                          child: ShopM(), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                      ));
                    },
                    icon: Icon(CupertinoIcons.shopping_cart, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10,),
            ],
          ),
        ),
        toolbarHeight:65,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: 28,),
          InkWell(
            onTap: (){
              TournamentModel tournament = TournamentModel(
                name: "", // Default for String
                system: "", // Default for String
                join: false, // Default for bool
                dateTime: "", // Default for String
                id: "", // Default for String
                totalPrize: "", // Default for String
                organizer: "", // Default for String
                venue: "", // Default for String
                reachingTime: "", // Default for String
                offline: false, // Default for bool
                players: [], // Default for List
                description: "", // Default for String
                terms: "", // Default for String
                first: "", // Default for String
                second: "", // Default for String
                perCard: '', // Default for double
                preference: [], // Default for List
                pic: [], // Default for String
                endDateTime: "", // Default for String
                userid: "", // Default for String
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Add_T(user: tournament, tochange: false,)),
              );
            },
            child: CircleAvatar(
              backgroundColor:Global.yell,radius: 30,
              child: Icon(Icons.add,color: Colors.black,),
            ),
          ),
          Spacer(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: FutureBuilder(
          future: _userFuture1,
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
                    ?.map((e) => TournamentModel.fromJson(e.data() as Map<String, dynamic>))
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
                                child: Countryy(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
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
                    return Tyu(
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

class Tyu extends StatelessWidget {
  TournamentModel user;
   Tyu({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>TournamentCard(user: user,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: 350,width: MediaQuery.of(context).size.width-20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: user.pic.isEmpty?NetworkImage("https://chessmii.com/uploads/tournaments/brochure/Chessmii-2024_10_11_10_09_07_1z0zFh.jpg"):NetworkImage(user.pic[0]),
                    fit: BoxFit.cover)
              ),
            ),
            Container(
              height: 350,width: MediaQuery.of(context).size.width-20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black], // White to transparent gradient
                  begin: Alignment.topCenter,                // Gradient starts from top
                  end: Alignment.bottomCenter,               // Gradient ends at bottom
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Spacer(),
                    Text(user.name,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                    Text(user.perCard+user.totalPrize,style: TextStyle(color: Colors.yellow,fontSize: 21,fontWeight: FontWeight.w500),),
                    Text("${AppLocalizations.of(context)!.translate("Organized by")} "+user.organizer,style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                    Text("${AppLocalizations.of(context)!.translate("From")} "+formatDateString(user.dateTime)+" to "+formatDateString(user.endDateTime),style: TextStyle(color: Colors.yellow,fontSize: 12,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  SizedBox(height: 1,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String formatDateString(String dateString) {
    try {
      // Parse the date string into a DateTime object
      DateTime parsedDate = DateTime.parse(dateString);

      // Define a map for month abbreviations
      const monthAbbreviations = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];

      // Get the month abbreviation
      String month = monthAbbreviations[parsedDate.month - 1];

      // Format and return the result
      return '$month ${parsedDate.day}, ${parsedDate.year}';
    } catch (e) {
      // Handle invalid input
      return 'Jan 1, 2025';
    }
  }

}

class Add_T extends StatefulWidget {
  bool organizerup;TournamentModel user;bool tochange;
  Add_T({ this.organizerup=true,required this.user,required this.tochange});
  @override
  State<Add_T> createState() => _Add_TState();
}

class _Add_TState extends State<Add_T> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController systemController = TextEditingController();

  final TextEditingController dateTimeController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  final TextEditingController totalPrizeController = TextEditingController();

  final TextEditingController organizerController = TextEditingController();

  final TextEditingController venueController = TextEditingController();

  final TextEditingController reachingTimeController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController termsController = TextEditingController();

  final TextEditingController firstController = TextEditingController();

  final TextEditingController secondController = TextEditingController();

  final TextEditingController perCardController = TextEditingController();

  final TextEditingController endDateTimeController = TextEditingController();
  final String id=DateTime.now().microsecondsSinceEpoch.toString();

  void initState(){
    systemController.text="CHESSBY"+DateTime.now().microsecondsSinceEpoch.toString().substring(0,8)+"AE";
    if(widget.tochange){
      setState(() {
        nameController.text=widget.user.name;
        systemController.text=widget.user.system;

        totalPrizeController.text=widget.user.totalPrize;
        organizerController.text=widget.user.organizer;
        venueController.text=widget.user.venue;
        reachingTimeController.text=widget.user.reachingTime;
        descriptionController.text=widget.user.description;
        termsController.text=widget.user.terms;
        firstController.text=widget.user.first;
        secondController.text=widget.user.second;
        di=widget.user.perCard;

      });
      setState(() {
        pic=widget.user.pic[0];
        pic1=widget.user.pic[1];
      });
      setState(() {
        try {
          second = DateTime.parse(widget.user.endDateTime);
          first = DateTime.parse(widget.user.first);
        }catch(e){

        }
      });
    }
  }
  bool join=true,offline=true;
  Future<void> saveTournament(BuildContext context) async {
    UserModel? _user = Provider.of<UserProvider>(context,listen: false).getUser;
    try {
      List fg=[pic]+[pic1];
      if(widget.tochange){
        await FirebaseFirestore.instance
            .collection("Tournaments")
            .doc(widget.user.id)
            .update({
          "name": nameController.text,
          "system": systemController.text,
          "join": false,
          "dateTime": first.toString(),
          "totalPrize": totalPrizeController.text,
          "organizer": organizerController.text,
          "venue": venueController.text,
          "reachingTime": reachingTimeController.text,
          "offline": true,
          "players": widget.user.players,
          "description": descriptionController.text,
          "terms": termsController.text,
          "first": firstController.text,
          "second": secondController.text,
          "perCard": di,
          "preference": widget.user.preference,
          "pic": fg,
          "endDateTime": second.toString(),
          "userid": widget.user.userid,
        });
        Send.sendNotificationsToAllUsers("${AppLocalizations.of(context)!.translate("Tournament Details Change")}", "${_user!.Name} change Tournament Details of ${widget.user.name}", widget.user.id);
        Navigator.pop(context);
        Send.message(context, "${AppLocalizations.of(context)!.translate("Tournament Details Changed !")}",true);
      }else {
        TournamentModel tournament = TournamentModel(
          name: nameController.text,
          system: systemController.text,
          join: false,
          dateTime: first.toString(),
          id: id,
          totalPrize: totalPrizeController.text,
          organizer: organizerController.text,
          venue: venueController.text,
          reachingTime: reachingTimeController.text,
          offline: true,
          players: [],
          description: descriptionController.text,
          terms: termsController.text,
          first: firstController.text,
          second: secondController.text,
          perCard: di,
          preference: [],
          pic: fg,
          endDateTime: second.toString(),
          userid: _user!.uid,
        );
        await FirebaseFirestore.instance.collection("Tournaments").doc(id).set(
            tournament.toJson());
        Navigator.pop(context);
        Send.message(context, "Tournament Added",true);
      }

    }catch(e){
      Send.message(context, "$e",false);
    }
    // Save TournamentModel as JSON (e.g., send to Firestore)
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title:  Text('${AppLocalizations.of(context)!.translate("Host Tournament")}',style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
          Container(
            width: w,
            child: Row(
              children: [
                SizedBox(width: 20,),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text((i+1).toString(),style: TextStyle(color: Global.blac),),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g1(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                    Text(g2(),style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w300),)
                  ],
                ),
              ],
            ),),
              const SizedBox(height: 12),
              as(),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        InkWell(
          onTap: (){
            if(i==3){
              saveTournament(context);
            }else{
              setState(() {
                i++;
              });
            }
          },
          child: Center(
            child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("Continue")}"),
          ),
        )
      ],
    );
  }

  int i=0;
  DateTime today=DateTime.now();
  List<DateTime?> _dates = [
    DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTime(DateTime.now().year, DateTime.now().month, 5),
  ];
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  String pic="",pic1="";
  Uint8List? file;
  DateTime first=DateTime.now(),second=DateTime.now();
  Widget as(){
    if(i==0){
      double w=MediaQuery.of(context).size.width;
      return Column(
        children: [
          Container(
            width: w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap:() async {
                    try{
                      Uint8List? _file = await pickImage(ImageSource.gallery);
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Uploading")}.........", true);
                      String photoUrl =  await StorageMethods().uploadImageToStorage('tournament', _file!, true);

                      setState(() {
                        file = _file ;
                        pic = photoUrl ;
                      });
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Uploaded")}", true);
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  },
                  child:pic.isNotEmpty?Container(
                    width: w/2-40,height: w/2-40,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(pic),fit:BoxFit.cover)
                    ),
                  ): Container(
                    width: w/2-40,height: w/2-40,
                    color: Global.blac,
                    child: Center(child: Icon(Icons.add,color: Colors.white,)),
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap:() async {
                    try{
                      Uint8List? _file = await pickImage(ImageSource.gallery);
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Uploading")}.........", true);
                      String photoUrl =  await StorageMethods().uploadImageToStorage('tournament', _file!, true);
                      setState(() {
                        file = _file ;
                        pic1 = photoUrl ;
                      });
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Uploaded")}", true);
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  },
                  child:pic1.isNotEmpty?Container(
                    width: w/2-40,height: w/2-40,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(pic1),fit:BoxFit.cover)
                    ),
                  ): Container(
                    width: w/2-40,height: w/2-40,
                    color: Global.blac,
                    child: Center(child: Icon(Icons.add,color: Colors.white,)),
                  ),
                ),
              ],
            ),
          ),  const SizedBox(height: 8),
          Global.d(nameController, "${AppLocalizations.of(context)!.translate("Name of Tournament")}", "${AppLocalizations.of(context)!.translate("Enter Tournament Name")}", false,false),
          const SizedBox(height: 16),
          Global.d(systemController, "${AppLocalizations.of(context)!.translate("System")}", "${AppLocalizations.of(context)!.translate("Enter System type")}", false,true),
          const SizedBox(height: 16),
          Global.d(descriptionController, "${AppLocalizations.of(context)!.translate("Description of Tournament")}", "${AppLocalizations.of(context)!.translate("Enter tournament description")}", false,false,ui:4),
          const SizedBox(height: 16),
          Global.d(organizerController, "${AppLocalizations.of(context)!.translate("Organizer")} ", "${AppLocalizations.of(context)!.translate("Enter organizer name")}", false,!widget.organizerup),
        ],
      );
    }else if(i==1){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          InkWell(
              onTap: () async {
                DatePickerBdaya.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(Duration(days: 600)), onChanged: (date) {
                      setState(() {
                        first=date;
                        dateTimeController.text= (date.year.toString()+" / "+date.month.toString()+" / "+date.day.toString()+"  at "+date.hour.toString()+" : "+date.minute.toString());
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        first=date;
                        dateTimeController.text= (date.year.toString()+" / "+date.month.toString()+" / "+date.day.toString()+"  at "+date.hour.toString()+" : "+date.minute.toString());
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              }, child: Row(
                children: [
                  SizedBox(width:18),
                  Global.yellow(280, "${AppLocalizations.of(context)!.translate("Select Start DateTime")}"),Spacer(),
                ],
              )),
          Global.d(
              dateTimeController, "${AppLocalizations.of(context)!.translate("DateTime")}", "${AppLocalizations.of(context)!.translate("Enter Date and Time")}", false,true),
          const SizedBox(height: 10),
          InkWell(
              onTap: () async {
                DatePickerBdaya.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(Duration(days: 600)), onChanged: (date) {
                      setState(() {
                        second=date;
                        endDateTimeController.text= (date.year.toString()+" / "+date.month.toString()+" / "+date.day.toString()+"  at "+date.hour.toString()+" : "+date.minute.toString());
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        second=date;
                        endDateTimeController.text= (date.year.toString()+" / "+date.month.toString()+" / "+date.day.toString()+"  at "+date.hour.toString()+" : "+date.minute.toString());
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Row(
                children: [
                  SizedBox(width:18),
                  Global.yellow(280, "${AppLocalizations.of(context)!.translate("Select End DateTime")}"),Spacer(),
                ],
              )),
          Global.d(endDateTimeController, "${AppLocalizations.of(context)!.translate("End DateTime")}", "${AppLocalizations.of(context)!.translate("Enter End date and time")}", false,true),
          const SizedBox(height: 16),
          Global.text12("     ${AppLocalizations.of(context)!.translate("Venue Location")}", 300),const SizedBox(height: 4),
          Global.d(venueController, "${AppLocalizations.of(context)!.translate("Venue")}", "${AppLocalizations.of(context)!.translate("Enter venue location")}", false,false,ui: 3),
        ],
      );
    }else if(i==2){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Global.text12("     ${AppLocalizations.of(context)!.translate("Total Prize")}", 300),const SizedBox(height: 4),
          Global.d(totalPrizeController, "${AppLocalizations.of(context)!.translate("Total Prize")}", "${AppLocalizations.of(context)!.translate("Enter total prize amount")}", true,false),
          const SizedBox(height: 16),
          Global.text12("     ${AppLocalizations.of(context)!.translate("First Prize")}", 300),const SizedBox(height: 4),
          Global.d(firstController, "${AppLocalizations.of(context)!.translate("First Prize")}", "${AppLocalizations.of(context)!.translate("Enter first prize")}", true,false),
          const SizedBox(height: 16),
          Global.text12("     ${AppLocalizations.of(context)!.translate("Second Prize")}", 300),const SizedBox(height: 4),
          Global.d(secondController, "${AppLocalizations.of(context)!.translate("Second Prize")}", "${AppLocalizations.of(context)!.translate("Enter second prize")}", true,false),
          const SizedBox(height: 16),
          Global.text12("     ${AppLocalizations.of(context)!.translate("Currency Type")}", 300),const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10,),
    rtty("\$"),  // Dollar
    rtty("€"),   // Euro
    rtty("£"),   // Pound
    rtty("₹"),   // Indian Rupee
    rtty("¥"),   // Chinese Yuan
    ],
          )
        ],
      );
    }else{
      double w=MediaQuery.of(context).size.width;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Global.text12("     ${AppLocalizations.of(context)!.translate("Terms & Condition")}", 300),const SizedBox(height: 4),
          Global.d(termsController, "${AppLocalizations.of(context)!.translate("Terms & Condition")}", "${AppLocalizations.of(context)!.translate("Enter terms")}", false,false,ui: 8),
          SizedBox(height: 20,),
          Global.text12("   ${AppLocalizations.of(context)!.translate("Additional Documents")}", 300),const SizedBox(height: 4),
          Row(
            children: [
              Container(
                  width: w/2-60,
                  child: Text("    ${AppLocalizations.of(context)!.translate("Offline")} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),)),
              Switch(value: offline, onChanged: (value){
                setState(() {
                  offline=!offline;
                });
              }),
            ],
          ),
          Row(
            children: [
              Container(
                  width: w/2-60,
                  child: Text("    ${AppLocalizations.of(context)!.translate("Public Join")} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),)),
              Switch(value: join, onChanged: (value){
                setState(() {
                  join=!join;
                });
              }),
            ],
          ),
        ],
      );
    }
  }
  String di="\$";
  Widget rtty(String str1){
    return InkWell(
      onTap: (){
        setState(() {
          di=str1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: di==str1?Colors.white:Global.blac,
            borderRadius: BorderRadius.circular(6)
          ),
          height: 30,width: 30,
          child: Center(child: Text(str1,style: TextStyle(color:di==str1?Colors.black: Global.yell),)),
        ),
      ),
    );
  }

  String g1(){
    if(i==0){
      return "Description";
    }else if(i==1){
      return "Date & Venue";
    }else if(i==2){
      return "Prize Details";
    }else{
      return "Terms & Condition";
    }
  }

  String g2(){
    if(i==0){
      return "Description of Tournament";
    }else if(i==1){
      return "Details of Venue of Tournament";
    }else if(i==2){
      return "Deatils of Finance for Tournament";
    }else{
      return "Very Important Condition for Tournament";
    }
  }
}
