import 'package:car_mechanics/screens/owner_screens/my_garage/add_details/add_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../helpers/helper_text.dart';

class AddNew extends StatelessWidget {
  const AddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        Get.to(()=>AddDetail());
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(child: TextWidget(text: "Add New", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white)),
      ),
    );
  }
}
