import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_cloud_messaging_flutter/firebase_cloud_messaging_flutter.dart';
// import 'package:firebase_cloud_messaging_flutter/firebase_cloud_messaging_flutter.dart';
import 'package:flutter/material.dart';

class Send{
  static void message(BuildContext context,String str, bool green) async{
    await Flushbar(
      titleColor: Colors.white,
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.linear,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: green?Colors.green:Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundGradient: green?LinearGradient(colors: [Colors.green, Colors.green.shade400]):LinearGradient(colors: [Colors.red, Colors.redAccent.shade400]),
      isDismissible: false,
      duration: Duration(seconds: 3),
      icon: green? Icon(
        Icons.verified,
        color: Colors.white,
      ): Icon(
        Icons.warning,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.white,
      messageText: Text(
        str,
        style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
    ).show(context);
  }
  static void topic(BuildContext context,String str1,String str) async{
    await Flushbar(
      titleColor: Colors.white,
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.linear,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundGradient: LinearGradient(colors: [Colors.red, Colors.redAccent.shade400]),
      isDismissible: false,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.warning,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.white,
      titleText:  Text(
        str1,
        style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.w700, fontFamily: "ShadowsIntoLightTwo"),
      ),
      messageText: Text(
        str,
        style: TextStyle(fontSize: 14.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
    ).show(context);
  }

  static Future<void> sendNotificationsToTokens(String name, String desc,String tokens) async {
    var server = FirebaseCloudMessagingServer(
      serviceAccountFileContent,
    );

    var result = await server.send(
      FirebaseSend(
        validateOnly: false,
        message: FirebaseMessage(
          notification: FirebaseNotification(
            title: name,
            body: desc,
          ),
          android: FirebaseAndroidConfig(
            ttl: '3s', // Optional TTL for notification
            /// Add Delay in String. If you want to add 1 minute delay then add it like "60s"
            notification: FirebaseAndroidNotification(
              icon: 'ic_notification', // Optional icon
              color: '#009999', // Optional color
            ),
          ),
          token: tokens, // Send notification to specific user's token
        ),
      ),
    );

    // Print request response
    print(result.toString());
  }

  static final serviceAccountFileContent = <String, String>{
    'type': "service_account",
    'project_id':"smartlancer-660d4",
    'private_key_id':  "9522b3ce5f20a01d5f43e93e07e94c81aa8a566e",
    'private_key': "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDC2JNjRJB56NFi\nZLljimeeOiDiHp7o8hCGrzmR9czUnYLzjpL2XEW8tZFaNflMK2s4nJzImF2xKnqq\nWPEg7lH54XMb75QVzIox+2pU7lLHsjZBRv3oqiAZl9FDV7Ku1L/9nJ7Syh6/ur8q\nSeR5HWwrfDFrX2WGKnQy/XbmEzho/RpNyVloYVomgyu7sZnN9f/tRSG+UJdvAKme\n8Od8aDSEoOWgXYVUFVfkXYGqllklCAVFarqC3LTxRvTVIMQNvlegBETkvru0iP/5\n0brgxUTOhOSScmWpxk6S16eUT6xs1788rx/16XRMMDwkI/o/XLJmbVcbOYCADFfp\nXaRKPNLLAgMBAAECggEAWiMy2+NmKt+HrcsG8IOgt9QQTkr4HK+O8Z+yNFHPtjQ/\n1kiIuCurn0cnvOHnOFOFwKTC6xGBlmoeYRvQQPm/NqgTRkMo8IS1EbZLVIsEBJnu\n+3fKEo5RV0Wia1LwuGx3fO2tk7opS20q7ndMmLMBzYQgoJl7L/wH0WbsUDdoCzjs\n7X6w5krPdLcls84IrSbIa9kYIfPySCWcdvJOmoIWSc2DDbl/OdfIoOZZkCPavbFu\n7yPnf4jlb7xpEekiV06r9fbT/l17F6NCG/IdkQGCxSv0TC4Jc9BB8Sa4K6VFEJbX\niZtS7LX/ELkGgycRO4k7OqvCkeemUoS/3zRpgmIDEQKBgQDl+RHcZ4MivaobhJv9\nWgR3ISEumg5dl8hur17c2uNWviaGeT7uv6FlGOxiK/xlbgENiF6edhdycMIM77iQ\nBRyDQWUrbrTeWLZdU2urUa2alQzac0SkZvS2OyDiF9maRRGDUL9r3MgMWv/JAmyo\n7ndBfkNmxf9qRIUjg0ILex0WRQKBgQDY5cjyYZYKbMLAT8bCNCWAVNVN2nEr8P25\n6M8Ty0a/LQEyDWUaYHKCTNxSbG9nkW8O1gAL4FGjf9hOo06ZdQ8qnAkE6mYgZKtB\nZpQMy/rw4G5ZuqTIQPaqYjZlre4NPgQkpYqTYvBMcWZLRnvrpa9th7oZJzka/lF3\nAREJPYodzwKBgQCDJ4kIKgCfz4s0JmzQEIZ7ammCKloHBolIlruDOVJuJgPSrVM2\n1hM1lQE6+9r1/cab8SoFNVQp8CS7O/wGJuQb9y+7lWeRZwaaMvk0u2BGyLqL2zFK\nkWz+gLpAN1nioYFbYrHI0iFE6qD2Amv17AoXT+sgscr40BseJb2EzrHIAQKBgQDN\npgFDHxedxsVYhctUMxEjfkvIR0dqfFJ1xLEieWgYt1kc1ep4ed3YgXucgseWESSV\nkn30xLljJkI3PUu24HCC2/MJQB2YtRpTJilVgMnrPUAjv32hiUbXAcvF2IWO9LAE\n9xhO6k4gjJyK3sd8BFoypa/jTXctitg+1zoJ4tljrQKBgG6AKzqdrp0SZfYFqULJ\nlwENWg/heHFG+4wst6DAcLkeEGJTld4XTRaxJe/eNDJBzgkoQ2+3ZFCPYPO9huhV\nOGLt7+Lgvb7WUyIBbdFq+BJUwEbllbPSn2SDF/zBcnPm0lYhxJORa85cJxrX88zt\nSs2M6e7ZBeoLM1XSUADMPou6\n-----END PRIVATE KEY-----\n",
    'client_email':"firebase-adminsdk-k4h7w@smartlancer-660d4.iam.gserviceaccount.com",
    'client_id':"111145497066660011334",
    'auth_uri':"https://accounts.google.com/o/oauth2/auth",
    'token_uri':  "https://oauth2.googleapis.com/token",
    'auth_provider_x509_cert_url':  "https://www.googleapis.com/oauth2/v1/certs",
    'client_x509_cert_url': "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-k4h7w%40smartlancer-660d4.iam.gserviceaccount.com",
  };
}