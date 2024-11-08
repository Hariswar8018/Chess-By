import 'package:chessby/MY_Profile/teacher_navigation.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:current_location/current_location.dart';
import 'package:current_location/model/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class ClubNot extends StatelessWidget {
  const ClubNot({super.key});

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
                    title: Text('Attention !'),
                    content: Text(
                        "You may need to be in the Location of the chessby Club to Fix Location for Map ! ( It can't be change later ) "),
                    actions: [
                      ElevatedButton(
                        child: Text('Okay, I would go now'),
                        onPressed: () {
                          // Return false to prevent the app from exiting
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: Text('I am here Already in Club'),
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
          title: Text("Club Profile",style: TextStyle(color: Colors.white),),
        ),
        body: Container(
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
                    "Oops ! You need to Add Profile",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "♛ Join Now, and Host a chessby Club ♛",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ])));
  }
}

class AddP extends StatefulWidget {

  const AddP({super.key});

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
  String pic="https://images.indianexpress.com/2024/07/NEW-puzzles-headers-3-1.jpg";
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
          title: Text("Adding chessby Profile",style: TextStyle(color: Colors.white),)),
      body: Container(
        width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(pic),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Icon(CupertinoIcons.person_2_alt,
                      size: 30, color: Colors.red),
                ),
                Center(
                  child: Text("chessby Club Basic Information",
                      style: TextStyle(color: Colors.red)),
                ),
                SizedBox(height: 10),
                a(Name, "Name", false),
                a(Email, "Email", true),
                a(HName, "Host Name", false),
                a(HEmail, "Host Email", false),
                Center(
                  child: Icon(CupertinoIcons.bag_fill,
                      size: 30, color: Colors.green),
                ),
                Center(
                  child: Text("Other Information",
                      style: TextStyle(color: Colors.green)),
                ),
                SizedBox(height: 10,),
                an(Bio, "Bio", false),
                a(State, "State", true),
                a(Address, "Your Address", true),
                a(Lat, "Latitude", true),
                a(Lon, "Longitude", true),
                a(Language, "Club Primary Language", false),
                Center(
                  child: Icon(Icons.face,
                      size: 30, color: Colors.blueAccent),
                ),
                Center(
                  child: Text("Social Profile Informations",
                      style: TextStyle(color: Colors.blueAccent)),
                ),
                Center(
                  child: Text("( This is necessary for Peoples to Join your Social Links. You can update anytime )", textAlign : TextAlign.center
                      ,style: TextStyle(color: Colors.blueAccent)),
                ),
                SizedBox(height: 10,),
                a(Facebook, "Facebook Group", false),
                a(Instagram, "Instagram Account", false),
                a(Whatsapp, "Whatsapp Group", false),
                a(Discord, "Discord Server", false),
                a(LinkedIn, "LinkedIn Profile", false),
                a(X, "X profile", false),
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
            text: 'Confirm chessby Club Profile',
            borderRadius: 20,
            fontSize: 21,
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
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
                      ratingsnumber: 0, ratingpeople: 0, blocks: []);
                  await FirebaseFirestore.instance
                      .collection("clubs")
                      .doc(gha).set(b.toJson());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Success, It may take a few minute to Live'),
                    ),
                  );
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Home(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200)));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Success, Done'),
                    ),
                  );
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Teacher_Navigation(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200)));
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Error : ${e}'),
                    ),
                  );
                }
                print("SUCCESS");
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Please accept all Terms & Condition'),
                  ),
                );
                print("FAIL");
              }

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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right : 8, bottom : 18),
      child: TextFormField(
        controller: s,
        maxLines: 15,
        minLines: 3,
        decoration: InputDecoration(
          labelText: f,
          isDense: true,
          border: OutlineInputBorder(),
        ),
        readOnly: b,
      ),
    );
  }
}
