import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

import '../../../../utils/toast_msg.dart';
import '../../my_garage/google_map/google_provider/google_map_provider.dart';

class ShopDetailsUpdateProvider extends ChangeNotifier{

  bool suggestions = false;

  Completer<GoogleMapController> gController = Completer();

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  var searchController = TextEditingController();

  List<dynamic> placesList = [];

  var uuid = Uuid();
  String? sessionToken;

  var garageNameC = TextEditingController();
  var garageOwnerC = TextEditingController();
  var garageContactC = TextEditingController();
  var garageBioC = TextEditingController();
  var garageAddressC = TextEditingController();
  String imagePath = "";
  String userUid = "";
  String userName = "";


  bool isLoading = false;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String garageAddressLat = "";
  String garageAddressLong = "";

  String date = DateFormat('MMMM/dd/yyyy').format(DateTime.now());
  XFile? image;


  pickImage()async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery,);
    image = pickedImage;
    imagePath = image!.path.toString();
    notifyListeners();
  }

  updateDetail(String id) async {
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    notifyListeners();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(id);
    firebase_storage.UploadTask uploadImage = ref.putFile(File(image!.path.toString()));

    debugPrint(imagePath);
    await Future.value(uploadImage).then((value) async {
      isLoading = true;
      var imageUrl = await ref.getDownloadURL();
      fireStore.collection("GarageDetails").doc(id).update(
          {
            "addDate" : date,
            "garageName" : garageNameC.text,
            "garageOwnerName" : garageOwnerC.text,
            "garageContact" : garageContactC.text,
            "garageBio" : garageBioC.text,
            "garageAddressLatitude" : garageAddressLat,
            "garageAddressLongitude" : garageAddressLong,
            "imagePath" : imageUrl.toString(),
            "userUid" : userUid,
            "update" : "updated"
          }).whenComplete(() {
        isLoading = false;
        ToastMsg().toastMsg("Data Saved");
        notifyListeners();
      }).onError((error, stackTrace)  {
        isLoading = false;
        ToastMsg().toastMsg(error.toString());
        notifyListeners();
      });
    });
    notifyListeners();
  }

  getDetail(String id)async{
    debugPrint(imagePath);
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    await fireStore.collection("GarageDetails").doc(id).get().then((value) async {
      imagePath = value.get("imagePath");
      garageNameC.text = value.get("garageName");
      garageOwnerC.text = value.get("garageOwnerName");
      garageContactC.text = value.get("garageContact");
      garageBioC.text = value.get("garageBio");
      garageAddressLat = value.get("garageAddressLatitude");
      garageAddressLong = value.get("garageAddressLongitude");
      userUid = value.get("userUid");


      List<Placemark> placeMarks = await placemarkFromCoordinates(double.parse(garageAddressLat.toString()), double.parse(garageAddressLong.toString()));
      garageAddressC.text = "${placeMarks.reversed.last.subLocality.toString()}  ${placeMarks.reversed.last.subAdministrativeArea.toString()}";

      // debugPrint(imagePath);
      // debugPrint("$garageNameC");
      // debugPrint("$garageOwnerC");
      // debugPrint("$garageContactC");
      // debugPrint("$garageBioC");
      // debugPrint("$garageAddressC");
      kGooglePlex = CameraPosition(target: LatLng(double.parse(garageAddressLat), double.parse(garageAddressLong)),zoom: 14);
      notifyListeners();
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  getUserName() async {
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    await fireStore.collection("GarageOwners").doc(userUid).get().then((value) async {
      userName = value.get("name");
    });
  }

  deleteDetails(String id)async{
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    notifyListeners();
    await fireStore.collection("GarageDetails").doc(id).delete().whenComplete(() {
      Get.back();
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  saveLocation(context){
    Navigator.pop(context);
    // marker.clear();
    notifyListeners();
  }

  moveLocation(latitude,longitude,index) async {

    garageAddressLat = latitude.toString();
    garageAddressLong = longitude.toString();
    notifyListeners();
    // debugPrint("=============${marker.length}=============");

    garageAddressC.text = placesList[index]["description"];
    searchController.text = placesList[index]["description"];
    notifyListeners();

    kGooglePlex = CameraPosition(
        target: LatLng(latitude,longitude),
        zoom: 14
    );
    GoogleMapController controller = await gController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 14
        )
    ));
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