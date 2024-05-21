import 'package:car_mechanics/screens/owner_screens/my_sevices/provider/owner_services_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import '../../../../helpers/images_path.dart';
import '../../../../helpers/input_fields.dart';
import '../../../../helpers/submit_button.dart';

class ServiceDetails extends StatelessWidget {
  ServiceDetails({super.key});

  var serviceCategoryC = TextEditingController();
  var serviceProviderC = TextEditingController();
  var serviceDetailC = TextEditingController();
  var serviceChargesC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double fieldH = 10;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "Add New Services", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
      body: Consumer<OwnerServicesProvider>(builder: (context,value,child){
        return value.isLoading == true ?  Center(
          child: CircularProgressIndicator(),
        )   :ListView(
          children: [
            Image.asset(ImagesPath.SERVICE_DETAIL_IMAGE),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "Services Category", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        SizedBox(height: fieldH,),
                        InputField(inputController: serviceCategoryC,hintText: "Service Type",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Service Provider Name", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor,),
                        SizedBox(height: fieldH,),
                        InputField(inputController: serviceProviderC,hintText: "Provider Name...",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Service Details", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        SizedBox(height: fieldH,),
                        InputField(inputController: serviceDetailC,maxLines: 3,hintText: "Details here...",),
                        SizedBox(height: fieldH,),
                        TextWidget(text: "Service Charges Rupees", fontSize: 14.dp, fontWeight: FontWeight.w500, isTextCenter: true, textColor: appColor),
                        InputField(inputController: serviceChargesC,hintText: "Total Charges",type: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  SubmitButton(title: "Save", press: (){
                    FocusScope.of(context).unfocus();
                    if(formKey.currentState!.validate()){
                      value.addService(serviceCategoryC.text, serviceProviderC.text, serviceDetailC.text, serviceChargesC.text);
                    }
                  }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
