import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:car_mechanics/screens/owner_screens/my_booking/booking_details/booking_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightS = 5.0;
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            Get.to(()=>BookingDetails());
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: appBarTextColor,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    TextWidget(text: "Booking ID : ", fontSize: 14.dp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: appColor),
                    TextWidget(text: "ID Number", fontSize: 14.dp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: appColor),
                  ],
                ),
                SizedBox(height: heightS,),
                Row(
                  children: [
                    TextWidget(text: "Booking Date : ", fontSize: 14.dp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: appColor),
                    TextWidget(text: "Date", fontSize: 14.dp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: appColor),
                  ],
                ),
                SizedBox(height: heightS,),
                Row(
                  children: [
                    TextWidget(text: "Booking Status : ", fontSize: 14.dp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: appColor),
                    TextWidget(text: "pending", fontSize: 14.dp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: appColor),
                  ],
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}
