import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/fight/newfirst.dart';
import 'package:chessby/first/onboarding.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/providers/declare.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// ...
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  User? user = FirebaseAuth.instance.currentUser ;
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: MaterialApp(
      title: 'chessby Be',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('he', ''),
        Locale('es', ''),
        Locale('ru', ''),
        Locale('ko', ''),
        Locale('hi', ''),
      ],
      home: user == null ?  First():FutureBuilder(
          future: Future.delayed(Duration(seconds: 3)),
          builder: (ctx, timer) =>
          timer.connectionState == ConnectionState.done
              ?  Home() //Screen to navigate to once the splashScreen is done.
              : Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/first.jpg"),
                    fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    ),/*home: user == null ?  TestScreen() : Home(),*/
    );
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      body:Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/first.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: First2(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 80)));
                },
                child: Global.yellow(w, "Get Started")),
            SizedBox(height: 50,),
          ],
        ),
      )
    );
  }
}

