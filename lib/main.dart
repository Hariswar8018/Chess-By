import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/fight/newfirst.dart';
import 'package:chessby/first_l.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/l10n/l10n.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/providers/declare.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  try {
    await Adapty().activate();
    print("Workinh");
  } on AdaptyError catch (adaptyError) {
    print(adaptyError);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()), // Add LocaleProvider here
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // Access the provider here safely
    final provider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Chess By',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: provider.locale ?? Locale('en'),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate, // Your custom delegate for app localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: user == null
          ? First()
          : FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (ctx, timer) => timer.connectionState == ConnectionState.done
            ? Home() // Screen to navigate to once the splashScreen is done.
            : Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/first.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
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
                child: Global.yellow(w, AppLocalizations.of(context)!.translate("GetStarted"))),
            SizedBox(height: 15,),
            InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>First1()),
                  );
                },
                child: Global.yellowcustom(w,60,Icon(Icons.translate),Colors.white, AppLocalizations.of(context)!.translate("ChangeLanguage"))),
            SizedBox(height: 50,),
          ],
        ),
      )
    );
  }
}


class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  LocaleProvider() {
    _loadLocale(); // Load the saved locale on initialization
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    await _saveLocale(locale.languageCode);
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en'; // Default to English
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> _saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  void clearLocale() async {
    _locale = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('languageCode');
  }
}
