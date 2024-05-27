import 'package:car_mechanics/helpers/images_path.dart';
import 'package:car_mechanics/screens/owner_screens/my_sevices/provider/owner_services_provider.dart';
import 'package:car_mechanics/screens/owner_screens/my_sevices/serivces_details/service_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../firebase_services/firebase_services.dart';
import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';
import '../my_garage/components/addnew_button.dart';
import '../update_garage_services/update_garage_services.dart';

class MyServices extends StatelessWidget {
  MyServices({super.key});

  var userUid = auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OwnerServicesProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "My Services", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
        actions: [
          AddNew(onTap: (){
            Get.to(()=>ServiceDetails());
          },),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("GarageOwners").doc(userUid).collection("garageServices").snapshots(),
          builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
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
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: appBarTextColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(height: 10.h,ImagesPath.GARAGE_IMAGE),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(text: doc['serviceCategory'].toString(), fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                              TextWidget(text: doc['serviceCharges'].toString(), fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                              TextWidget(text: doc['serviceProvider'].toString(), fontSize: 14.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            Get.to(()=>UpdateServiceDetails(id: doc['id'].toString(),));
                          }, icon: Icon(Icons.edit,)),
                          IconButton(onPressed: (){
                            provider.deleteService(doc['id']).toString();
                          }, icon: Icon(Icons.delete,)),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }
      ),
    );
  }
}
