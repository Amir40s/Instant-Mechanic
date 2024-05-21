import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../utils/toast_msg.dart';

class UpdateServiceDetailProvider extends ChangeNotifier{

  var serviceCategoryC = TextEditingController();
  var serviceProviderC = TextEditingController();
  var serviceDetailC = TextEditingController();
  var serviceChargesC = TextEditingController();

  bool isLoading = false;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String date = DateFormat('MMMM/dd/yyyy').format(DateTime.now());

  updateDetail(String id){
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    fireStore.collection("GarageOwners").doc(userUid).collection("garageServices").doc(id).update(
        {
          "addDate" : date,
          "serviceCategory" : serviceCategoryC.text,
          "serviceCharges" : serviceChargesC.text,
          "serviceDetails" : serviceDetailC.text,
          "serviceProvider" : serviceProviderC.text,
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
    notifyListeners();
  }

  getDetail(String id)async{
    var userUid = auth.currentUser!.uid;
    isLoading = true;
    await fireStore.collection("GarageOwners").doc(userUid).collection("garageServices").doc(id).get().then((value){
      serviceCategoryC.text = value.get("serviceCategory");
      serviceChargesC.text = value.get("serviceCharges");
      serviceDetailC.text = value.get("serviceDetails");
      serviceProviderC.text = value.get("serviceProvider");
      print(serviceCategoryC);
      print(serviceChargesC);
      print(serviceDetailC);
      print(serviceProviderC);
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


}