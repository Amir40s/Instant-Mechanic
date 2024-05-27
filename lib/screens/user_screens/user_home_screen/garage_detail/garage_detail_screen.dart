import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/garage_detail_map_container.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/garage_detail/components/garage_detail_tile.dart';
import 'package:car_mechanics/screens/user_screens/user_home_screen/user_booking_screen/user_booking_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../../../helpers/helper_text.dart';
import '../../../../helpers/images_path.dart';
import 'components/gd_button/garage_detail_button.dart';
import 'components/shop_direction_on_google_map.dart';

class GarageDetailScreen extends StatelessWidget {
  GarageDetailScreen({super.key,required this.imagePath,required this.shopName,required this.ownerName,
  required this.ownerPhone,required this.shopBio,required this.userUid,required this.latitude,required this.longitude
  });

  String imagePath;
  String shopName;
  String ownerPhone;
  String ownerName;
  String shopBio;
  String userUid;
  double latitude,longitude;

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
            child: Image.network(imagePath,fit: BoxFit.fill,),
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
                        TextWidget(text: shopName, fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)
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
                    child: TextWidget(text: shopBio, fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.grey)),
                SizedBox(height: 10,),
                InkWell(
                    onTap: (){
                      Get.to(()=>UserBookingScreen(userUid: userUid, shopName: shopName, ownerName: ownerName,));
                    },
                    child: GDButton(text: "Book Now",icon: CupertinoIcons.calendar,)),
                SizedBox(height: 5,),
                Divider(thickness: 1.2,color: appColor,),
                TextWidget(text: "Shop Owner Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                GDTile(text: ownerName, image: ImagesPath.WHATSAPP_IMAGE,icon: CupertinoIcons.person_fill,),
                GDTile(text: ownerPhone, image: ImagesPath.PHONE_IMAGE,icon: Icons.phone_android,),
                Divider(color: appColor,thickness: 1.2,),
                Row(
                  children: [
                    Icon(CupertinoIcons.location_solid),
                    SizedBox(width: 10,),
                    TextWidget(text: "Shop Location", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                  ],
                ),
                SizedBox(height: 10,),
                GDMap(latitude: latitude, longitude: longitude,),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: (){
                      Get.to(()=>GDOnGoogleMap(latitude: latitude, longitude: longitude));
                    },
                    child: GDButton(text: "Get Direction",icon: Icons.directions,)),
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
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("GarageOwners").doc(userUid).collection("garageServices").snapshots(),
                builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasError){
                    return TextWidget(text: "Some Error", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor);
                  }
                  return  ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((doc){
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
                                  SizedBox(width: 50.w,child: TextWidget(text: doc["serviceCategory"], fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
                                  SizedBox(height: 10,),
                                  SizedBox(width: 50.w,child: TextWidget(text: doc["serviceCharges"], fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      );
            }),
          )
        ],
      ),
    );
  }
}
