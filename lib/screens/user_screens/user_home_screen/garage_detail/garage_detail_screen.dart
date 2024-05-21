import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/garage_detail_map_container.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/garage_detail_tile.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/user_booking_screen/user_booking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../../../helpers/helper_text.dart';
import '../../../../helpers/images_path.dart';
import 'components/garage_detail_button.dart';

class GarageDetailScreen extends StatelessWidget {
  const GarageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: TextWidget1(text: "Shop Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 31.h,
            width: 100.w,
            padding: EdgeInsets.all(5.0),
            color: appBarTextColor,
            child: Image.asset(ImagesPath.COVER_IMAGE,fit: BoxFit.fill,),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            width: 100.w,
            color: appBarTextColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(height: 3.h,ImagesPath.BUILDING_ICON),
                        SizedBox(width: 10,),
                        TextWidget(text: "Shop Name", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)
                      ],
                    ),
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
                  ],
                ),
                SizedBox(height: 5,),
                TextWidget(text: "Bio", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                SizedBox(
                    width: 100.w,
                    child: TextWidget(text: "bio details", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.grey)),
                SizedBox(height: 10,),
                InkWell(
                    onTap: (){
                      Get.to(()=>UserBookingScreen());
                    },
                    child: GDButton(text: "Book Now",icon: CupertinoIcons.calendar,)),
                SizedBox(height: 5,),
                Divider(thickness: 1.2,color: appColor,),
                TextWidget(text: "Shop Owner Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                GDTile(text: "Shop Owner Name", image: ImagesPath.WHATSAPP_IMAGE,icon: CupertinoIcons.person_fill,),
                GDTile(text: "Shop Owner Phone", image: ImagesPath.PHONE_IMAGE,icon: Icons.phone_android,),
                Divider(color: appColor,thickness: 1.2,),
                Row(
                  children: [
                    Icon(CupertinoIcons.location_solid),
                    SizedBox(width: 10,),
                    TextWidget(text: "Shop Location", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                  ],
                ),
                SizedBox(height: 10,),
                GDMap(),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(text: "Services", fontSize: 18.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
          ),
          SizedBox(
            width: 100.w,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: appBarTextColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 1
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(height: 10.h,ImagesPath.GARAGE_IMAGE),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "Category Name", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                        SizedBox(height: 10,),
                        TextWidget(text: "Charges Price", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                      ],
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
