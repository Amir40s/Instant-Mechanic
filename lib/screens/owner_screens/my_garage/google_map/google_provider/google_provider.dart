import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

class GoogleProvider extends ChangeNotifier {



  var searchController = TextEditingController();

  List<dynamic> placesList = [];

  var uuid = Uuid();
  String? sessionToken;

  Completer<GoogleMapController> gController = Completer();

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  List<Marker> marker = <Marker>[];

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      debugPrint("$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  saveLocation(context){
    Navigator.pop(context);
  }

  moveLocation(latitude,longitude,index) async {

    searchController.text = placesList[index]["description"];
    notifyListeners();

    kGooglePlex = CameraPosition(
        target: LatLng(latitude,longitude),
        zoom: 14
    );

    marker.add(Marker(
      markerId: MarkerId("1"),
      position: LatLng(latitude,longitude),
      infoWindow: InfoWindow(
        title: "Your Location",
      ),
    ));


    final GoogleMapController controller = await gController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));

    garageLatitude = latitude.toString();
    garageLongitude = longitude.toString();

    notifyListeners();

  }


  onChanged(searchResult){
    if(sessionToken == null){
      sessionToken == uuid.v4();
      notifyListeners();
    }
    getSuggestion(searchResult);
  }

  void getSuggestion(String input)async{
    String kPLACES_API_KEY = "AIzaSyCog7RsE7QqPGoGhJePgBaaXqNbuO8fDAE";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);
    if(response.statusCode == 200){
      placesList = jsonDecode(response.body.toString())["predictions"];
      notifyListeners();
    }else{
      throw Exception("Failed to Load ");
    }

  }

}




// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   searchController.addListener(() {
//     onChanged();
//   });
//   loadLocation();
// }

String garageLatitude = "";
String garageLongitude = "";