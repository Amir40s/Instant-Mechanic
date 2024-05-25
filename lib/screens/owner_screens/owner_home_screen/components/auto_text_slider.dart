import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';

class TextSlider extends StatelessWidget {
  const TextSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 4.h,
      child:CarouselSlider(items: [
        TextWidget1(text: "", fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
        TextWidget1(text: "", fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
        TextWidget1(text: "", fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
      ],
          options: CarouselOptions(
            height:20.h,
            aspectRatio: 16/9,
            viewportFraction: 1.8,
            autoPlay: true,
            padEnds: false,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.linearToEaseOut,
          )),
    );
  }
}
