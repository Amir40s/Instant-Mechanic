import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/helpers/helper_text.dart';
import 'package:car_mechanics/helpers/images_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class GDTile extends StatelessWidget {
  GDTile({super.key,required this.text,required this.image,this.icon,this.onTap});

  String text,image;
  IconData? icon;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 10,),
              TextWidget(text: text, fontSize: 14.dp, fontWeight: FontWeight.w600, isTextCenter: false, textColor: appColor),
            ],
          ),
          GestureDetector(
              onTap: onTap,
              child: Image.asset(image,height: 3.5.h,)),
        ],
      ),
    );
  }
}
