import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/images_path.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 20.h,
      child:CarouselSlider(items: [
        Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 80.w,
              height: 20.h,
              child: Image.asset(ImagesPath.SLIDE1_IMAGE,fit: BoxFit.fill,),
            ),
          ),
        ),
        Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 80.w,
              height: 20.h,
              child: Image.asset(ImagesPath.SLIDE2_IMAGE,fit: BoxFit.fill,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 80.w,
              height: 20.h,
              child: Image.asset(ImagesPath.SLIDE3_IMAGE,fit: BoxFit.fill,),
            ),
          ),
        ),
      ],
          options: CarouselOptions(
            height:20.h,
            aspectRatio: 16/9,
            viewportFraction: 1.5,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.linearToEaseOut,
          )),
    );
  }
}
