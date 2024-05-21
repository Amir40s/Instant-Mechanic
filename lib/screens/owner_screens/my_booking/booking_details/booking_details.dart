import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import 'custom_container.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "Booking Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(child: TextWidget(text: "Order Response", fontSize: 24.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 30),
              color: appBarTextColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer().statusContainer("Pending"),
                  CustomContainer().statusContainer("Cancel"),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: appBarTextColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                        height: 5.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: appBarTextColor,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: bgColor
                            )
                        ),
                        child: TextWidget(text: "Date", fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                        height: 5.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: appBarTextColor,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: bgColor
                            )
                        ),
                        child: TextWidget(text: "Time", fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextWidget(text: "Booking Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                  CustomContainer().bookingContainer("Booking ID"),
                  CustomContainer().bookingContainer("Name"),
                  CustomContainer().bookingContainer("Phone"),
                  CustomContainer().bookingContainer("Message"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer().bookingContainer("Date",width: 42.w),
                      CustomContainer().bookingContainer("Time",width: 42.w),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
