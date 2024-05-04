import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:car_mechanics/screens/start_screens/owner_start_screen/owner_signin_activity.dart';
import 'package:car_mechanics/screens/start_screens/owner_start_screen/owner_signup_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class OwnerLogInActivityScreens extends StatelessWidget {
  const OwnerLogInActivityScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            leading: IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back,color: appBarTextColor,)),
          ),
          body: Column(
            children: [
              Container(
                width: Get.width,
                height: 20.h,
                padding: const EdgeInsets.only(
                  bottom: 15,
                  right: 15,
                  left: 15,
                ),
                decoration: BoxDecoration(color: appColor,borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget1(text: "Mechanic", fontSize: 18.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appBarTextColor),
                    const TabBar(
                        indicatorColor: Colors.white,
                        dividerColor: appColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        tabs: [
                          Tab(
                            text: "Sign In",
                          ),
                          Tab(text: "Sign Up",),
                        ]),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  OwnerSignIn(),
                  OwnerSignUp(),
                ]),
              ),
            ],
          ),
        ));
  }
}
