import 'dart:io';
import 'package:car_mechanics/helpers/input_fields.dart';
import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:car_mechanics/screens/owner_screens/update_garage_details/provider/update_garage_details_provider.dart';
import 'package:car_mechanics/screens/owner_screens/update_garage_details/update_google_map_address/update_google_map_address.dart';
import 'package:car_mechanics/utils/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';

class ShopUpdateDetail extends StatefulWidget {
  ShopUpdateDetail({super.key,this.id});

  var id;

  @override
  State<ShopUpdateDetail> createState() => _ShopUpdateDetailState();
}

class _ShopUpdateDetailState extends State<ShopUpdateDetail> {

  // var garageNameC = TextEditingController();
  // var garageOwnerC = TextEditingController();
  // var garageContactC = TextEditingController();
  // var garageBioC = TextEditingController();
  // var garageAddressC = TextEditingController();

  // String idNum = widget.id;

  var formKey = GlobalKey<FormState>();

  String stAdd = "";

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    Provider.of<ShopDetailsUpdateProvider>(context,listen: false).getDetail(widget.id.toString());
    var garageUpDateP = Provider.of<ShopDetailsUpdateProvider>(context,listen: false);
    double fieldH = 10;
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: appColor,
          title: TextWidget(text: "Update Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
          actions: [
            TextButton(onPressed: (){
              garageUpDateP.deleteDetails(widget.id);
            }, child: Text("Delete",style: TextStyle(color: Colors.white),))
          ],
        ),
        body:Consumer<ShopDetailsUpdateProvider>(builder: (context,value,child){
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
                    TextWidget(text: "Add Mechanics Cover Image", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor,),
                    InkWell(
                        onTap: ()async{
                          garageUpDateP.pickImage();
                        },
                        child: SizedBox(width: 100.w,height: 25.h,child:value.image == null ? Image.network(value.imagePath,fit: BoxFit.fill,) : Image.file(File(value.image!.path),fit: BoxFit.fill,))),
                    SizedBox(height: 30,),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: "Mechanics Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                          SizedBox(height: fieldH,),
                          InputField(inputController: garageUpDateP.garageNameC,hintText: "Mechanics Name",),
                          SizedBox(height: fieldH,),
                          TextWidget(text: "Mechanics Owner Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor,),
                          SizedBox(height: fieldH,),
                          InputField(inputController: garageUpDateP.garageOwnerC,hintText: "Mechanics Owner Name",),
                          SizedBox(height: fieldH,),
                          TextWidget(text: "Mechanics Contact Number", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                          SizedBox(height: fieldH,),
                          InputField(inputController: garageUpDateP.garageContactC,type: TextInputType.number,hintText: "Mechanics Contact Number",),
                          SizedBox(height: fieldH,),
                          TextWidget(text: "Mechanics Bio", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                          SizedBox(height: fieldH,),
                          InputField(inputController: garageUpDateP.garageBioC,maxLines: 2,hintText: "Mechanics Bio",),
                          SizedBox(height: fieldH,),
                          TextWidget(text: "Mechanics Address", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                          InputField(inputController: garageUpDateP.garageAddressC,maxLines: 2,hintText: "Mechanics Address",type: TextInputType.none,
                              onTap: (){
                               Get.to(()=>UpdateGoogleMapAddress());
                            },
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 20,),
                    //TextWidget1(text: stAdd, fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: false, textColor: appColor),
                    SizedBox(height: 20,),
                    SubmitButton(title: "Update", press: (){
                      if(formKey.currentState!.validate()){
                        value.updateDetail(widget.id.toString());
                        // if(value.imagePath == ""){
                        //
                        // }else{
                        //   ToastMsg().toastMsg("Update Image!");
                        // }
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
