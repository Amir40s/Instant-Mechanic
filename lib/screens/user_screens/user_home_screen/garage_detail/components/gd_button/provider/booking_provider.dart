import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../../../../../../../utils/toast_msg.dart';

class BookingProvider extends ChangeNotifier{

  bool isLoading = false;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  firebase_storage.FirebaseStorage firebaseStorage = firebase_storage.FirebaseStorage.instance;

  String date = DateFormat('MMMM/dd/yyyy').format(DateTime.now());


  sendBookingMsg(String customerNameC,String customerPhoneC,String customerMsgC,String bookingDateC,String bookingTimeC,String userUid)async{
    isLoading = true;
    notifyListeners();
    var userUid = auth.currentUser!.uid;

    String id = DateTime.now().millisecondsSinceEpoch.toString();

    await fireStore.collection("GarageOwners").doc(userUid).collection("bookings").doc(id).set(
        {
          "addDate" : date,
          "customerName" : customerNameC,
          "customerPhone" : customerPhoneC,
          "customerMsg" : customerMsgC,
          "bookingDate" : bookingDateC,
          "bookingTime" : bookingTimeC,
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

}