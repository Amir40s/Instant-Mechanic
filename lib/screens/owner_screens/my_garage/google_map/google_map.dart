import 'dart:async';
import 'dart:convert';

import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  var searchController = TextEditingController();

  List<dynamic> placesList = [];

  var uuid = Uuid();
  String sessionToken = "11223344";

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
    searchController.addListener(() {
      onChanged();
    });
    loadLocation();
  }

  void onChanged(){
    if(sessionToken == null){
      setState(() {
        sessionToken == uuid.v4();
      });
    }
    getSuggestion(searchController.text);
  }

  void getSuggestion(String input)async{
    String kPLACES_API_KEY = "AIzaSyASSCXH-_EFOghA1K9KFmSzaM8cBBrBPWM";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);
    if(response.statusCode == 200){
      setState(() {
        placesList = jsonDecode(response.body.toString())["predictions"];
      });
    }else{
      throw Exception("Failed to Load ");
    }

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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(inputController: searchController,hintText: "Search Places with Name",),
                Expanded(child: ListView.builder(
                    itemCount: placesList.length,
                    itemBuilder: (context,index){
                  return ListTile(
                    title: Text(placesList[index]["description"]),
                  );
                })),
              ],
            ),
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
