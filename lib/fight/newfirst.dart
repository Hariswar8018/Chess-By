import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/fight/signup.dart';
import 'package:chessby/first/forgot.dart';
import 'package:chessby/first/signup.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/main.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class First2 extends StatelessWidget {
  const First2({super.key});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.7
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
          Global.text1("  Let's Get Started !",w),
            Global.text2("    Please SignUp to explore the World of chessby", w),
            SizedBox(height: 20,),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Find(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                },
                child: Center(child: Global.white(w, "Continue with Email", Icon(Icons.email,color: Colors.white,)))),
            Global.height(10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Global.height(10),
            InkWell(
                onTap: () async {
                  try {
                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication googleAuth = await googleUser!
                        .authentication;
                    final AuthCredential credential = GoogleAuthProvider
                        .credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    await FirebaseAuth.instance.signInWithCredential(credential);
                    String uid = await FirebaseAuth.instance.currentUser!.uid;
                    String email = await FirebaseAuth.instance.currentUser!.email??"";
                    try {
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();
                      if (querySnapshot.docs.isNotEmpty) {
                        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
                        Send.message(context, "Hello ${user.Name}, Welcome", true);

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', true);
                        Navigator.push(
                            context, PageTransition(
                            child: Home(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                        ));
                      } else {
                        Send.message(context, "Look Like you are New ! We will create New Account for You", true);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: SecondForm(email:email),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 80)));
                      }
                    } catch (e) {
                      Send.message(context, "$e", false);
                      return null;
                    }
                  }catch(e){
                    print(e);
                    Send.message(context, "$e", false);
                  }
                },
                child: Center(child: Global.white(w, "Continue with Google", Icon(Icons.email,color: Colors.white,)))),
            Global.height(10),
            SizedBox(height: 30,),
            Center(child: Text("By signin up you agree to",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white),)),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'our',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)
                    ),
                    TextSpan(
                        text: ' Terms and Condition ',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.yellow)
                    ),
                    TextSpan(
                        text: 'and',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)
                    ),
                    TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.yellow)
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class Find extends StatelessWidget {
   Find({super.key});
TextEditingController c=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
              opacity: 0.7
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Global.text1("  What's your ", w),
            Global.text1("  Email Address ?", w),
            Global.height(8),
            Global.text2("    We need to verify and secure your Account", w),
            Global.height(10),
            Global.d(c, "Your Email Address", "", false,false),
            Global.height(10),
            InkWell(
                onTap: () async {
                  if(c.text.isEmpty){
                    Send.message(context, "Please Type Email Address", false);
                  }else  if(isValidEmail(c.text)){
                    try {
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                      QuerySnapshot querySnapshot = await usersCollection.where('Email', isEqualTo: c.text).get();

                      if (querySnapshot.docs.isNotEmpty) {
                        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
                        Send.message(context, "Hello ${user.Name}, We need your Passsword to Log you in", true);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Login(email: c,),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 80)));
                      } else {
                        Send.message(context, "Look Like you are New ! We will create New Account for You", true);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ConfirmPassword(email: c),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 80)));
                      }
                    } catch (e) {
                      Send.message(context, "$e", false);
                      return null;
                    }
                  }else{
                    Send.message(context, "Email Address is not Valid", false);
                  }
                },
                child: Center(child: Global.yellow(w, "Continue with Email Address"))),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
   bool isValidEmail(String email) {
     // Define the email regex pattern
     String emailPattern =
         r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

     // Create a regex instance with the pattern
     RegExp regex = RegExp(emailPattern);

     // Check if the email matches the pattern
     return regex.hasMatch(email);
   }
}

class Login extends StatelessWidget {
  
  
  Login({super.key,required this.email});

  TextEditingController email;
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back.png"),
              fit: BoxFit.cover,
              opacity: 0.7
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Global.text1("  Welcome Back ", w),
            Global.text2("    Enter your Password to get Started", w),
            Global.height(20),
            Global.d(email, "Your Email Address", "", false,true),
            Global.height(10),
            Global.d(password, "Your Password", "", false,false),
            Global.height(10),
            InkWell(
                onTap: () async {
                  try {
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
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
                      Send.message(context, 'No User found for this Email', false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No User found for this Email'),
                        ),
                      );
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      Send.message(context, 'Wrong password provided for that user', false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Wrong password provided for that user.'),
                        ),
                      );
                    }
                    else {
                      print('Wrong password provided for that user.');
                      Send.message(context, '$e', false);
                    }
                  }
                },
                child: Center(child: Global.yellow(w, "Login"))),
            SizedBox(height: 30,),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Forgot(email: email,),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                },
                child: Text("     Having Trouble login in ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),)),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
