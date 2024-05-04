import 'package:flutter/material.dart';

import 'colors.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    this.title,
    this.icon,
    required this.press,
    this.height,
    this.width,
    this.radius,
    this.bdColor,
    this.iconColor,
    this.textColor,
    this.textSize,
    this.bdRadius,
    this.bgColor,
  });
  final String? title;
  final IconData? icon;
  final Function() press;
  final double? height;
  final double? width;
  final double? radius;
  final Color? bdColor, bgColor;
  final Color? iconColor;
  final Color? textColor;
  final double? textSize;
  final double? bdRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: press,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1.0,vertical: 5),
        width: width ?? double.infinity,
        alignment: Alignment.center,
        height: height ?? 50.0,
        decoration: BoxDecoration(
            color: bgColor ?? appColor,
            borderRadius: BorderRadius.circular(radius ?? 10.0),
            border: Border.all(color: bdColor ?? appColor,width: 1.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(.5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: title != null ? 8.0 : 0.0),
                child: Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                ),
              ),
            if (title != null)
              Text(
                title!,
                style:  TextStyle(
                    color: textColor ?? Colors.white, fontWeight: FontWeight.bold,fontFamily: "Nunito-Medium"),
              ),

          ],
        ),
      ),
    );
  }
}
