import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import '../../../../helpers/images_path.dart';

class AddDetail extends StatelessWidget {
  AddDetail({super.key});

  var garageNameC = TextEditingController();
  var garageOwnerC = TextEditingController();
  var garageContactC = TextEditingController();
  var garageBioC = TextEditingController();
  var garageAddressC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fieldH = 10;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: TextWidget(text: "Add Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
      body: SizedBox(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                TextWidget(text: "Add Details", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                SizedBox(width: 100.w,child: Image.asset(ImagesPath.COVER_IMAGE,fit: BoxFit.fill,)),
                SizedBox(height: 30,),
                TextWidget(text: "Garage Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                SizedBox(height: fieldH,),
                InputField(inputController: garageNameC),
                SizedBox(height: fieldH,),
                TextWidget(text: "Garage Owner Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor,),
                SizedBox(height: fieldH,),
                InputField(inputController: garageOwnerC),
                SizedBox(height: fieldH,),
                TextWidget(text: "Garage Contact Number", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                SizedBox(height: fieldH,),
                InputField(inputController: garageContactC,type: TextInputType.number,),
                SizedBox(height: fieldH,),
                TextWidget(text: "Garage Bio", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                SizedBox(height: fieldH,),
                InputField(inputController: garageBioC,maxLines: 2,),
                SizedBox(height: fieldH,),
                TextWidget(text: "Garage Address", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                InputField(inputController: garageAddressC,maxLines: 2,),
                SizedBox(height: 20,),
                SubmitButton(title: "Next", press: (){})
              ],
            ),
          ],
        ),
      )
    );
  }
}
