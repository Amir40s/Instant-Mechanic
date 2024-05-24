import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import '../../../../helpers/images_path.dart';

class DrawerContainer extends StatefulWidget {
  DrawerContainer({super.key,required this.name});
  String name;
  @override
  State<DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  File? _image;


  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35),
      width: 100.w,
      color: appColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: InkWell(
              onTap: (){
                _getImage();
              },
              child: CircleAvatar(
                radius: 8.h,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: Container(
                  height: 15.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  child:_image == null ? Image.asset(ImagesPath.PROFILE_IMAGE) :null ,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          TextWidget1(text: widget.name, fontSize: 12.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: Colors.white),
        ],
      ),
    );
  }
}
