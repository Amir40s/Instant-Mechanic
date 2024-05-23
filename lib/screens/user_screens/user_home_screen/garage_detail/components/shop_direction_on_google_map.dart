import 'dart:async';

import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/gd_button/garage_detail_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../helpers/colors.dart';
import '../../../../../helpers/input_fields.dart';

class GDOnGoogleMap extends StatefulWidget {
  GDOnGoogleMap({super.key,required this.latitude,required this.longitude});

  double latitude,longitude;

  @override
  State<GDOnGoogleMap> createState() => _GDOnGoogleMapState();
}

class _GDOnGoogleMapState extends State<GDOnGoogleMap> {
  var searchController = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      debugPrint("$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(widget.latitude, widget.longitude),zoom: 14),
        markers: <Marker>{
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow(
              title: "My Position 1",
            ),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
