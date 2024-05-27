import 'package:car_mechanics/firebase_services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';

class UserMyBookings extends StatelessWidget {
  UserMyBookings({super.key});

  var userId = auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var heightS = 5.0;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "Bookings", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("UserOwners").doc(userId).collection("userBookings").snapshots(),
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
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: appBarTextColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: "Shop : ${doc["shopName"]} ", fontSize: 14.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: appColor),
                      SizedBox(height: heightS,),
                      TextWidget(text: "Owner Name : ${doc["ownerName"]}", fontSize: 14.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: appColor),
                      SizedBox(height: heightS,),
                      TextWidget(text: "Booking Status : ${doc["bookingStatus"]}", fontSize: 14.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: appColor),
                      SizedBox(height: heightS,),
                      TextWidget(text: "Booking Status : ${doc["addDate"]}", fontSize: 14.dp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: appColor),
                    ],
                  ),
                );
              }).toList(),
            );
          }
      ),
    );
  }
}
