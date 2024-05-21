import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../../../utils/toast_msg.dart';


class GarageProvider extends ChangeNotifier{

  bool isLoading = false;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String stAdd = "";

  firebase_storage.FirebaseStorage firebaseStorage = firebase_storage.FirebaseStorage.instance;

  String date = DateFormat('MMMM/dd/yyyy').format(DateTime.now());
  XFile? image;

  pickImage()async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    image = pickedImage;
    notifyListeners();
  }

  addDetail(String garageNameC,String garageOwnerC,String garageContactC,String garageBioC,String garageAddressC)async{
    var userUid = auth.currentUser!.uid;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    // List<Location> locations = await locationFromAddress(garageAddressC);
    // stAdd = "${locations.last.latitude.toString()} "" ${locations.last.longitude.toString()}";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("/${auth.currentUser!.uid} "" $id");
    firebase_storage.UploadTask uploadImage = ref.putFile(File(image!.path.toString()));
    await Future.value(uploadImage).then((value) async {
      isLoading = true;
      var imageUrl = await ref.getDownloadURL();
      fireStore.collection("GarageOwners").doc(userUid).collection("garageDetails").doc(id).set(
          {
            "addDate" : date,
            "garageName" : garageNameC,
            "garageOwnerName" : garageOwnerC,
            "garageContact" : garageContactC,
            "garageBio" : garageBioC,
            "garageAddress" : garageAddressC,
            // "garageAddressLatitude" : locations.last.latitude.toString(),
            // "garageAddressLongitude" : locations.last.longitude.toString(),
            "id" : id,
            "imagePath" : imageUrl.toString(),
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



}





// getDetails(String garageNameC,String garageOwnerC,String garageContactC,String garageBioC,String garageAddressC){
//   var userUid = auth.currentUser!.uid;
//   String id = DateTime.now().millisecondsSinceEpoch.toString();
//   isLoading = true;
//   fireStore.collection("GarageOwners").doc(userUid).collection("garageDetails").doc(id).set(
//       {
//         "garageName" : garageNameC,
//         "garageOwnerName" : garageOwnerC,
//         "garageContact" : garageContactC,
//         "garageBio" : garageBioC,
//         "garageAddress" : garageAddressC,
//         "id" : id,
//         "imagePath" : image!.path,
//       }).whenComplete(() {
//     isLoading = false;
//     ToastMsg().toastMsg("Data Saved");
//     notifyListeners();
//   }).onError((error, stackTrace)  {
//     isLoading = false;
//     ToastMsg().toastMsg(error.toString());
//     notifyListeners();
//   });
//   notifyListeners();
// }