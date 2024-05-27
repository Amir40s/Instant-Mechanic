import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import '../booking_details/booking_details.dart';

class CancelScreen extends StatelessWidget {
  CancelScreen({super.key});

  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var heightS = 5.0;
    return Scaffold(
        backgroundColor: bgColor,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("GarageOwners").doc(userId).collection("bookings").snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.hasError){
                return TextWidget(text: "Some Error", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor);
              }
              return ListView(
                children: snapshot.data!.docs.map((doc){

                  return doc["bookingStatus"] == "cancel" ? GestureDetector(
                    onTap: (){
                      Get.to(()=>BookingDetails(
                        bookingId: doc["id"], name: doc["customerName"], phone: doc["customerPhone"], msg: doc["customerMsg"], date: doc["bookingDate"], time: doc["bookingTime"], status: doc["bookingStatus"],

                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appBarTextColor,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: "Booking ID : ${doc["id"]} ", fontSize: 14.dp, fontWeight: FontWeight.w500,
                              isTextCenter: false, textColor: appColor),
                          SizedBox(height: heightS,),
                          TextWidget(text: "Booking Date : ${doc["bookingDate"]}", fontSize: 14.dp, fontWeight: FontWeight.w500,
                              isTextCenter: false, textColor: appColor),
                          SizedBox(height: heightS,),
                          TextWidget(text: "Booking Status : ${doc["bookingStatus"]}", fontSize: 14.dp, fontWeight: FontWeight.w500,
                              isTextCenter: false, textColor: appColor),
                        ],
                      ),
                    ),
                  ) : SizedBox();
                }).toList(),
              );
            }
        )
    );
  }
}
