import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:current_location/model/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:current_location/current_location.dart';
import 'package:geocoding/geocoding.dart' as geocoding ;
import 'package:permission_handler/permission_handler.dart';

class My_Location extends StatefulWidget {
  My_Location({super.key});

  @override
  State<My_Location> createState() => _My_LocationState();
}

class _My_LocationState extends State<My_Location> {
  bool b = false;

  String? country;
  void initState(){
    access();
  }
  Future<void> access() async {
    PermissionStatus fineStatus = await Permission.location.request();
    PermissionStatus coarseStatus = await Permission.locationWhenInUse.request();
    if (fineStatus.isGranted || coarseStatus.isGranted) {
      print("Permission Granted");
    } else {
      Send.message(context, "Permission is Not Granted ! ", false);
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings(); // Open settings to enable location permission
      }
    }
  }
  String? state;
String? sip ;
  String? ip;
  double? lat;
  double? lon;

  String country1 = " ", state1 = " ", sip1 = " ", ip1 = " ", address1 = " ";
  double lat1 = 0.1, lon1 = 0.2 ;

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: !b ? Colors.black :  Color(0xff016d9b),
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text("${AppLocalizations.of(context)!.translate("Location Update")}",
            style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Center(
            child: Text("${AppLocalizations.of(context)!.translate("Only Latitude, Longitude and Address will be stored, Rest of will be deleted as you close the screen")}",
                style: TextStyle(
                    fontFamily: "font1",
                    fontSize: 13,
                    color: Colors.white), textAlign: TextAlign.center),),
              Center(
                child: Text("${AppLocalizations.of(context)!.translate("Remember, To Update your Location frequently")}",
                    style: TextStyle(
                        fontFamily: "font1",
                        fontSize: 13,
                        color: Global.yell)),
              ),
              SizedBox(
                height: 8,
              ),
               !b ? Image.network(height: 350,"https://static.vecteezy.com/system/resources/thumbnails/027/124/960/small_2x/travel-find-a-location-vector-illustration-png.png") : Image.network(
                  "https://i.pinimg.com/originals/98/69/5a/98695a1cb29719ed82a557da2c5ca3fa.gif"),
              SizedBox(height: 20),
              Visibility(
                visible: !b,
                child: Text(
                  "${AppLocalizations.of(context)!.translate("Your Last Location")}",
                  style: TextStyle(
                      fontFamily: "font1", fontSize: 23, color:Global.yell),
                ),
              ),
              Visibility(
                visible: b,
                child: Padding(
                  padding: const EdgeInsets.only(bottom : 8.0),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("Your New Location")}",
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 23, color: Global.yell),
                  ),
                ),
              ),
              Visibility(
                visible: !b,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.translate("Latitude")} : " + _user!.Lat.toString(),
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("Longitude")} : " + _user!.Lon.toString(),
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 14, color: Colors.white),
                      ),
                    ]),
              ),
              Visibility(
                visible: b,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.translate("Latitude")} : " + lat1.toString(),
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("Longitude")} : " + lon1.toString(),
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 14, color: Colors.white),
                      ),
                    ]),
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: !b,
                child: Text(
                  "${AppLocalizations.of(context)!.translate("Your Last Address")}",
                  style: TextStyle(
                      fontFamily: "font1", fontSize: 17, color: Colors.white),
                ),
              ),
              Visibility(
                visible: !b,
                child: Text(
                  _user!.Location,
                  style: TextStyle(
                      fontFamily: "font1", fontSize: 14, color: Colors.white),
                ),
              ),
              Visibility(
                visible : b,
                child : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Country : " + country1,
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("State")} : " + state1,
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 15, color: Colors.white),
                      ),
                    ]
                )
              ),
              Visibility(
                  visible : b,
                  child : Padding(
                    padding: const EdgeInsets.only( top : 10.0),
                    child: Text(
                            "${AppLocalizations.of(context)!.translate("IP Address")} : " + ip1 ,
                            style: TextStyle(
                                fontFamily: "font1", fontSize: 14, color: Colors.white),
                          ),
                  ),
              ),
              Visibility(
                visible: b,
                child: Text(
                      "${AppLocalizations.of(context)!.translate("Your New Address")}",
                  style: TextStyle(
                      fontFamily: "font1", fontSize: 17, color: Colors.white),
                ),
              ),
              Visibility(
                visible: b,
                child: Container(
                  height: 20,
                  child: Text(
                    address1,
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
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
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                    onPressed: () async {
                      if(b){
                        Navigator.pop(context);
                        return ;
                      }

                      await access(); // Request location permissions

                      try {
                        // Check and request location permissions
                        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                          throw 'Location services are disabled.';
                        }

                        LocationPermission permission = await Geolocator.checkPermission();
                        if (permission == LocationPermission.denied) {
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                            throw 'Location permissions are denied.';
                          }
                        }
                        if (permission == LocationPermission.deniedForever) {
                          throw 'Location permissions are permanently denied.';
                        }
                        Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high,
                        );

                        double lat = position.latitude;
                        double lon = position.longitude;

                        // Reverse geocoding to get the address
                        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
                        String address="",countryy = "",statee="",ippp;
                        if (placemarks.isNotEmpty) {
                          Placemark placemark = placemarks.first;
                          address = "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.isoCountryCode}";
                          countryy=placemark.country!;
                          statee=placemark.administrativeArea!;
                          ippp=placemark.postalCode!.toString();
                        }
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "Lat": lat,
                          "Lon": lon,
                          "Location": address,
                        });

                        setState(() {
                          b = true;
                          lat1 = lat;
                          lon1 = lon;
                          address1 = address;
                          country=countryy;
                          state=statee;
                        });
                        Send.message(context, 'Location Updated Successfully', true);
                      }  catch (e) { Send.message(context, 'Error fetching location: $e', true);
                      }
                    },
                    child: b ? Text(" ${AppLocalizations.of(context)!.translate("Continue")} ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)) :
                    Text(" ${AppLocalizations.of(context)!.translate("Fetch My Location Now")} ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))
                ))),
      ],
    );
  }
}
