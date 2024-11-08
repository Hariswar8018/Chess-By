import 'dart:async';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class MapSample extends StatefulWidget {
  double mlat;
  double mlong;
  String mName;
  String mPic;
  double ulat;
  double ulong;
  String uName;
  String uPic;

  MapSample({super.key, required this.mlat, required this.mlong,
    required this.mName, required this.ulat, required this.ulong,
    required this.uName, required this.uPic, required this.mPic});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text("Find User on MAP")),backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text("You could Find User Location on this Map. This is not a real Time Location, however it is the Latest Location ")),
          Padding(
            padding: const EdgeInsets.only( top: 8.0),
            child: Center(
                child: Text("3 Buttons in Bottom Left", style: TextStyle( fontWeight : FontWeight.w600))
            ),
          ),
          Center(child: Text("With first button, you could easily turn between Satellite and Normal View")),
          Center(child: Text("With second button, you could easily go to User's Location")),
          Center(child: Text("With first button, you could easily go to your Own Locatiob")),

        ],
      ),
      actions: <Widget>[
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
            width: MediaQuery.of(context).size.width - 132,
            child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("I understood",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)))),
      ],
    );
  }

  bool satellite = false ;

  double b =  0;
  double h = 0 ;
  List<LatLng> latlng = [];
  initState() {
    super.initState();
    latlng =[
      LatLng( widget.mlat, widget.mlong ),
      LatLng( widget.ulat,widget.ulong),
    ];

    vq();
    for( int i = 0 ; i < latlng.length ; i ++ ){
      _markers.add(
        Marker(
          markerId: MarkerId("My Location"),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: " Your Location",
          ),
        ),
      );
      _polyline.add(
          Polyline(polylineId: PolylineId("1"), width: 1, startCap: Cap.roundCap, endCap: Cap.buttCap,
              points : latlng,
          ) );
    }
    setState(() {

    });
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<Marker> _marker = [];

  YourClass(double d, double e) {
    final List<Marker> _list = [
      Marker(
        markerId: MarkerId("Your Location"),
        position: LatLng(b, h),
        infoWindow: InfoWindow(
          title: " ${widget.uName} Location",
          snippet: "This is User Location you had to go"
        ),
      ),
      Marker(
        markerId: MarkerId("My Location"),
        position: LatLng( 21.2661556,  87.9088836),
        infoWindow: InfoWindow(
          title: " Your Location",
        ),
      ),
    ];
    _marker.addAll(_list);
  }

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};





  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.2661556, 84.9088836),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  /*void getPolypointd() async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = polylinePoints.getRouteBetweenCoordinates(
      "k",
      MyPointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      MyPointLatLng(destination.latitude, destination.longitude),
    );
  }*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffff79ac),
        title: Text("Locate " + widget.uName),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              icon: Icon(Icons.question_mark))
        ],
      ),
      body: GoogleMap(
        mapType:  satellite ? MapType.satellite : MapType.normal,
        markers : {
          Marker(
            markerId: MarkerId("My Location"),
            position : LatLng( widget.ulat, widget.ulong),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: " ${widget.uName} Location",
              snippet: " This is ${widget.uName} Accurate Location "
            )
          ),
          Marker(
            markerId: MarkerId("Your Location"),
            position : LatLng( widget.mlat, widget.mlong),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet), // Change color
              infoWindow: InfoWindow(
                  title: " ${widget.mName} Location",
                  snippet: " This is your Accurate Location "
              ),
          ),
        },
        polylines: _polyline,
        initialCameraPosition: CameraPosition(
          target: LatLng( widget.mlat , widget.mlong),
          zoom: 14.4746,
        ),
        mapToolbarEnabled: true,
        myLocationButtonEnabled: true, myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    satellite = !satellite ;
                  });
                },
                child: Icon(Icons.satellite_alt, weight : 0.9, color: Colors.white),
                backgroundColor : satellite ?  Colors.red : Colors.blueAccent ,
              ), SizedBox( width : 5),
              FloatingActionButton(
                onPressed: () async {
                  final GoogleMapController controller = await _controller.future;
                  await controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(widget.ulat, widget.ulong),
                          zoom: 19.151926040649414)
                  ));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.uPic),
                  radius: 35,
                ),
                backgroundColor : Colors.transparent,
              ),
              SizedBox( width : 5),
              FloatingActionButton(
                onPressed: () async {
                  final GoogleMapController controller = await _controller.future;
                  await controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(widget.mlat, widget.mlong),
                          zoom: 19.151926040649414)
                  ));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.mPic),
                  radius: 35,
                ),
                backgroundColor : Colors.transparent,
              ),
            ],
          ),
        )
      /*floatingActionButton: CircleFloatingButton.floatingActionButton(
          items: itemsActionBar,
          color: Colors.redAccent,
          icon: Icons.ac_unit,
          duration: Duration(milliseconds: 1000),
          curveAnim: Curves.ease, useOpacity: false,)*/
    );
  }

  Future<void> _goToUser() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(widget.ulat, widget.ulong),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414)
    ));
  }
}
