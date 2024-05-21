import 'dart:async';

import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/garage_detail_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../helpers/colors.dart';
import '../../../../../helpers/input_fields.dart';

class GDMap extends StatefulWidget {
  const GDMap({super.key});

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  @override
  State<GDMap> createState() => _GDMapState();
}

class _GDMapState extends State<GDMap> {
  var searchController = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> marker = <Marker>[
    // Marker(
    //   markerId: MarkerId("1"),
    //   position: LatLng(31.418715, 73.079109),
    //   infoWindow: InfoWindow(
    //     title: "My Position 1",
    //   ),
    // ),
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
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 100.w,
          child: GoogleMap(
            initialCameraPosition: GDMap._kGooglePlex,
            markers: Set<Marker>.of(marker),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller){
              _controller.complete(controller);
            },
          ),
        ),
        SizedBox(height: 20,),
        GDButton(text: "Get Direction",icon: Icons.directions,),
      ],
    );
  }
}
