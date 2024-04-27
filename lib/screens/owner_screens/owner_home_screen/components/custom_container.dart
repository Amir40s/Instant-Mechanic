import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class OwnerScreenContainer extends StatelessWidget {
  OwnerScreenContainer({super.key,this.text,this.image,this.width,required this.onTap});
  var image;
  String? text;
  double? width;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 100,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2
            ),
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 50,
                child: Center(child: Image.asset(image))),
            TextWidget1(text: text! , fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appColor)
          ],
        ),
      ),
    );
  }
}
