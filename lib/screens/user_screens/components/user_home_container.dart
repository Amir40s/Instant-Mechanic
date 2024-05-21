import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';
import '../../../helpers/images_path.dart';

class GarageInfoContainer extends StatelessWidget {
  GarageInfoContainer({super.key,this.onTap});
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
            color: appBarTextColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(height: 3.h,ImagesPath.BUILDING_ICON),
                SizedBox(width: 10,),
                TextWidget(text: "Shop Name", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(text: "3.5", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
                SizedBox(width: 5,),
                Icon(CupertinoIcons.star_fill,size: 15,),
                Icon(CupertinoIcons.star_fill,size: 15,),
                Icon(CupertinoIcons.star_fill,size: 15,),
                Icon(CupertinoIcons.star_lefthalf_fill,size: 15,),
              ],
            ),
            SizedBox(
                height: 20.h,
                width: 100.w,
                child: Image.asset(ImagesPath.COVER_IMAGE,fit: BoxFit.fill,)),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.location_solid),
                    SizedBox(width: 5,),
                    SizedBox(
                        width: 40.w,
                        child: TextWidget(text: "Location", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
                  ],
                ),
                Image.asset(height: 3.5.h,ImagesPath.MAP_IMAGE),
              ],
            )
          ],
        ),
      ),
    );
  }
}
