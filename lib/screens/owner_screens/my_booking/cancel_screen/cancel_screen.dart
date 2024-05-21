import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import '../booking_details/booking_details.dart';

class CancelScreen extends StatelessWidget {
  const CancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightS = 5.0;
    return Scaffold(
        backgroundColor: bgColor,
        body: ListView.builder(
            itemCount: 4,
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
                          TextWidget(text: "cancel", fontSize: 14.dp, fontWeight: FontWeight.w500,
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
