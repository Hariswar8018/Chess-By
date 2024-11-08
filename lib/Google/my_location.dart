import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:current_location/model/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:current_location/current_location.dart';
import 'package:geocoding/geocoding.dart' as geocoding ;

class My_Location extends StatefulWidget {
  My_Location({super.key});

  @override
  State<My_Location> createState() => _My_LocationState();
}

class _My_LocationState extends State<My_Location> {
  bool b = false;

  String? country;

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
      backgroundColor: !b ? Colors.white :  Color(0xff016d9b),
      appBar: AppBar(
        backgroundColor: Color(0xffff79ac),
        automaticallyImplyLeading: true,
        title: Text("Location Update📌",
            style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
      Center(
        child: Text("Only Latitude, Longitude and Address will be stored, Rest of will be deleted as you close the screen",
            style: TextStyle(
                fontFamily: "font1",
                fontSize: 13,
                color: Colors.white), textAlign: TextAlign.center),),
          Center(
            child: Text("Remember, To Update your Location frequently",
                style: TextStyle(
                    fontFamily: "font1",
                    fontSize: 13,
                    color: Color(0xffff79ac))),
          ),
          SizedBox(
            height: 8,
          ),
           !b ? Image.network("https://img.freepik.com/premium-vector/cartoon-illustration-location-symbol-with-question-mark_152558-90804.jpg") : Image.network(
              "https://i.pinimg.com/originals/98/69/5a/98695a1cb29719ed82a557da2c5ca3fa.gif"),
          SizedBox(height: 20),
          Visibility(
            visible: !b,
            child: Text(
              "Your Last Location",
              style: TextStyle(
                  fontFamily: "font1", fontSize: 23, color: Color(0xffff79ac)),
            ),
          ),
          Visibility(
            visible: b,
            child: Padding(
              padding: const EdgeInsets.only(bottom : 8.0),
              child: Text(
                "Your New Location",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 23, color: Color(0xffff79ac)),
              ),
            ),
          ),
          Visibility(
            visible: !b,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Latitude : " + _user!.Lat.toString(),
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 14, color: Colors.black),
                  ),
                  Text(
                    "Longitude : " + _user!.Lon.toString(),
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 14, color: Colors.black),
                  ),
                ]),
          ),
          Visibility(
            visible: b,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Latitude : " + lat1.toString(),
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 14, color: Colors.black),
                  ),
                  Text(
                    "Longitude : " + lon1.toString(),
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 14, color: Colors.black),
                  ),
                ]),
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: !b,
            child: Text(
              "Your Last Address",
              style: TextStyle(
                  fontFamily: "font1", fontSize: 17, color: Colors.black),
            ),
          ),
          Visibility(
            visible: !b,
            child: Text(
              _user!.Location,
              style: TextStyle(
                  fontFamily: "font1", fontSize: 14, color: Colors.black),
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
                        fontFamily: "font1", fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    "State : " + state1,
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 15, color: Colors.black),
                  ),
                ]
            )
          ),
          Visibility(
              visible : b,
              child : Padding(
                padding: const EdgeInsets.only( top : 10.0),
                child: Text(
                        "IP Address : " + ip1 ,
                        style: TextStyle(
                            fontFamily: "font1", fontSize: 14, color: Colors.black),
                      ),
              ),
          ),
            Visibility(
                visible : b,
                child : Padding(
                  padding: const EdgeInsets.only( top : 10.0, bottom : 10),
                  child: Text(
                    "Telecom Network : " + sip1,
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 14, color: Colors.black),
                  ),
                ),
          ),
          Visibility(
            visible: b,
            child: Text(
              "Your New Address",
              style: TextStyle(
                  fontFamily: "font1", fontSize: 17, color: Colors.black),
            ),
          ),
          Visibility(
            visible: b,
            child: Container(
              height: 20,
              child: Text(
                address1,
                style: TextStyle(
                    fontFamily: "font1", fontSize: 14, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
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
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                    onPressed: () async {
                      try {
                        final Location? userLocation =
                            await UserLocation.getValue();
                        country = userLocation!.country;
                        state = userLocation.regionName;
                        ip = userLocation.currentIP;
                        sip = userLocation.isp ;
                        lat = userLocation.latitude;
                        lon = userLocation.longitude;
                        print(state);
                        String address = " ";
                        List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat!, lon!);

                        if (placemarks != null && placemarks.isNotEmpty) {
                          geocoding.Placemark placemark = placemarks.first;

                          // Access the address components
                           address = "${placemark.street}, ${placemark.locality}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.isoCountryCode}";
                          print("User's address: $address");
                        }
                        String s = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(s)
                            .update({
                          "Lat": lat,
                          "Lon": lon,
                          "Location" : address ,
                        });
                        setState(() {
                          b =  true ;
                          sip1 = sip ?? "hh" ;
                          lat1 = lat ?? 0.1 ;
                          lon1 = lon ?? 0.2 ;
                          ip1 = ip ?? "y";
                          address1 = address ;
                          country1 = country ?? "y" ;
                          state1 = state ?? "fr" ;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('SUCCESS'),
                            duration: Duration(seconds: 2),
                            // Duration for how long the Snackbar will be visible
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                // Add your action here
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(); // Hides the current Snackbar
                              },
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${e}'),
                            duration: Duration(seconds: 2),
                            // Duration for how long the Snackbar will be visible
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                // Add your action here
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(); // Hides the current Snackbar
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: b ? Text(" Fetch My Location Once Again ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)) :
                    Text(" Fetch My Location Now ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))
                ))),
      ],
    );
  }
}
