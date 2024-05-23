import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../../../utils/toast_msg.dart';
import '../google_map/google_provider/google_map_provider.dart';


class GarageProvider extends ChangeNotifier{


  var garageAddressC = "";

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

  addDetail(String garageNameC,String garageOwnerC,String garageContactC,String garageBioC)async{
    isLoading = true;
    notifyListeners();
    var userUid = auth.currentUser!.uid;
    List<Placemark> placeMarks = await placemarkFromCoordinates(double.parse(garageLatitude.toString()), double.parse(garageLongitude.toString()));

    garageAddressC = "${placeMarks.reversed.last.subLocality.toString()}  ${placeMarks.reversed.last.subAdministrativeArea.toString()}";

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(id);
    firebase_storage.UploadTask uploadImage = ref.putFile(File(image!.path.toString()));
    await Future.value(uploadImage).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      fireStore.collection("GarageDetails").doc(id).set(
          {
            "userUid" : userUid,
            "addDate" : date,
            "garageName" : garageNameC,
            "garageOwnerName" : garageOwnerC,
            "garageContact" : garageContactC,
            "garageBio" : garageBioC,
            "garageAddress" : garageAddressC,
            "garageAddressLatitude" : garageLatitude,
            "garageAddressLongitude" : garageLongitude,
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