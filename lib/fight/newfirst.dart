import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/fight/phone.dart';
import 'package:chessby/fight/signup.dart';
import 'package:chessby/first/forgot.dart';

import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/main.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            opacity: 0.5
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
          Global.text1("  ${AppLocalizations.of(context)!.translate("LetsGetStarted")} !",w),
            Padding(
                padding: EdgeInsets.only(left: 20,right: 10),
              child:   Global.text2("${AppLocalizations.of(context)!.translate("SignupToFindNearbyPlayers")}", w),
            ),
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
                child: Center(child: Global.white(w, "${AppLocalizations.of(context)!.translate("ContinueWithEmail")}", Icon(Icons.email,color: Colors.white,)))),
            SizedBox(height: 20,),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: PhoneLogin(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                },
                child: Center(child: Global.white(w,"${AppLocalizations.of(context)!.translate("ContinueWithPhoneNumber")}", Icon(Icons.phone,color: Colors.white,)))),
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
                        Send.message(context, "${AppLocalizations.of(context)!.translate("Look Like you are New ! We will create New Account for You")}", true);
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
                child: Center(child: Global.white(w, "${AppLocalizations.of(context)!.translate("ContinueWithGoogle")}", Icon(FontAwesomeIcons.google,color: Colors.red,)))),
            Global.height(10),
            SizedBox(height: 30,),
            Center(child: Text("${AppLocalizations.of(context)!.translate("BySigningUpYouAgreeTo")}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white),)),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppLocalizations.of(context)!.translate("Our")}',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)
                    ),
                    TextSpan(
                        text: ' Terms and Condition ',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.yellow)
                    ),
                    TextSpan(
                        text: '${AppLocalizations.of(context)!.translate("And")}',
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
              opacity: 0.5
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Global.text1("  ${AppLocalizations.of(context)!.translate("WhatsYour")} ", w),
            Padding(padding: EdgeInsets.only(left: 15,right: 15),
              child:   Global.text1("${AppLocalizations.of(context)!.translate("EmailAddress")} ?", w),
            ),
            Global.height(8),
            Global.text2("    ${AppLocalizations.of(context)!.translate("VerifyAndSecureAccount")}", w),
            Global.height(10),
            Global.d(c, "${AppLocalizations.of(context)!.translate("YourEmailAddress")}", "", false,false),
            Global.height(10),
            InkWell(
                onTap: () async {
                  if(c.text.isEmpty){
                    Send.message(context, "${AppLocalizations.of(context)!.translate("PleaseTypeEmailAddress")}", false);
                  }else  if(isValidEmail(c.text)){
                    try {
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                      QuerySnapshot querySnapshot = await usersCollection.where('Email', isEqualTo: c.text).get();
                      if (querySnapshot.docs.isNotEmpty) {
                        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Login(email: c,),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 80)));
                        Send.message(context, "${AppLocalizations.of(context)!.translate('Hello')} ${user.Name}, ${AppLocalizations.of(context)!.translate('WelcomeAgain')}", true);
                      } else {
                         Navigator.push(
                            context,
                            PageTransition(
                                child: ConfirmPassword(email: c),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 80)));
                         Send.message(context, "${AppLocalizations.of(context)!.translate('LookLikeNew')}", true);
                      }
                    } catch (e) {
                      Send.message(context, "$e", false);
                      return null;
                    }
                  }else{
                    Send.message(context, "${AppLocalizations.of(context)!.translate("EmailAddressNotValid")}", false);
                  }
                },
                child: Center(child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("ContinueWithEmailAddress")}"))),
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
            Global.text1("  ${AppLocalizations.of(context)!.translate("WelcomeBack")} ", w),
            Global.text2("    ${AppLocalizations.of(context)!.translate("EnterPasswordToGetStarted")}", w),
            Global.height(20),
            Global.d(email, "${AppLocalizations.of(context)!.translate("WelcomeBack")}", "", false,true),
            Global.height(10),
            Global.d(password, "${AppLocalizations.of(context)!.translate("YourPassword")}", "", false,false),
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
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      Send.message(context, 'Wrong password provided for that user', false);
                    }
                    else {
                      print('Wrong password provided for that user.');
                      Send.message(context, '$e', false);
                    }
                  }
                },
                child: Center(child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("Login")}"))),
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
                child: Text("     ${AppLocalizations.of(context)!.translate("YourPassword")} ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),)),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
