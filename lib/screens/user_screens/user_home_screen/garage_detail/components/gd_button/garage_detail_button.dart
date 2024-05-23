import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../../../helpers/colors.dart';
import '../../../../../../helpers/helper_text.dart';

class GDButton extends StatelessWidget {
  GDButton({super.key,this.icon,required this.text});

  IconData? icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 100.w,
      decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(height: 3.h,ImagesPath.BOOKING_IMAGE),
            Icon(icon,color: appBarTextColor,),
            SizedBox(height: 2,),
            TextWidget(text: text, fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appBarTextColor)
          ],
        ),
      ),
    );
  }
}
