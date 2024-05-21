import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';

class CustomContainer{
  Widget bookingContainer(String text,{double? width}){
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
      height: 5.h,
      width: width ?? 100.w,
      decoration: BoxDecoration(
          color: appBarTextColor,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
              color: bgColor
          )
      ),
      child: TextWidget(text: text, fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
    );
  }
  Widget statusContainer(String text){
    return Container(
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
      child: Center(child: TextWidget(text: text, fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor)),
    );
  }
}