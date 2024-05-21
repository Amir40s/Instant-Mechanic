import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/garage_detail_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/helper_text.dart';
import 'components/booking_fields.dart';

class UserBookingScreen extends StatelessWidget {
  UserBookingScreen({super.key});

  var userNameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget1(text: "Booking Details", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.only(right: 20,left: 20,top: 20),
        children: [
          Center(child: TextWidget(text: "Complete Your Booking Details", fontSize: 18.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
          SizedBox(height: 20,),
          UserBookingFields(userC: userNameC, title: "Name*"),
          UserBookingFields(userC: userNameC, title: "Phone Number*"),
          UserBookingFields(userC: userNameC, title: "Number of Persons"),
          UserBookingFields(userC: userNameC, title: "Message"),
          UserBookingFields(userC: userNameC, title: "Booking Date"),
          UserBookingFields(userC: userNameC, title: "Booking Time"),
          SizedBox(height: 20,),
          SubmitButton(press: (){},title: "Book Now",)
        ],
      ),
    );
  }
}
