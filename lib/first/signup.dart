import 'dart:typed_data';

import 'package:chessby/first/login.dart';
import 'package:chessby/first/step2_signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:social_login_buttons/social_login_buttons.dart';

class SignUp extends StatefulWidget {
  String h ;
  SignUp({super.key, required this.h});

  @override
  _SignUpState createState() => _SignUpState();
}

bool _isLoggedIn = false;
String name = "Nijino Yume";
String d = "demo@gmail.com";

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  static String s = "Demo";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  // Check if user is already logged in

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void googlesignin() async {
    final googleSignIn = GoogleSignIn();
    final signinAccount = await googleSignIn.signIn();

    final googleAcc = await signinAccount!.authentication;
    final creditential = GoogleAuthProvider.credential(
        accessToken: googleAcc.accessToken, idToken: googleAcc.idToken);

    await FirebaseAuth.instance.signInWithCredential(creditential);

    if (FirebaseAuth.instance.currentUser != null) {
      print("Successfull");
      print('${FirebaseAuth.instance.currentUser!.displayName} signedin.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Success, Welcome ${FirebaseAuth.instance.currentUser!.displayName}'),
      ));
    } else {
      print("Unable to Sign In");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please use another Method'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the alert dialog and wait for a result
        bool exit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit?'),
              actions: [
                ElevatedButton(
                  child: Text('No'),
                  onPressed: () {
                    // Return false to prevent the app from exiting
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                    // Return true to allow the app to exit
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        // Return the result to handle the back button press
        return exit ?? false;
      },
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Text("CheesBe",
                              style: TextStyle(
                                  fontFamily: "font1", fontSize: 30, color: Color(0xffff79ac)))),
                      SizedBox(height: 20,),
                      Image.asset("assets/5e45c3f6445fba750c3b4776c7a298fb.gif"),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          }),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            d = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            s = value;
                          });
                        },
                      ),
                      SizedBox(height: 30.0),
                      SocialLoginButton(
                        backgroundColor: Color(0xffff79ac),
                        height: 40,
                        text: 'Sign Up Now',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.generalLogin,
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: d,
                              password: s,
                            );
                            print(credential);

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'The password provided is too weak.'),
                                ),
                              );
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'The account already exists for that email.'),
                                ),
                              );
                            }
                          } catch (e) {

                          print('$e');
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                          content: Text("$e"),
                          ),
                          );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: LoginScreen(),
                                      type: PageTransitionType.leftToRight,
                                      duration: Duration(milliseconds: 800)));
                            },
                            child: Text("Existing User? Log in here",  style: TextStyle(color: Color(0xffff79ac),)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Forgot Password",  style: TextStyle(color: Color(0xffff79ac),)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/main_top.png",
                height: 140,
              ),
              Spacer(),
              Image.asset("assets/main_bottom.png", height: 120)
            ],
          ),
        ],
      ),
    );
  }
}
