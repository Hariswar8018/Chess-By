
import 'package:chessby/aaaaa/send.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import '../aaaaa/global.dart';
import 'package:adapty_ui_flutter/adapty_ui_flutter.dart';

import '../l10n/app_localization.dart';

class MyPremium extends StatefulWidget {
  @override
  _MyPremiumState createState() => _MyPremiumState();
}

class _MyPremiumState extends State<MyPremium> {
  @override
  void initState() {

    super.initState();
  }

  Future<void> _showErrorDialog(BuildContext context, String title,
      String message, String? details) {
    return showCupertinoDialog(
      context: context,
      builder: (ctx) =>
          CupertinoAlertDialog(
            title: Text(title),
            content: Column(
              children: [
                Text(message),
                if (details != null) Text(details),
              ],
            ),
            actions: [
              CupertinoButton(
                  child: const Text('OK'),
                  onPressed: () {
                    // close dialog
                    Navigator.pop(ctx);
                    // Navigator.of(context).pop();
                  }),
            ],
          ),
    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("${AppLocalizations.of(context)!.translate("Get ChessBy Premium")}",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/royal-emblem-majestic-chess-king-pristine-white-background_983420-20619-Photoroom.png",
                  width:MediaQuery.of(context).size.width),
              Global.text12("${AppLocalizations.of(context)!.translate("Get ChessBy Premium")}", w),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified,color: Colors.greenAccent,),
                  Text(" ${AppLocalizations.of(context)!.translate("No Ads")}",style: TextStyle(color: Colors.greenAccent,fontSize: 17),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified,color: Colors.greenAccent,),
                  Text(" ${AppLocalizations.of(context)!.translate("Tournament Creation")}",style: TextStyle(color: Colors.greenAccent,fontSize: 17),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified,color: Colors.greenAccent,),
                  Text(" Chess Places Creation",style: TextStyle(color: Colors.greenAccent,fontSize: 17),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.translate("Only € 1")}',
                    style: TextStyle(
                      fontSize: 26,color: Global.yell
                    ),
                  ),
                  SizedBox(height: 10), // Adds space between texts
                  Text(
                    '/ ${AppLocalizations.of(context)!.translate("month")}"  ',
                    style: TextStyle(
                      fontSize: 22,color: Global.yell
                    ),
                  ),
                  SizedBox(height: 10), // Adds space between texts
                  Text(
                    ' € 10 / ${AppLocalizations.of(context)!.translate("month")}',
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,color: Colors.white
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: InkWell(
              onTap: () async {
                try {
                  final paywall = await Adapty().getPaywall(placementId: 'New_Chessby');
                  if (paywall != null) {
                    String g = paywall.name;
                    print(g);
                    final products = await Adapty().getPaywallProducts(paywall: paywall);
                    if (products.isNotEmpty) {
                      final product = products.first;
                      await Adapty().makePurchase(product: product);
                    } else {
                      Send.message(context, '${AppLocalizations.of(context)!.translate("No products found for the paywall.")}"', false);
                      print('No products found for the paywall.');
                    }
                  } else {
                    Send.message(context, '${AppLocalizations.of(context)!.translate("Fail to Fetch Paywall")}', false);
                  }
                } on AdaptyError catch (adaptyError) {
                  Send.message(context, adaptyError.toString(), false);
                } catch (e) {
                  Send.message(context, e.toString(), false);
                }
              },
              child: Global.yellow(w, "${AppLocalizations.of(context)!.translate("Get Premium")}"),)
        ),
      ],
    );
  }
}