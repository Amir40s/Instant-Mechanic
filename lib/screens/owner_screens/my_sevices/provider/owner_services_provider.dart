import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../../utils/toast_msg.dart';

class OwnerServicesProvider extends ChangeNotifier{

  bool isLoading = false;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String date = DateFormat('MMMM/dd/yyyy').format(DateTime.now());


  addService(String serviceCategoryC,String serviceProviderC,String serviceDetailsC,String serviceChargesC){
    var userUid = auth.currentUser!.uid;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    isLoading = true;
    fireStore.collection("GarageOwners").doc(userUid).collection("garageServices").doc(id).set(
        {
          "addDate" : date,
          "serviceCategory" : serviceCategoryC,
          "serviceProvider" : serviceProviderC,
          "serviceDetails" : serviceDetailsC,
          "serviceCharges" : serviceChargesC,
          "id" : id,
        }).whenComplete(() {
      isLoading = false;
      ToastMsg().toastMsg("Data Saved");
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  deleteService(String id){
    var userUid = auth.currentUser!.uid;
    fireStore.collection("GarageOwners").doc(userUid).collection("garageServices").doc(id).delete().whenComplete(() {
      ToastMsg().toastMsg("Service Delete");
      notifyListeners();
    }).onError((error, stackTrace)  {
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

}