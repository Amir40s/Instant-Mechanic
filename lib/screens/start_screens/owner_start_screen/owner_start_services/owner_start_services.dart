import 'package:car_mechanics/screens/owner_screens/owner_home_screen/owner_home_screen.dart';
import 'package:car_mechanics/screens/start_screens/owner_start_screen/owner_activity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class OwnerStartServices{
  void isLogin(context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Get.off(()=>OwnerHomeScreen());
    }else{
      Get.off(()=>OwnerLogInActivityScreens());
    }
  }
}