import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../utils/toast_msg.dart';
import '../../my_garage/google_map/google_provider/google_provider.dart';

class ShopDetailsUpdateProvider extends ChangeNotifier{

  var garageNameC = TextEditingController();
  var garageOwnerC = TextEditingController();
  var garageContactC = TextEditingController();
  var garageBioC = TextEditingController();
  var garageAddressC = TextEditingController();
  String imagePath = "";


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
    notifyListeners();
  }

  updateDetail(String id) async {
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    notifyListeners();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(id);
    firebase_storage.UploadTask uploadImage = ref.putFile(File(image!.path.toString()));
    await Future.value(uploadImage).then((value) async {
      isLoading = true;
      var imageUrl = await ref.getDownloadURL();
      fireStore.collection("GarageOwners").doc(userUid).collection("garageDetails").doc(id).update(
          {
            "addDate" : date,
            "garageName" : garageNameC.text,
            "garageOwnerName" : garageOwnerC.text,
            "garageContact" : garageContactC.text,
            "garageBio" : garageBioC.text,
            "garageAddressLatitude" : garageLatitude,
            "garageAddressLongitude" : garageLongitude,
            "imagePath" : imageUrl.toString(),
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
    // var imageUrl = await ref.getDownloadURL();
    // fireStore.collection("GarageOwners").doc(userUid).collection("garageDetails").doc(id).update(
    //     {
    //       "addDate" : date,
    //       "garageName" : garageNameC.text,
    //       "garageOwnerName" : garageOwnerC.text,
    //       "garageContact" : garageContactC.text,
    //       "garageBio" : garageBioC.text,
    //       "garageAddress" : garageAddressC.text,
    //       "imagePath" : imagePath,
    //       "update" : "updated"
    //     }).whenComplete(() {
    //   isLoading = false;
    //   ToastMsg().toastMsg("Data Saved");
    //   notifyListeners();
    // }).onError((error, stackTrace)  {
    //   isLoading = false;
    //   ToastMsg().toastMsg(error.toString());
    //   notifyListeners();
    // });
    notifyListeners();
  }





  getDetail(String id)async{
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    await fireStore.collection("GarageOwners").doc(userUid).collection("garageDetails").doc(id).get().then((value) async {
      imagePath = value.get("imagePath");
      garageNameC.text = value.get("garageName");
      garageOwnerC.text = value.get("garageOwnerName");
      garageContactC.text = value.get("garageContact");
      garageBioC.text = value.get("garageBio");
      garageAddressLat = value.get("garageAddressLatitude");
      garageAddressLong = value.get("garageAddressLongitude");

      List<Placemark> placeMarks = await placemarkFromCoordinates(double.parse(garageAddressLat.toString()), double.parse(garageAddressLong.toString()));
      
      garageAddressC.text = "${placeMarks.reversed.last.subLocality.toString()}  ${placeMarks.reversed.last.subAdministrativeArea.toString()}";

      print(imagePath);
      print(garageNameC);
      print(garageOwnerC);
      print(garageContactC);
      print(garageBioC);
      print(garageAddressC);
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

  deleteDetails(String id)async{
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    notifyListeners();
    await fireStore.collection("GarageOwners").doc(userUid).collection("garageDetails").doc(id).delete().whenComplete(() {
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

}