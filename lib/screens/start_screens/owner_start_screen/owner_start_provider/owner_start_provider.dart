import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../firebase_services/firebase_services.dart';
import '../../../../utils/toast_msg.dart';
import '../../../owner_screens/owner_home_screen/owner_home_screen.dart';

class OwnerStartProvider extends ChangeNotifier{

  bool isLoading = false;

  void signup(String emailC,String nameC,String phoneC,String passwordC) async {
    isLoading = true;
    auth.createUserWithEmailAndPassword(
        email: emailC,
        password: passwordC)
        .then((value) async {
      String? userUID = auth.currentUser!.uid;
      await fireStore.collection("Garage Owners").doc(userUID).set({
        "email": emailC,
        "name": nameC,
        "phone": phoneC,
        "userUID": userUID,
      }).whenComplete(() {
        Get.off(()=>OwnerHomeScreen());
        isLoading = false;
        notifyListeners();
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  void signIn(String emailC,String passwordC){
    isLoading = true;
    auth.signInWithEmailAndPassword(email: emailC, password: passwordC)
        .then((value) {
      isLoading = false;
      Get.off(()=>OwnerHomeScreen());
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      ToastMsg().toastMsg(error.toString());
      notifyListeners();
    });
    notifyListeners();
  }

}