import 'package:chessby/aaaaa/global.dart';

import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/state_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import country_state_city package
import 'package:country_state_city/country_state_city.dart' as h;

class Countryy extends StatefulWidget {
  bool justname ;
   Countryy({super.key,required this.justname});

  @override
  State<Countryy> createState() => _CountryyState();
}

class _CountryyState extends State<Countryy> {

  late final List<Country> country;  // This will be a list of Country objects
  late final List<String> states ; // List to store states
  String? selectedCountry; // Store the selected country

  @override
  void initState() {
    super.initState();
    f();
  }

  Future<void> f() async {
    final countries = await h.getAllCountries(); // Assuming this returns List<Country>


    setState(() {
      country = countries;  // Keep the List<Country> as it is for use later
    });

    List<String> countryNames = country.map((country) => country.name).toList();

  }

  bool b = false ;

  String? countryv;
  String? state;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar : AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Center(child: Text("📌  ${AppLocalizations.of(context)!.translate("Choose Your Location")}  📌", style : TextStyle(fontWeight : FontWeight.w700,color: Colors.white))),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/back.png"),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text("👋 ${AppLocalizations.of(context)!.translate("Welcome User")} 👋",
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 23, color: Colors.white)),
              ),
              Center(
                child: Text("${AppLocalizations.of(context)!.translate("We are available in 190+ Countries")}",
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 23, color: Global.yell)),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    "https://cdn.countryflags.com/thumbs/spain/flag-square-250.png",
                    width: 40,
                  ),
                  Image.network(
                    "https://cdn.countryflags.com/thumbs/united-states-of-america/flag-square-250.png",
                    width: 40,
                  ),
                  Image.network(
                    "https://cdn.countryflags.com/thumbs/nigeria/flag-square-250.png",
                    width: 40,
                  ),
                  Image.network(
                    "https://cdn.countryflags.com/thumbs/india/flag-square-250.png",
                    width: 40,
                  ),
                  Image.network(
                    "https://cdn.countryflags.com/thumbs/mexico/flag-square-250.png",
                    width: 40,
                  ),
                  Image.network(
                    "https://cdn.countryflags.com/thumbs/france/flag-square-250.png",
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
                Image.asset("assets/jfjffjm-removebg-preview (1).png"),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          '${AppLocalizations.of(context)!.translate("Your Country")}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        items: country
                            .map((Country item) => DropdownMenuItem<String>(
                          value: item.name,  // Use the country code as the value
                          child: Text(
                            item.name,  // Display the country name
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )).toList(),
                        value: selectedCountry,  // This is the selected country name or code
                        onChanged: (String? value) async {
                          final countryCode = country.firstWhere((item) => item.name == value).isoCode;
                          print(countryCode);
                          final states = await getStatesOfCountry(countryCode);
                          List<String> countryNames = states.map((states) => states.name).toList();
                          print(countryNames);
                          setState(() {
                            selectedCountry = value;
                            ison=true;
                            this.states=countryNames;
                          });
                        },
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4), // Optional: add rounded corners
                          ),
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 400,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 7,),
              ison?lis():SizedBox(),
              SizedBox(height: 7,),
              Visibility(
                visible: ison,
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                          context, PageTransition(
                          child: Countryy(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                      ));
                    },
                    child: Text("${AppLocalizations.of(context)!.translate("Clear Selection")}",style: TextStyle(color:Colors.yellowAccent),)),
              ),
              SizedBox(height : 20),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Visibility(
          visible: b,
          child :    Center(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  color: Global.yell,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // specify the radius for the top-left corner
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    // specify the radius for the top-right corner
                  ),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextButton.icon(
                        onPressed: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('State', state! );
                          Navigator.pop(context);
                        },
                        icon: Icon(CupertinoIcons.location_fill,
                            color: Colors.black),
                        label: Text("${AppLocalizations.of(context)!.translate("Confirm Location ")}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))))),
          ),
        )
      ],
    );
  }
  bool ison=false;
Widget lis(){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                '${AppLocalizations.of(context)!.translate("Your State")}',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              items: states
                  .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
              ))
                  .toList(),
              value: state,
              onChanged: (String? value) {
                setState(() {
                  state = value;
                  b = true ;
                });
              },
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4), // Optional: add rounded corners
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
        
      ),
    );
}

}
