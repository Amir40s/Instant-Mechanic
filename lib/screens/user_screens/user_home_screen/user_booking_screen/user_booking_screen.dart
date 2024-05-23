import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/gd_button/garage_detail_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/helper_text.dart';
import '../garage_detail/components/gd_button/provider/booking_provider.dart';
import 'components/booking_fields.dart';

class UserBookingScreen extends StatelessWidget {
  UserBookingScreen({super.key,required this.userUid});

  String userUid;

  var userNameC = TextEditingController();
  var userPhoneC = TextEditingController();
  var userMsgC = TextEditingController();
  var userDateC = TextEditingController();
  var userTimeC = TextEditingController();
  var personNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bookingP = Provider.of<BookingProvider>(context,listen: false);
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
          UserBookingFields(userC: userPhoneC, title: "Phone Number*"),
          UserBookingFields(userC: personNumber, title: "Number of Persons"),
          UserBookingFields(userC: userMsgC, title: "Message"),
          UserBookingFields(userC: userDateC, title: "Booking Date"),
          UserBookingFields(userC: userTimeC, title: "Booking Time"),
          SizedBox(height: 20,),
          SubmitButton(press: (){
            bookingP.sendBookingMsg(userNameC.text, userPhoneC.text, userMsgC.text, userDateC.text,userTimeC.text,userUid);
          },title: "Book Now",)
        ],
      ),
    );
  }
}
