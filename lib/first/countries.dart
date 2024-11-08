import 'package:chessby/first/signup.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Country extends StatefulWidget {
  bool justname ;
  Country({super.key, required this.justname});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final List<String> country = [
    'United States of America',
    'Spain',
    'India',
    'France',
    'Mexico',
    'Nigeria',
  ];

  bool b = false ;

  String? countryv;

  final List<String> usa = [
    'Alabama',
    ' Alaska',
    ' Arizona',
    ' Arkansas',
    ' California',
    ' Colorado',
    ' Connecticut',
    ' Delaware',
    ' Florida',
    ' Georgia',
    ' Hawaii',
    ' Idaho',
    ' Illinois',
    ' Indiana',
    ' Iowa',
    ' Kansas',
    ' Kentucky',
    ' Louisiana',
    ' Maine',
    ' Maryland',
    ' Massachusetts',
    ' Michigan',
    ' Minnesota',
    ' Mississippi',
    ' Missouri',
    ' Montana',
    ' Nebraska',
    ' Nevada',
    ' New Hampshire',
    ' New Jersey',
    ' New Mexico',
    ' New York',
    ' North Carolina',
    ' North Dakota',
    ' Ohio',
    ' Oklahoma',
    ' Oregon',
    ' Pennsylvania',
    ' Rhode Island',
    ' South Carolina',
    ' South Dakota',
    ' Tennessee',
    ' Texas',
    ' Utah',
    ' Vermont',
    ' Virginia',
    ' Washington',
    ' West Virginia',
    ' Wisconsin',
    ' Wyoming'
  ];

  String? ustate;
  String? istate;
  String? sstate;
  String? mstate;
  String? nstate;
  String? fstate;
  String? state;

  final List<String> spain = [
    'Andalusia',
    'Aragon',
    'Asturias',
    'Balearic Islands',
    'Basque Country',
    'Canary Islands',
    'Cantabria',
    'Castilla-La Mancha',
    'Castilla y León',
    'Catalonia',
    'Extremadura',
    'Galicia',
    'Madrid',
    'Murcia',
    'Navarre',
    'La Rioja',
    'Valencian Community',
  ];
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  final List<String> india = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  final List<String> france = [
    "Auvergne-Rhône-Alpes",
    "Bourgogne-Franche-Comté",
    "Brittany",
    "Centre-Val de Loire",
    "Corsica",
    "Grand Est",
    "Hauts-de-France",
    "Île-de-France",
    "Normandy",
    "Nouvelle-Aquitaine",
    "Occitanie",
    "Pays de la Loire",
    "Provence-Alpes-Côte d'Azur",
  ];

  final List<String> nigeria = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
    "Federal Capital Territory",
  ];

  final List<String> mexico = [
    "Aguascalientes",
    "Baja California",
    "Baja California Sur",
    "Campeche",
    "Chiapas",
    "Chihuahua",
    "Coahuila",
    "Colima",
    "Durango",
    "Guanajuato",
    "Guerrero",
    "Hidalgo",
    "Jalisco",
    "Mexico City",
    "Mexico State",
    "Michoacán",
    "Morelos",
    "Nayarit",
    "Nuevo León",
    "Oaxaca",
    "Puebla",
    "Querétaro",
    "Quintana Roo",
    "San Luis Potosí",
    "Sinaloa",
    "Sonora",
    "Tabasco",
    "Tamaulipas",
    "Tlaxcala",
    "Veracruz",
    "Yucatán",
    "Zacatecas",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar : AppBar(
        backgroundColor: Color(0xffff79ac),
        automaticallyImplyLeading: false,
        title: Center(child: Text("📌  Choose Your Location  📌", style : TextStyle(fontWeight : FontWeight.w700))),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("👋 Welcome User 👋",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 23, color: Colors.black)),
          ),
          Center(
            child: Text("We are available in 6+ Countries",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 23, color: Color(0xffff79ac))),
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
            height: 8,
          ),
            Image.asset("assets/WhatsApp Image 2023-11-30 at 22.22.03_62fbf90a.jpg"),
            SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Your Country',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                items: country
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ))
                    .toList(),
                value: countryv,
                onChanged: (String? value) {
                  setState(() {
                    countryv = value;
                    b = false ;
                  });
                },
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
          ListL(),
          SizedBox(height : 20),
          Visibility(
            visible: b,
            child :    Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    color: Color(0xffff79ac),
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

                            if(widget.justname){
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('State', state! );
                              Navigator.push(
                                  context, PageTransition(
                                  child: Home(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                              ));
                            }else{
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: SignUp(h: state!,),
                                      type: PageTransitionType.leftToRight,
                                      duration: Duration(milliseconds: 800)));
                            }
                          },
                          icon: Icon(CupertinoIcons.location_fill,
                              color: Colors.black),
                          label: Text("Confirm Location ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))))),
            ),
          )
        ],
      ),
    );
  }

  Widget ListL() {
    if (countryv == "India") {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Your State',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              items: india
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ))
                  .toList(),
              value: istate,
              onChanged: (String? value) {
                setState(() {
                  istate = value;
                  state = value!;
                  b = true ;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for a State...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
            ),
          ),
        ),
      );
    } else if (countryv == "Mexico") {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Your State',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              items: mexico
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ))
                  .toList(),
              value: mstate,
              onChanged: (String? value) {
                setState(() {
                  mstate = value;
                  state = value;
                  b = true ;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an State...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
            ),

          ),
        ),
      );
    } else if( countryv == "Nigeria"){
      return Container(
        child : Padding(
          padding:  EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Your State',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              items: nigeria.map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              value : nstate,
              onChanged: (String? value) {
                setState(() {
                  nstate = value;
                  print(nstate);
                  b = true ;
                  state = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an State...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
            ),
          ),
        ),
      );
    }else if ( countryv == "Spain"){
      return Container(
        child : Padding(
          padding:  EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Your State',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              items: spain.map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              )).toList(),
    value : sstate,
              onChanged: (String? value) {
                setState(() {
                  sstate = value;
                  state = value;
                  b = true ;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for a State...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
            ),
          ),
        ),
      );
    }else if ( countryv == "United States of America"){
      return Container(
        child : Padding(
          padding:  EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Your State',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              items: usa.map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              value : ustate,
              onChanged: (String? value) {
                setState(() {
                  ustate = value;
                  state = value;
                  b = true ;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for a State...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
            ),
          ),
        ),
      );
    }else if ( countryv == "France"){
      return Container(
        child : Padding(
          padding:  EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Your State',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              items: france.map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ))
                  .toList(),
              value : fstate,
              onChanged: (String? value) {
                setState(() {
                  fstate = value;
                  b = true ;
                  state = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for a State...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        child : SizedBox( width : 10),
      );
    }
  }
}
