import 'dart:async';

import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  var searchController = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  List<Marker> marker = <Marker>[
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(31.418715, 73.079109),
      infoWindow: InfoWindow(
        title: "My Position 1",
      ),
    ),
  ];

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      debugPrint("$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  loadLocation(){
    getUserCurrentLocation().then((value)async{
      debugPrint("${value.latitude.toString()} " "${value.longitude.toString()}");
      debugPrint("My Current Location");
      marker.add(
          Marker(
              markerId: MarkerId("2"),
              position: LatLng(value.latitude,value.longitude),
              infoWindow: InfoWindow(
                  title: "Your Current Location"
              )
          )
      );
      CameraPosition position = CameraPosition(
          target: LatLng(value.latitude,value.longitude),
          zoom: 14
      );
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(position));

      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map"),
        ),
        body: Stack(
          children:[
            GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(marker),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller){
              _controller.complete(controller);
            },
          ),
            InputField(inputController: searchController)
          ]
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: appBarTextColor,
        child: Icon(CupertinoIcons.location_solid,color: appColor,),
          onPressed: ()async{
          loadLocation();
          },
      ),
    );
  }
}
