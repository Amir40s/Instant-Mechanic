import 'package:car_mechanics/screens/owner_screens/my_garage/components/addnew_button.dart';
import 'package:car_mechanics/screens/owner_screens/my_garage/provider/garage_provider.dart';
import 'package:car_mechanics/screens/owner_screens/update_garage_details/update_garage_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../firebase_services/firebase_services.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';
import '../update_garage_details/provider/update_garage_details_provider.dart';
import 'add_details/add_detail.dart';

class MyGarageScreen extends StatelessWidget {
  MyGarageScreen({super.key});

  var userUid = auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var garageP = Provider.of<GarageProvider>(context,listen: false);
    var garageUpDateP = Provider.of<ShopDetailsUpdateProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: appBarTextColor),
        backgroundColor: appColor,
        title: TextWidget(text: "My Shop", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appBarTextColor),
        actions: [
          AddNew(onTap: (){
            Get.to(()=>ShopAddDetail());
            garageP.image = null;
          },),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("GarageDetails").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return TextWidget(text: "Some Error", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor);
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return userUid == doc["userUid"] ? GestureDetector(
                onTap: (){
                  garageUpDateP.image = null;
                  Get.to(()=>ShopUpdateDetail(id: doc.id,));
                  debugPrint(doc.id);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: 100.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300
                        )
                      ],
                      color: appBarTextColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: doc['addDate'].toString(), fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                      SizedBox(height: 22.h,width:90.w ,child: Image.network(fit: BoxFit.fill,doc["imagePath"]),),
                      TextWidget(text: "Shop Name :  ${doc['garageName']}", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                      TextWidget(text: "Shop Owner Name :  ${doc['garageOwnerName']}", fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                    ],
                  ),
                ),
              ):const SizedBox();
            }).toList(),
          );
        },
      ),
    );
  }
}


