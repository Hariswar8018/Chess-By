import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/club_full_card.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/administration/all_block.dart';
import 'package:chessby/main%20page/administration/create_place.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/storage.dart';
import 'package:chessby/subpages_messages_club/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:place_picker_google/place_picker_google.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:io' show Platform;
// Only to control hybrid composition and the renderer in Android
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:place_picker_google/place_picker_google.dart';

class Administration extends StatelessWidget {
  const Administration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,  // Set the background color here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "   ${AppLocalizations.of(context)!.translate("Admintration Section")}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     ${AppLocalizations.of(context)!.translate("only for Adminstration & Admin Work")} ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 80,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Blocks(str: "bvh")),
              );
            },
            leading: Icon(Icons.admin_panel_settings,color: Colors.white,size: 35,),
            title: Text("${AppLocalizations.of(context)!.translate("Check All Users")}",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
            subtitle: Text("${AppLocalizations.of(context)!.translate("Administrate Users and move")}",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Hist()),
              );
            },
            leading: Icon(Icons.factory,color: Colors.white,size: 35,),
            title: Text("${AppLocalizations.of(context)!.translate("Check All ChessBy Places")}",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
            subtitle: Text("${AppLocalizations.of(context)!.translate("Administrate ChessBy Places & Manage")}",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white),),
          ),
          SizedBox(height: 10,),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Choose(),
                ),
              ).then((result) {
                if (result != null) {
                  // `result` contains the selected location data
                  final location = result['location'];
                  final state = result['state'];
                  final latitude = result['latitude'];
                  final longitude = result['longitude'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Create_Chess(Lon: longitude.toString(), Address: location, Lat: latitude.toString(), Statee: state,),
                    ),
                  );
                  debugPrint("Location: $location");
                  debugPrint("State: $state");
                  debugPrint("Latitude: $latitude");
                  debugPrint("Longitude: $longitude");
                }
              });

            },
            leading: Icon(Icons.email,color: Colors.white,size: 35,),
            title: Text("${AppLocalizations.of(context)!.translate("Add Chess Places")}",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
              subtitle: Text("${AppLocalizations.of(context)!.translate("Add Chess Place & Invite Later")}",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white),),
          )
        ],
      ),
    );
  }
}

class Choose extends StatelessWidget {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PlacePicker(
        mapsBaseUrl: "https://maps.googleapis.com/maps/api/",
        usePinPointingSearch: true,
        apiKey: "AIzaSyABt5VNuIdaU0DOjQG6fzB81Z1EPWXtjYg",
        onPlacePicked: (LocationResult result) {
          debugPrint("Place picked: ${result.formattedAddress}");

          // Extract data
          final location = result.formattedAddress ?? "Unknown Location";
          final state = result.administrativeAreaLevel1!.longName??"";
          final latitude = result.latLng?.latitude ?? 0.0;
          final longitude = result.latLng?.longitude ?? 0.0;
          Navigator.of(context).pop({
            "location": location,
            "state": state,
            "latitude": latitude,
            "longitude": longitude,
          });
        },
        enableNearbyPlaces: false,
        showSearchInput: true,
        initialLocation: const LatLng(
          40.43380006569918,
          -3.7373923882842064,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          mapController = controller;
        },
        searchInputConfig: const SearchInputConfig(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          autofocus: false,
          textDirection: TextDirection.ltr,
        ),
        searchInputDecorationConfig: const SearchInputDecorationConfig(
          hintText: "Search for a building, street or ...",
        ),
        autocompletePlacesSearchRadius: 150,
      ),
    );
  }

  void showPlacePicker(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PlacePicker(
            mapsBaseUrl: kIsWeb
                ? 'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/'
                : "https://maps.googleapis.com/maps/api/",
            usePinPointingSearch: true,
            apiKey: "AIzaSyABt5VNuIdaU0DOjQG6fzB81Z1EPWXtjYg",
            onPlacePicked: (LocationResult result) {
              debugPrint("Place picked: ${result.formattedAddress}");
              Navigator.of(context).pop();
            },
            enableNearbyPlaces: false,
            showSearchInput: true,
            initialLocation: const LatLng(
              29.378586,
              47.990341,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              mapController = controller;
            },
            searchInputConfig: const SearchInputConfig(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              autofocus: false,
              textDirection: TextDirection.ltr,
            ),
            searchInputDecorationConfig: const SearchInputDecorationConfig(
              hintText: "Search for a building, street or ...",
            ),
            // selectedPlaceWidgetBuilder: (ctx, state, result) {
            //   return const SizedBox.shrink();
            // },
            autocompletePlacesSearchRadius: 150,
          );
        },
      ),
    );
  }
}

class Hist extends StatelessWidget {
  Hist({super.key});

  List<ClubModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,  // Set the background color here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "   ${AppLocalizations.of(context)!.translate("Block Persons")}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     ${AppLocalizations.of(context)!.translate("Here are all the Block Persons")} ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 80,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.translate("No Block / Passed Users")}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate("We will still wait for someone you would block or Pass")}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }

          final data = snapshot.data?.docs;
          _list.clear();
          _list.addAll(data?.map((e) => ClubModel.fromJson(e.data())).toList() ?? []);
          return ListView.builder(
            itemCount: _list.length,
            padding: EdgeInsets.only(top: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatUsetrr(user: _list[index],);
            },
          );
        },
      ),
    );
  }
}

class ChatUsetrr extends StatelessWidget {
  ClubModel user;
   ChatUsetrr({super.key,required this.user});
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Global.blac,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        child: Club_Full(user:user, names :"Admin"),
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 400)));
              },
              onLongPress: () async {
                try{
                  Uint8List? _file = await pickImage(ImageSource.gallery);
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Uploading")}.........", true);
                  String photoUrl =  await StorageMethods().uploadImageToStorage('chessplaces', _file!, true);
                  await FirebaseFirestore.instance.collection("clubs").doc(user.uid).update({
                    "Pic_link":photoUrl,
                  });
                  Send.message(context, "${AppLocalizations.of(context)!.translate("Uploaded")}", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }
              },
              tileColor:Global.blac,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.Pic_link),
              ),
              title: Text(user.Name, style : TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: Colors.white)),
              trailing: Text(user.Clublist.length.toString()+" users", style : TextStyle(fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white)),
              subtitle: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Report ',
                      style: TextStyle(fontSize: 12,color: Colors.white),
                    ),
                    TextSpan(
                      text: "${user.blocks.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                      onTap:(){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text('Data Will be Deleted Permanently? Are you sure?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Action for Cancel button
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance.collection("clubs").doc(user.uid).delete();
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: sa("Delete Club",true)),
                  InkWell(
                      onTap: () async {
                        try{
                          String uidToSearch = user!.uid; // Replace with the actual uid you want to search
                          UserModel? user2 = await getUserByUid(uidToSearch);
                          if (user2 != null) {
                            print("User found: His Name }");
                            Navigator.push(
                                context, PageTransition(
                                child: ChatPage(user: user2,), type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 300)
                            ));
                          } else {
                            Navigator.pop(context);
                            Send.message(context, "${AppLocalizations.of(context)!.translate("No Host Found with Error")}", false);
                            print("User not found");
                          }
                        }catch(e){
                          Navigator.pop(context);
                          Send.message(context, "$e", false);
                          print(e);
                        }
                      },
                      child: sa("Contact Admin",true)),
                  InkWell(
                      onTap:() async {
                        if(user.status=="Active"){
                          await FirebaseFirestore.instance.collection("clubs").doc(user.uid).update({
                            "status":"Rejected",
                          });
                        }else{
                          await FirebaseFirestore.instance.collection("clubs").doc(user.uid).update({
                            "status":"Active",
                          });
                        }
                      },
                      child: sa("Active",user.status=="Active")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<UserModel?> getUserByUid(String uid) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

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
  Widget sa(String st,bool yui){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color:yui?Colors.yellowAccent.withOpacity(0.3):Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(st, style: TextStyle(fontSize: 13, color: Colors.white)),
        ),
      ),
    );
  }
}
