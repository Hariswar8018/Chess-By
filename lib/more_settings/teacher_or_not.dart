import 'package:chessby/MY_Profile/teacher_navigation.dart';
import 'package:chessby/models/teacher_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class TecaherNot extends StatelessWidget {
  const TecaherNot({super.key});

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
                        'You may need Paypal Developer Account for API and secret key if you want to receive payment here on the App'),
                    actions: [
                      ElevatedButton(
                        child: Text('No, I would make one now'),
                        onPressed: () {
                          // Return false to prevent the app from exiting
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: Text('I have already'),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: AddP(),
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200)));
                        },
                      ),
                      ElevatedButton(
                        child: Text('Not take Online Payments'),
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
        //floating action button location to left
        appBar: AppBar(
          title: Text("Teacher Profile"),
        ),
        body: Container(
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
                    color: Colors.black),
              ),
              Text(
                "♛ Join Now, and Earn with Teaching chessby ♛",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
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

  String study = " ";
  int price = 5;
  int min = 50;

  int phone = 7978097489;
  String Language = " ";
  String Bio = " ";
  String Bio_Bio = " ";
  String Shedule = " ";
  String special = " ";
  String api = " ";
  String secret = " ";
  final _formKey = GlobalKey<FormState>();
  bool? checkboxIconFormFieldValue = false;

  String Youtube = " ";

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(title: Text("Adding Profile")),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CircleAvatar(
                backgroundImage: NetworkImage(_user!.Pic_link),
                minRadius: 60,
              ),
              SizedBox(height: 20),
              Center(
                child: Icon(CupertinoIcons.person_2_alt,
                    size: 30, color: Colors.red),
              ),
              Center(
                child: Text("Teacher Basic Information",
                    style: TextStyle(color: Colors.red)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: _user!.Name + " ( not editable )",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: _user.Email + " ( not editable )",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Icon(CupertinoIcons.bag_fill,
                    size: 30, color: Colors.pinkAccent),
              ),
              Center(
                child: Text("Class Information",
                    style: TextStyle(color: Colors.pinkAccent)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Phone ',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      phone = value as int;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price in \$',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              price = value as int;
                            });
                          },
                        ),
                      ),
                      Text(
                        " / ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'per Minute',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              min = value as int;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  maxLength: 60,
                  decoration: InputDecoration(
                    labelText: "Your Class Introduction in 1 Sentence",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 9,
                  onChanged: (value) {
                    setState(() {
                      Bio = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Icon(CupertinoIcons.doc_fill,
                    size: 30, color: Colors.orange),
              ),
              Center(
                child: Text("Other Details",
                    style: TextStyle(color: Colors.orange)),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Study ',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      study = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Languages you speak ',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      Language = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Icon(CupertinoIcons.bag_fill,
                    size: 30, color: Colors.greenAccent),
              ),
              Center(
                child: Text("Speciality",
                    style: TextStyle(color: Colors.greenAccent)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Your Bio",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: 9,
                  onChanged: (value) {
                    setState(() {
                      Bio_Bio = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Your Speciality",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 9,
                  onChanged: (value) {
                    setState(() {
                      special = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Icon(Icons.paypal_outlined,
                    size: 30, color: Colors.blueAccent),
              ),
              Center(
                child: Text("PayPal Informations",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
              Center(
                child: Text("( If you don't want online payments, don't fill anything in this section )", textAlign : TextAlign.center
                    ,style: TextStyle(color: Colors.blueAccent)),
              ),
              SizedBox(height: 10),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Your API KEY',
                    isDense: true,
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      api = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Your Secret Key',
                    isDense: true,
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      secret = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 5),
            ]),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SocialLoginButton(
            backgroundColor: Color(0xff50008e),
            height: 40,
            text: 'Confirm Profile',
            borderRadius: 20,
            fontSize: 21,
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try{
                  DateTime dateTime = DateTime.now();
                  String d = dateTime.toString() ;
                  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                  TeacherModel teach = TeacherModel(
                      uid: _user.uid,
                      Email: _user.Email,
                      Name: _user.Name,
                      Pic_link: _user.Pic_link,
                      Price_N: price,
                      Minutes_N: min,
                      Reviews_N: 0,
                      Study: study,
                      Language: Language,
                      Active_N: [],
                      Special_Bio: special,
                      Bio_Bio: Bio_Bio,
                      Shedule: Shedule,
                      Imp_N: [],
                      Tap_N: [],
                      Joined: formattedDate,
                      Phone: phone,
                      lastlogin: d,
                      Gender: _user.Gender,
                      Bio: Bio,
                      clientId: api,
                      secretkey: secret);
                  await FirebaseFirestore.instance
                      .collection("teacher")
                      .doc(_user.uid).set(teach.toJson());
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
}
