import 'dart:async';

import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:car_mechanics/helpers/images_path.dart';
import 'package:car_mechanics/screens/start_screens/accuount_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void timer(){
    Timer(Duration(seconds: 3), () => Get.off(()=>AccountSelectedScreen()));
  }
  @override
  Widget build(BuildContext context) {
    timer();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(height: 35.h,ImagesPath.SPLASH_IMAGE),
            TextWidget1(text: "Instant Mechanic", fontSize: 24.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appColor),
          ],
        ),
      ),
    );
  }
}
