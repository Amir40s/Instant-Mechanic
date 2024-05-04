import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget1(text: "User Home Screen", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
      ),
    );
  }
}
