import 'dart:io';
import 'package:car_mechanics/firebase_services/firebase_services.dart';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/google_map/google_provider/google_provider.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/provider/garage_provider.dart';
import 'package:car_mechanics/utils/toast_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import '../../../../helpers/images_path.dart';
import '../google_map/google_map.dart';

class ShopAddDetail extends StatefulWidget {
  ShopAddDetail({super.key});

  @override
  State<ShopAddDetail> createState() => _ShopAddDetailState();
}

class _ShopAddDetailState extends State<ShopAddDetail> {
  var garageNameC = TextEditingController();
  var garageOwnerC = TextEditingController();
  var garageContactC = TextEditingController();
  var garageBioC = TextEditingController();
  // var garageAddressC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  String stAdd = "";

  @override
  Widget build(BuildContext context) {
    var garageP = Provider.of<GarageProvider>(context,listen: false);
    var googleP = Provider.of<GoogleProvider>(context,listen: false);
    double fieldH = 10;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "Add Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
      body:Consumer<GarageProvider>(builder: (context,value,child){
        return value.isLoading == true ?  Center(
          child: CircularProgressIndicator(),
        ) : SizedBox(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  TextWidget(text: "Add Garage Cover Image", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor,),
                  InkWell(
                      onTap: ()async{
                        garageP.pickImage();
                      },
                      child: SizedBox(width: 100.w,height: 25.h,child:value.image == null ? Image.asset(ImagesPath.COVER_IMAGE,fit: BoxFit.fill,) : Image.file(fit: BoxFit.fill,File(value.image!.path)))),
                  SizedBox(height: 30,),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "Garage Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        SizedBox(height: fieldH,),
                        InputField(inputController: garageNameC,hintText: "Garage Name",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Garage Owner Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor,),
                        SizedBox(height: fieldH,),
                        InputField(inputController: garageOwnerC,hintText: "Garage Owner Name",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Garage Contact Number", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        SizedBox(height: fieldH,),
                        InputField(inputController: garageContactC,type: TextInputType.number,hintText: "Garage Contact Number",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Garage Bio", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        SizedBox(height: fieldH,),
                        InputField(inputController: garageBioC,maxLines: 2,hintText: "Garage Bio",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Garage Address", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        InputField(inputController: googleP.searchController,maxLines: 2,hintText: "Garage Address",type: TextInputType.none,
                          onTap: (){
                           Get.to(()=>GoogleMapScreen());
                        },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextWidget1(text: stAdd, fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
                  SizedBox(height: 20,),
                  SubmitButton(title: "Next", press: () async {
                    if(formKey.currentState!.validate()){
                      if(value.image != null){
                        // var fileName = DateTime.now();
                        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("/${auth.currentUser!.uid}  ${garageP.image!.path.toString()}");
                        firebase_storage.UploadTask uploadImage = ref.putFile(File(garageP.image!.path.toString()));
                        await Future.value(uploadImage);
                        value.addDetail(garageNameC.text.toString(), garageOwnerC.text.toString(), garageContactC.text.toString(), garageBioC.text.toString());
                      }else{
                        ToastMsg().toastMsg("Add Image!");
                      }
                    }
                  }),
                  // SubmitButton(title: "Address", press: ()async{
                  //   List<Location> locations = await locationFromAddress(garageAddressC.text.toString());
                  //   setState(() {
                  //     stAdd = "${locations.last.latitude.toString()} "" ${locations.last.longitude.toString()}";
                  //   });
                  //   debugPrint("${stAdd}");
                  // }),
                ],
              ),
            ],
          ),
        );
      })
    );
  }
}
