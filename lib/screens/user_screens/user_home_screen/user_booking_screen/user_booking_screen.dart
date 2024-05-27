import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/gd_button/garage_detail_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/helper_text.dart';
import '../garage_detail/components/gd_button/provider/booking_provider.dart';
import 'components/booking_fields.dart';

class UserBookingScreen extends StatefulWidget {
  UserBookingScreen({super.key,required this.userUid,required this.shopName,required this.ownerName});

  String userUid;
  String shopName;
  String ownerName;

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  var userNameC = TextEditingController();

  var userPhoneC = TextEditingController();

  var userMsgC = TextEditingController();

  var userDateC = TextEditingController();

  var userTimeC = TextEditingController();

  var personNumber = TextEditingController();

  var formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  TimeOfDay? selectedTime;
  final DateFormat timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    var bookingP = Provider.of<BookingProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget1(text: "Booking Details", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
      ),
      body: Consumer<BookingProvider>(builder: (context,provider,child){
        return provider.isLoading == false ? ListView(
          padding: EdgeInsets.only(right: 20,left: 20,top: 20),
          children: [
            Center(child: TextWidget(text: "Complete Your Booking Details", fontSize: 18.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
            SizedBox(height: 20,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  UserBookingFields(userC: userNameC, title: "Name*", type: TextInputType.text,),
                  UserBookingFields(userC: userPhoneC, title: "Phone Number*", type: TextInputType.number,),
                  // UserBookingFields(userC: personNumber, title: "Number of Persons"),
                  UserBookingFields(userC: userMsgC, title: "Message", type: TextInputType.text,),
                  UserBookingFields(userC: userDateC, title: "Booking Date", type: TextInputType.none,onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                        userDateC.text = dateFormat.format(selectedDate!);
                      });
                    }
                  },),
                  UserBookingFields(userC: userTimeC, title: "Booking Time", type: TextInputType.none,onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null && pickedTime != selectedTime) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                    String formatTime(TimeOfDay time) {
                      final now = DateTime.now();
                      final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                      return timeFormat.format(dt);
                    }
                    setState(() {
                      userTimeC.text = formatTime(selectedTime!);
                    });
                  },),
                ],
              ),
            ),
            SizedBox(height: 20,),
            SubmitButton(press: (){
              if(formKey.currentState!.validate()){
                bookingP.sendBookingMsg(userNameC.text, userPhoneC.text, userMsgC.text, userDateC.text,userTimeC.text,widget.userUid,widget.shopName,widget.ownerName);
              }
            },title: "Book Now",)
          ],
        ) : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
