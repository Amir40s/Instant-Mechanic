import 'package:car_mechanics/screens/owner_screens/my_garage/provider/garage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/helper_text.dart';

class AddNew extends StatelessWidget {
  AddNew({super.key,required this.onTap});
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var garageP = Provider.of<GarageProvider>(context,listen: false);
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(child: TextWidget(text: "Add New", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white)),
      ),
    );
  }
}
