import 'dart:typed_data';

import 'package:chessby/MY_Profile/teacher_navigation.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:chessby/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:current_location/current_location.dart';
import 'package:current_location/model/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../aaaaa/global.dart';
import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/fight/phone.dart';
import 'package:chessby/fight/signup.dart';
import 'package:chessby/first/forgot.dart';

import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/main.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localization.dart';

class ClubNot extends StatelessWidget {
ClubNot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () async {
            try {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('${AppLocalizations.of(context)!.translate("Attention")}" !'),
                    content: Text("${AppLocalizations.of(context)!.translate("You may need to be in the Location of the chessby Club to Fix Location for Map ! ( It can't be change later ) ")}"),
                      actions: [
                        ElevatedButton(
                        child: Text('${AppLocalizations.of(context)!.translate("Okay, I would go now")}'),
                        onPressed: () {
                          // Return false to prevent the app from exiting
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: Text('${AppLocalizations.of(context)!.translate("I am here Already in Club")}'),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: AddP(),
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200)));
                        },
                      ),
                    ],
                  );
                },
              );
            } catch (e) {
              print(e);
            }

            //code to execute on button press
          },
          child: Icon(Icons.add), //icon inside button
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          elevation: 0,
          title: Text("${AppLocalizations.of(context)!.translate("Club Profile")}", style: TextStyle(color: Colors.white),),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('clubs').where('uid', isEqualTo : FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
                  return r(context);
                }
                return ListView.builder(
                  itemCount: _list.length,
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Hoyee(
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
  Widget r(BuildContext context)=>Container(
      width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/back.png"),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/search-not-found-6275834-5210416.webp"),
            Text(
              "${AppLocalizations.of(context)!.translate("Oops ! You No Chess Profile")}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Text(
              "♛ ${AppLocalizations.of(context)!.translate("Create Now, and Host a Chessby Club")} ♛",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            )
          ]));
  List<ClubModel> _list = [];
}

class AddP extends StatefulWidget {
  bool byadmin; String state;String email;String address;String Lat;String Lon;String id;
 AddP({super.key,this.byadmin=false, this.state="",this.email="",this.address="",this.Lat="",this.Lon="",this.id=""});

  @override
  State<AddP> createState() => _AddPState();
}

class _AddPState extends State<AddP> {
  String h = " ";

  void initState(){
    f();
  }
  late TextEditingController State;
  late TextEditingController Email;
  late TextEditingController Address;
  late TextEditingController Lat;
  late TextEditingController Lon;
  f() async{
    if(widget.byadmin){
      setState(() {
        h  = widget.state;
        State = TextEditingController(text : widget.state);
        Email = TextEditingController(text : widget.email);
        Address = TextEditingController(text : widget.address);
        Lat = TextEditingController(text : widget.Lat);
        Lon = TextEditingController(text :widget.Lon);
      });
    }else{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String gh = FirebaseAuth.instance.currentUser!.email ?? "h" ;

      final Location? userLocation = await UserLocation.getValue();
      String country = userLocation!.country ?? "INDIA";
      String state = userLocation.regionName ?? "ODISHA";
      String sip = userLocation.isp ?? "IP" ;
      double lat = userLocation.latitude ?? 677.22;
      double lon = userLocation.longitude ?? 567.9;
      print(state);
      String address = " ";
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat!, lon!);
      if (placemarks != null && placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks.first;
        // Access the address components
        address = "${placemark.street}, ${placemark.locality}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.isoCountryCode}";
        print("User's address: $address");
      }

      setState(() {
        h  = prefs.getString('State') ?? "Canary Islands";
        State = TextEditingController(text : h);
        Email = TextEditingController(text : gh);
        Address = TextEditingController(text : address);
        Lat = TextEditingController(text : lat.toString());
        Lon = TextEditingController(text : lon.toString());
      });
    }
  }

  TextEditingController Name = TextEditingController();
  TextEditingController HEmail = TextEditingController();
  TextEditingController HName = TextEditingController();
  TextEditingController Bio = TextEditingController();
  TextEditingController Language = TextEditingController();
  TextEditingController Facebook = TextEditingController();
  TextEditingController Instagram = TextEditingController();
  TextEditingController Whatsapp = TextEditingController();
  TextEditingController Discord = TextEditingController();
  TextEditingController LinkedIn = TextEditingController();
  TextEditingController X = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? checkboxIconFormFieldValue = false;
  String pic="https://en.chessbase.com/portals/all/2020/02/wien-schach/cafe/2019-chess-unlimted-02.jpg";
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          title: Text("${AppLocalizations.of(context)!.translate("Adding chessby Profile")}",style: TextStyle(color: Colors.white),)),
      body: Container(
        width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    try{
                      Uint8List? _file = await pickImage(ImageSource.gallery);
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Uploading")}.........", true);
                      String photoUrl =  await StorageMethods().uploadImageToStorage('users', _file!, true);
                      setState(() {
                        pic = photoUrl ;
                      });
                      Send.message(context, "${AppLocalizations.of(context)!.translate("Uploaded")}", true);
                    }catch(e){
                      Send.message(context, "$e", false);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(pic),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(child: Text("${AppLocalizations.of(context)!.translate("Click Picture to Upload")}",style: TextStyle(color: Colors.white),)),
                SizedBox(height: 10),
                Center(
                  child: Icon(CupertinoIcons.person_2_alt,
                      size: 30, color: Colors.red),
                ),
                Center(
                  child: Text("chessby Club Basic Information",
                      style: TextStyle(color: Colors.red)),
                ),
                SizedBox(height: 10),
                Global.d(Name, "${AppLocalizations.of(context)!.translate("Name")}", "",false,false),SizedBox(height: 5),
                Global.d(Email, "${AppLocalizations.of(context)!.translate("Email")}",  "",false,true),SizedBox(height: 5),
                Global.d(HName, "${AppLocalizations.of(context)!.translate("Host Name")}",  "",false,false),SizedBox(height: 5),
                Global.d(HEmail, "${AppLocalizations.of(context)!.translate("Host Email")}",  "",false,false),SizedBox(height: 5),
                Center(
                  child: Icon(CupertinoIcons.bag_fill,
                      size: 30, color: Colors.green),
                ),
                Center(
                  child: Text("${AppLocalizations.of(context)!.translate("Other Information")}",
                      style: TextStyle(color: Colors.green)),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: an(Bio, "Bio",  false),
                ),SizedBox(height: 5),
                Global.d(State, "${AppLocalizations.of(context)!.translate("State")}",  "",false,true),SizedBox(height: 5),
                Global.d(Address, "${AppLocalizations.of(context)!.translate("Your Address")}", "",false,false),SizedBox(height: 5),
                Global.d(Lat, "${AppLocalizations.of(context)!.translate("Latitude")}",  "",false,true),SizedBox(height: 5),
                Global.d(Lon, "${AppLocalizations.of(context)!.translate("Longitude")}",  "",false,true),SizedBox(height: 5),
                Global.d(Language, "${AppLocalizations.of(context)!.translate("Club Primary Language")}",  "",false,false),SizedBox(height: 5),
                Center(
                  child: Icon(Icons.face,
                      size: 30, color: Colors.blueAccent),
                ),
                Center(
                  child: Text("${AppLocalizations.of(context)!.translate("Social Profile Informations")}",
                      style: TextStyle(color: Colors.blueAccent)),
                ),
                Center(
                  child: Text("( ${AppLocalizations.of(context)!.translate("This is necessary for Peoples to Join your Social Links. You can update anytime")}", textAlign : TextAlign.center
                      ,style: TextStyle(color: Colors.blueAccent)),
                ),
                SizedBox(height: 10,),
                Global.d(Facebook, "${AppLocalizations.of(context)!.translate("Facebook Group")}",  "",false,false),SizedBox(height: 5),
                Global.d(Instagram, "${AppLocalizations.of(context)!.translate("Instagram Account")}",  "",false,false),SizedBox(height: 5),
                Global.d(Whatsapp, "${AppLocalizations.of(context)!.translate("Whatsapp Group")}",  "",false,false),SizedBox(height: 5),
                Global.d(Discord, "${AppLocalizations.of(context)!.translate("Discord Server")}",  "",false,false),SizedBox(height: 5),
                Global.d(LinkedIn, "${AppLocalizations.of(context)!.translate("LinkedIn Profile")}",  "",false,false),SizedBox(height: 5),
                Global.d(X, "${AppLocalizations.of(context)!.translate("X profile")}",  "",false,false),SizedBox(height: 5),
                SizedBox(height: 20),
                SizedBox(height: 5),
              ]),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SocialLoginButton(
            backgroundColor: Color(0xff50008e),
            height: 40,
            text: 'Confirm ChessBy Club Profile',
            borderRadius: 20,
            fontSize: 21,
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () async {
                try{
                  double doubleValue = double.parse(Lat.text);
                  double doubleValue1 = double.parse(Lon.text);
                  DateTime today = DateTime.now();
                  String yu = today.millisecondsSinceEpoch.toString() ;
                  String formattedDate = '${_getMonth(today.month)} ${today.day}';
                  String gha = FirebaseAuth.instance.currentUser!.uid ?? "h" ;
                  ClubModel b = ClubModel(Email: Email.text, Name: Name.text, HEmail: HEmail.text, HName: HName.text,
                      uid: gha, Pic_link: pic, Bio: Bio.text, Language: Language.text,
                      Location: Address.text, Lat: doubleValue, Lon: doubleValue1, lastlogin: yu,
                      Create: formattedDate, Lastlogin: yu, discord: Discord.text,
                      facebook: Facebook.text, instagram: Instagram.text, linkedin: LinkedIn.text,
                      twitter: X.text, whatsapp: Whatsapp.text, Clublist: [], State: State.text,
                      ratingsnumber: 0, ratingpeople: 0, blocks: [], status: widget.byadmin?"Active":'Waiting for Approval');
                  await FirebaseFirestore.instance
                      .collection("clubs")
                      .doc(gha).set(b.toJson());
                 if(widget.byadmin){
                   Navigator.pop(context);
                   Navigator.pop(context);
                   Send.message(context, "${AppLocalizations.of(context)!.translate("Success : Chess Place confirmed")}", false);
                 }else{
                   Navigator.push(
                       context,
                       PageTransition(
                           child: Home(),
                           type: PageTransitionType.rightToLeft,
                           duration: Duration(milliseconds: 200)));
                   Send.message(context, "${AppLocalizations.of(context)!.translate("Success : Waiting for Approval from Admin")}", false);
                 }

                }catch(e){
                  Send.message(context, "$e", false);
                }
                print("SUCCESS");

            },
          ),
        ),
      ],
    );
  }

  String _getMonth(int month) {
    List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }
  

  Widget a(TextEditingController s, String f, bool b){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right : 8, bottom : 18),
      child: TextFormField(
        controller: s,
        decoration: InputDecoration(
          labelText: f,
          isDense: true,
          border: OutlineInputBorder(),
        ),
        readOnly: b,
      ),
    );
  }

  Widget an(TextEditingController s, String f, bool b){
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff202020),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          controller: s,
          maxLines: 15,
          minLines: 3,
          decoration: InputDecoration(
            labelText: "  Bio" ,
            hintText: "",
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
    );
  }
}
