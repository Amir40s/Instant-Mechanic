import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../../firebase_services/firebase_services.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/images_path.dart';
import '../../owner_screens/my_garage/add_details/add_detail.dart';
import '../../owner_screens/owner_home_screen/components/auto_image_slider.dart';
import '../../owner_screens/owner_home_screen/components/auto_text_slider.dart';
import '../../owner_screens/owner_home_screen/components/drawer_header.dart';
import '../../owner_screens/owner_home_screen/components/drawer_tile.dart';
import '../../start_screens/accuount_selected_screen.dart';
import '../components/user_home_container.dart';
import 'garage_detail/garage_detail_screen.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});

  var userUid = auth.currentUser!.uid;
  
  logOutDialogueBox(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: appColor,
          backgroundColor: appColor,
          title: TextWidget1(text: "Sign Out", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: Colors.white),
          content: TextWidget(text: "Are you sure you want to logout?", fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                auth.signOut();
                Get.offAll(()=>AccountSelectedScreen());
              },
              child: Text('yes',style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('no',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerContainer(),
            DrawerTile(text: "Home",icon: Icons.home,onTap: (){Get.back();},),
            DrawerTile(text: "My Booking",icon: Icons.calendar_month_outlined,onTap: (){
              Get.back();
            },),
            DrawerTile(text: "Near by Garage",icon: Icons.garage_rounded,onTap: (){
              Get.back();
            }),
            DrawerTile(text: "Logout",icon: Icons.logout_sharp,onTap: (){
              logOutDialogueBox(context);
            }),
          ],
        ),
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
        title: TextWidget1(text: "User", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: 100.w,
                      height: 15.h,
                      padding: const EdgeInsets.only(
                        top: 15,
                        right: 15,
                        left: 15,
                      ),
                      decoration: BoxDecoration(color: appColor,borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 40,
                              child: Image.asset(ImagesPath.NOTIFICATION_IMAGE)),
                          TextWidget(text: "Weekend Discount Offers ❤", fontSize: 10.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appBarTextColor),
                          SizedBox(width: 1,)
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h,)
                  ],
                ),
                const ImageSlider(),
              ],
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: TextSlider()),
                  Divider(color: appColor,thickness: 4,),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("GarageDetails").snapshots(),
                builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  if(snapshot.hasError){
                    return TextWidget(text: "Some Error", fontSize: 16.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor);
                  }
                  return SizedBox(
                    width: 100.w,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((doc) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(()=>GarageDetailScreen(imagePath: doc["imagePath"], shopName: doc['garageName'],
                              ownerName: doc["garageOwnerName"], ownerPhone: doc["garageContact"],
                              shopBio: doc["garageBio"],userUid: doc["userUid"], latitude: double.parse(doc["garageAddressLatitude"]), longitude: double.parse(doc["garageAddressLongitude"]),));
                          },
                          child: Container(
                            margin: EdgeInsets.all(15.0),
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: appBarTextColor,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(height: 3.h,ImagesPath.BUILDING_ICON),
                                    SizedBox(width: 10,),
                                    TextWidget(text: doc["garageName"], fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                SizedBox(
                                    height: 25.h,
                                    width: 100.w,
                                    child: Image.network(doc["imagePath"],fit: BoxFit.fill,)),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_sharp),
                                        SizedBox(width: 5,),
                                        SizedBox(
                                            width: 60.w,
                                            child: TextWidget(text: doc["garageAddress"], fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
                                      ],
                                    ),
                                    Image.asset(ImagesPath.MAP_IMAGE,height: 4.h,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

