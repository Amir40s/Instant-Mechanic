import 'package:car_mechanics/screens/owner_screens/owner_home_screen/owner_home_screen.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';
import '../../../helpers/input_fields.dart';
import '../../../helpers/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/cupertino.dart';

class UserSignUp extends StatelessWidget {
  UserSignUp({super.key});
  var nameC = TextEditingController();
  var passwordC = TextEditingController();
  var confirmPasswordC = TextEditingController();
  var emailC = TextEditingController();
  var phoneC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20,left: 20,top: 30),
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget1(text: "Create Account", fontSize: 18.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appColor),
              SizedBox(height: 20,),
              InputField(inputController: nameC,prefixIcon: Icon(CupertinoIcons.person_crop_circle_fill),hintText: "Name",),
              SizedBox(height: 20,),
              InputField(inputController: phoneC,prefixIcon: Icon(CupertinoIcons.phone_fill),hintText: "Phone Number",),
              SizedBox(height: 20,),
              InputField(inputController: emailC,prefixIcon: Icon(CupertinoIcons.mail_solid),hintText: "Email",),
              SizedBox(height: 20,),
              InputField(inputController: passwordC,prefixIcon: Icon(Icons.lock),hintText: "Password",),
              SizedBox(height: 20,),
              InputField(inputController: confirmPasswordC,prefixIcon: Icon(Icons.lock),hintText: "Confirm Password",),
              SizedBox(height: 30,),
              SubmitButton(title: "Create Account", press: (){
                if(formKey.currentState!.validate()){
                  if(confirmPasswordC == passwordC){
                  }
                }
              })
            ],
          ),
        ),
      ),);
  }
}
