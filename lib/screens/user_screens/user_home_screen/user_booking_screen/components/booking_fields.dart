import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../../helpers/colors.dart';
import '../../../../../helpers/helper_text.dart';
import '../../../../../helpers/input_fields.dart';

class UserBookingFields extends StatelessWidget {
  UserBookingFields({super.key,required this.userC,required this.title});

  TextEditingController userC;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(text: title, fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
        InputField(inputController: userC),
        SizedBox(height: 10,),
      ],
    );
  }
}
