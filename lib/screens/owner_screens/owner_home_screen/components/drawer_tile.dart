import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({super.key,this.text,this.icon,this.onTap});
  String? text;
  IconData? icon;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Row(
          children: [
            Icon(icon!,color: appColor,),
            SizedBox(width: 20,),
            TextWidget(text: text!, fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
          ],
        ),
      ),
    );
  }
}
