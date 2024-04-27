import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:car_mechanics/helpers/images_path.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:car_mechanics/screens/start_screens/owner_start_screen/owner_activity.dart';
import 'package:car_mechanics/screens/start_screens/owner_start_screen/owner_start_services/owner_start_services.dart';
import 'package:car_mechanics/screens/start_screens/user_start_screens/user_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';

class AccountSelectedScreen extends StatelessWidget {
  AccountSelectedScreen({super.key});

  OwnerStartServices ownerStartServices = OwnerStartServices();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar:  AppBar(
        toolbarHeight: 8.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: TextWidget1(text: "Choose Best Car Mechanics", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appBarTextColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 68.h,
                      width: 100.w,
                      child: Image.asset(ImagesPath.ACCOUNT_SELECT_IMAGE,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SubmitButton(title: "GARAGE OWNER", press: ()async{
                          ownerStartServices.isLogin(context);
                        }),
                        SubmitButton(title: "I'M USER", press: (){
                          Get.to(()=>UserLogInActivityScreens());
                        },
                          bgColor: Colors.grey.shade300,bdColor: appColor,textColor: appColor,),

                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
