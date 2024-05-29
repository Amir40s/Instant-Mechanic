import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../utils/toast_msg.dart';

class BookingProvider extends ChangeNotifier{

  bool isLoading = false;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  firebase_storage.FirebaseStorage firebaseStorage = firebase_storage.FirebaseStorage.instance;

  String date = DateFormat('MMMM/dd/yyyy').format(DateTime.now());


  sendBookingMsg(String customerNameC,String customerPhoneC,String customerMsgC,
      String bookingDateC,String bookingTimeC,String userUid,String shopName,String ownerName)async{
    isLoading = true;
    notifyListeners();

    var bookingUserUid = auth.currentUser!.uid;

    String id = DateTime.now().millisecondsSinceEpoch.toString();

    await fireStore.collection("GarageOwners").doc(userUid).collection("bookings").doc(id).set(
        {
          "addDate" : date,
          "customerName" : customerNameC,
          "customerPhone" : customerPhoneC,
          "customerMsg" : customerMsgC,
          "bookingDate" : bookingDateC,
          "bookingTime" : bookingTimeC,
          "bookingUserUid" : bookingUserUid,
          "bookingStatus" : "pending",
          "id" : id,
        }).then((value) async {
      await fireStore.collection("UserOwners").doc(bookingUserUid).collection("userBookings").doc(id).set(
          {
            "addDate" : date,
            "bookingUserUid" : bookingUserUid,
            "shopName" : shopName,
            "ownerName" : ownerName,
            "bookingStatus" : "pending",
            "id" : id,
          });
    }).whenComplete((){
      isLoading = false;
      ToastMsg().toastMsg("Booking Send");
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  statusApproved(String userid,String id,)async{
    isLoading = true;
    notifyListeners();
    var userUid = auth.currentUser!.uid;

    await fireStore.collection("GarageOwners").doc(userUid).collection("bookings").doc(id).update(
        {
          "bookingStatus" : "approved",
        }).then((value) async {
      await fireStore.collection("UserOwners").doc(userid).collection("userBookings").doc(id).update(
          {
            "bookingUserUid" : userid,
            "bookingStatus" : "Approved",
            "id" : id,
          });
    }).whenComplete(() {
      isLoading = false;
      ToastMsg().toastMsg("Booking Approved");
      Get.back();
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      // ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  statusCanceled(String userUid,String id)async{
    isLoading = true;
    notifyListeners();
    var uid = auth.currentUser!.uid;

    await fireStore.collection("GarageOwners").doc(uid).collection("bookings").doc(id).update(
        {
          "bookingStatus" : "cancel",
        }).then((value) async {
      await fireStore.collection("UserOwners").doc(userUid).collection("userBookings").doc(id).update(
          {
            "bookingUserUid" : userUid,
            "bookingStatus" : "Cancelled",
            "id" : id,
          });
    }).whenComplete(() {
      isLoading = false;
      ToastMsg().toastMsg("Booking Cancelled");
      Get.back();
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      // ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  deleteBooking(String userUid,String id)async{
    isLoading = true;
    notifyListeners();
    var userUid = auth.currentUser!.uid;

    await fireStore.collection("GarageOwners").doc(userUid).collection("bookings").doc(id).delete().whenComplete(() {
      isLoading = false;
      ToastMsg().toastMsg("Booking Delete");
      Get.back();
      notifyListeners();
    }).onError((error, stackTrace)  {
      isLoading = false;
      // ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

}