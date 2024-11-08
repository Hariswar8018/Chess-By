import 'package:chessby/first/countries.dart';
import 'package:chessby/first/forgot.dart';
import 'package:chessby/first/signup.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String s = "Demo";
  String d = "Demo";
  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void googlesignin() async{
    final googleSignIn = GoogleSignIn();
    final signinAccount = await googleSignIn.signIn();

    final googleAcc = await signinAccount!.authentication ;
    final creditential = GoogleAuthProvider.credential(accessToken: googleAcc.accessToken, idToken: googleAcc.idToken);

    await FirebaseAuth.instance.signInWithCredential(creditential);

    if(FirebaseAuth.instance.currentUser != null){
      print("Successfull");
      print('${FirebaseAuth.instance.currentUser!.displayName} signedin.');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success, Welcome ${FirebaseAuth.instance.currentUser!.displayName}'),
          ));
    }else{
      print("Unable to Sign In");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
            body:  Container(
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
                      SizedBox(height: 30,),
                      Center(child: Text("chessbyBe", style: TextStyle( fontFamily: "font1", fontSize: 30, color: Color(0xffff79ac))),),
                      SizedBox(height: 20,),
                      Image.asset("assets/5e45c3f6445fba750c3b4776c7a298fb.gif"),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',  isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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
                          labelText: 'Password', isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please type your Password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            s = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(height: 10,),

                      SocialLoginButton(
                        backgroundColor:  Color(0xffff79ac),
                        height: 40,
                        text: 'Login Now',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.generalLogin,
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: d,
                              password: s,
                            );

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', true);
                            Navigator.push(
                                context, PageTransition(
                                child: Home(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                            ));

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No User found for this Email'),
                                ),
                              );
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Wrong password provided for that user.'),
                                ),
                              );
                            }
                            else {
                              print('Wrong password provided for that user.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("$e"),
                                ),
                              );
                            }
                          }
                        }
                      ),
                      SizedBox(height: 15,),
                      SocialLoginButton(
                        backgroundColor: Colors.white,
                        height: 40,
                        text: 'Login with Google',
                        borderRadius: 20,
                        fontSize: 21,
                        buttonType: SocialLoginButtonType.google,
                        imageWidth: 20,
                        onPressed: () {
                          googlesignin();
                        },
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () {
                            Navigator.push(
                                context, PageTransition(
                                child: Country(justname: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                            ));
                          }, child: Text("New User? Sign Up here", style: TextStyle(color: Color(0xffff79ac))),),
                          TextButton(onPressed: () {
                            Navigator.push(
                                context, PageTransition(
                                child: Forgot(email: _emailController,), type: PageTransitionType.topToBottom, duration: Duration(milliseconds: 800)
                            ));
                          }, child: Text("Forgot Password?",  style: TextStyle(color: Color(0xffff79ac),)),),
                        ],
                      ),

                      SizedBox(height: 10,),
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
              Image.asset("assets/main_top.png", height: 140,),
              Spacer(),
              Image.asset("assets/main_bottom.png", height: 120)
            ],
          ),
        ],
      ),
    );
  }
}
