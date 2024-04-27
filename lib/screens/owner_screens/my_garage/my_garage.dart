import 'package:car_mechanics/helpers/images_path.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/components/addnew_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';

class MyGarageScreen extends StatelessWidget {
  const MyGarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: TextWidget(text: "My Garage", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
        actions: [
          AddNew(),
        ],
      ),
      body: SizedBox(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            height: 35.h,
            width: 100.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: "Marquee Add Date", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                SizedBox(height: 22.h,width:90.w ,child: Center(child: Image.asset(ImagesPath.COVER_IMAGE,fit: BoxFit.cover,)),),
                TextWidget(text: "Garage Name", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                TextWidget(text: "Garage Owner Name", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
              ],
            ),
          );
        },
        ),
      ),
    );
  }
}
