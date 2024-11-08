import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/fight/newfirst.dart';
import 'package:chessby/fight/signup.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field_v2/otp_field_style_v2.dart';

import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final TextEditingController _ref = TextEditingController();
  String s = "Demo";
  String d = "Demo";
  bool round = false ;
  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool on = false;
  String var1 = " ";bool otpsent=false;String s1="91";
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
            Padding(padding: EdgeInsets.only(left: 15,right: 15),child:   Global.text1("${AppLocalizations.of(context)!.translate("ContinueWithPhoneNumber")} ?", w),),
            Global.height(8),
            Padding(padding: EdgeInsets.only(left: 15,right: 15),child:  Global.text2("${AppLocalizations.of(context)!.translate("VerifyAndSecureAccount")}", w),),
            Global.height(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width : 140  , height : 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only( left : 10.0,right: 10),
                      child: IntlPhoneField(
                        controller: _ref,
                        onCountryChanged: (phone){
                          setState(() {
                            print(phone.code);
                            s1=phone.dialCode;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "  " ,
                          hintText: "",
                          isDense: true,
                          enabled: false,
                          filled: true,
                          fillColor: Colors.white, // Set the editor background color to black
                          labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
                          border: InputBorder.none, // Remove the underline
                          focusedBorder: InputBorder.none, // Remove the underline when focused
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          setState(() {
                            print(phone.countryCode);
                            s1=phone.countryCode;
                          });
                        }, readOnly: true, disableLengthCheck: true,
                      ),
                    ),
                  ),
                  SizedBox(width : 10),
                  Container(
                    width : MediaQuery.of(context).size.width - 170  , height : 60,
                    decoration: BoxDecoration(
                      color: Color(0xff202020),
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only( left :10, right : 18.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "${AppLocalizations.of(context)!.translate('PhoneNumber')}" ,
                            hintText: "",
                            isDense: true,
                            filled: true,
                            enabled: !otpsent,
                            fillColor: Color(0xff202020), // Set the editor background color to black
                            labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
                            hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
                            border: InputBorder.none, // Remove the underline
                            focusedBorder: InputBorder.none, // Remove the underline when focused
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                    ),
                  ),
                ],
              ),
            ),
            Global.height(10),
            round ? Center(child: CircularProgressIndicator()) :otpsent? Padding(
              padding: const EdgeInsets.only(left:  10, right: 10),
              child: OTPTextFieldV2(
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldWidth: 54,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 25,cursorColor: Colors.black,
                otpFieldStyle: OtpFieldStyle(backgroundColor: Colors.white),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color: Colors.black),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) async {
                  print("Completed: " + pin);
                  String smsCode = pin;
                  print(pin);
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verification,
                      smsCode: smsCode
                  );
                  try {
                    await _auth.signInWithCredential(credential);
                    String uid = FirebaseAuth.instance.currentUser!.uid ;
                    nowsend(uid);
                  } catch (e) {
                    Send.message(context, "${e}", false);
                    print('Error signing in: $e');
                  }
                },
              ),
            ):(InkWell(
                onTap: () async {
                  setState((){
                    round = true ;
                  });
                    try {
                      await _auth.verifyPhoneNumber(
                        phoneNumber:"+"+s1+ _emailController.text,
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          await _auth.signInWithCredential(credential);
                          String uid = FirebaseAuth.instance.currentUser!.uid ;
                          nowsend(uid);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          Send.message(context, "${e}", false);
                          print(
                              'Verification failed: ${e.message}');
                        },
                        codeSent: (String verificationId,
                            int? resendToken) {
                          Send.message(context, "${AppLocalizations.of(context)!.translate('OTPSent')}", true);
                          setState(() {
                            otpsent=true;
                            verification=verificationId;
                          });
                          print(
                              'Verification ID: $verificationId');
                        },
                        codeAutoRetrievalTimeout:
                            (String verificationId) {
                              Send.message(context, "${AppLocalizations.of(context)!.translate('CodeTimeOut')}", false);
                          print(
                              'Auto Retrieval Timeout. Verification ID: $verificationId');
                        },
                      );
                      setState((){
                        round = false ;
                      });
                    } catch (e) {
                      setState((){
                        round = false ;
                      });
                      print(
                          'Error sending verification code: $e');
                      Send.message(context, "${e}", false);
                    }
                },
                child: Center(child: Global.yellow(w, "${AppLocalizations.of(context)!.translate('SendMyOTP')}")))),
          /*  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width : 100  , height : 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100, // Background color of the container
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only( left : 10.0),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          isDense: true, enabled : false ,
                          border: InputBorder.none, // No border
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        }, readOnly: true, disableLengthCheck: true,
                      ),
                    ),
                  ),
                  SizedBox(width : 10),
                  Container(
                    width : MediaQuery.of(context).size.width - 150  , height : 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100, // Background color of the container
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only( left :10, right : 18.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'Your Phone Number',
                            isDense: true,
                            enabled: !on,
                            border: InputBorder.none, // No border
                            counterText: '', // Remove the character counter text
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),*/
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
  String verification="";
  void nowsend (String uid ) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
        Navigator.push(
            context,
            PageTransition(
                child: Home(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 80)));
        Send.message(context, "${AppLocalizations.of(context)!.translate('Hello')} ${user.Name}, ${AppLocalizations.of(context)!.translate('Hello')}", true);
      } else {
        Navigator.push(
            context,
            PageTransition(
                child: SecondForm(email: '',),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 80)));
        Send.message(context, "${AppLocalizations.of(context)!.translate('LookLikeNew')}", true);
      }
    } catch (e) {
      Send.message(context, "$e", false);
      return null;
    }
  }
  Future<UserModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
      // Query the collection based on uid
      QuerySnapshot querySnapshot = await usersCollection.where('uid', isEqualTo: uid).get();
      // Check if a document with the given uid exists
      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document snapshot to a UserModel
        UserModel user = UserModel.fromSnap(querySnapshot.docs.first);
        return user;
      } else {
        // No document found with the given uid
        return null;
      }
    } catch (e) {
      print("Error fetching user by uid: $e");
      return null;
    }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyPhoneNumber(String phoneNumber) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {

    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Phone verification failed: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      String smsCode = '...'; // Get the SMS code from the user.
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      // Sign in with the credential.
      await _auth.signInWithCredential(credential);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto retrieval timeout.
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

}

