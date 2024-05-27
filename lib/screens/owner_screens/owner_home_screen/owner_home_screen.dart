import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:car_mechanics/helpers/images_path.dart';
import 'package:car_mechanics/screens/owner_screens/my_booking/my_booking.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/add_details/add_detail.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/my_garage.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/provider/garage_provider.dart';
import 'package:car_mechanics/screens/owner_screens/my_sevices/my_services.dart';
import 'package:car_mechanics/screens/owner_screens/owner_home_screen/components/auto_text_slider.dart';
import 'package:car_mechanics/screens/owner_screens/owner_home_screen/components/custom_container.dart';
import 'package:car_mechanics/screens/owner_screens/owner_home_screen/components/drawer_header.dart';
import 'package:car_mechanics/screens/owner_screens/owner_home_screen/components/drawer_tile.dart';
import 'package:car_mechanics/screens/start_screens/accuount_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../firebase_services/firebase_services.dart';
import '../../../helpers/colors.dart';
import '../update_garage_details/provider/update_garage_details_provider.dart';
import 'components/auto_image_slider.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {


  logOutDialogueBox(){
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

  // bool _isVerified = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkUser();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ShopDetailsUpdateProvider>(context,listen: false).getUserName();
    var provider = Provider.of<ShopDetailsUpdateProvider>(context,listen: false);
    var garageP = Provider.of<GarageProvider>(context,listen: false);
    return  Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerContainer(name: provider.userName,),
            DrawerTile(text: "Home",icon: Icons.home,onTap: (){Get.back();},),
            Visibility(
              visible: true,
              child: DrawerTile(text: "Add Mechanics",icon: Icons.garage_sharp,onTap: (){
                Get.back();
                garageP.image = null;
                Get.to(()=>ShopAddDetail());
              },),
            ),
            DrawerTile(text: "Logout",icon: Icons.logout_sharp,onTap: (){
              logOutDialogueBox();
            }),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: TextWidget(text: "Shop Owner", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: Colors.white),
      ),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                children: [
                  Container(
                    width: 100.w,
                    height: 10.h,
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
          SizedBox(height: 20,),
          if(true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: TextSlider()),
                Divider(color: appColor,thickness: 4,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OwnerScreenContainer(image: ImagesPath.GARAGE_IMAGE,text: "My Shop",width: 42.w, onTap: () {
                      Get.to(()=>MyGarageScreen());
                    },),
                    OwnerScreenContainer(image: ImagesPath.BOOKING_IMAGE,text: "My Booking",width: 42.w, onTap: () {
                      Get.to(()=>MyBooking());
                    },),
                  ],
                ),
                SizedBox(height: 10,),
                OwnerScreenContainer(image: ImagesPath.SERVICES_IMAGE,text: "My Services",width: Get.width, onTap: () {
                  Get.to(()=>MyServices());
                },),
              ],
            ),
          ),

          // if(_isVerified == false)
          // Text("Please wait for account Approval"),
        ],
      ),
    );
  }

  // void checkUser() async{
  //   await fireStore.collection("GarageOwners").doc(auth.currentUser?.uid.toString())
  //       .get().then((value) => {
  //         if (value.exists){
  //           if(value.get("status") == "approved"){
  //             setState(() {
  //               _isVerified = true;
  //             })
  //           }else{
  //             setState(() {
  //               _isVerified = false;
  //             })
  //           }
  //         }
  //   });
  // }
}
