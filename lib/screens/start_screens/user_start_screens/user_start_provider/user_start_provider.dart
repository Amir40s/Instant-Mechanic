import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../firebase_services/firebase_services.dart';
import '../../../../utils/toast_msg.dart';
import '../../../user_screens/user_home_screen/user_home_screen.dart';

class UserStartProvider extends ChangeNotifier{
  bool isLoading = false;
  signIn(String emailC,String passwordC){
    isLoading = true;
    auth.signInWithEmailAndPassword(email: emailC, password: passwordC)
        .then((value) {
      Get.off(()=>UserHomeScreen());
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      ToastMsg().toastMsg(error.toString());
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }
  void signup(String emailC,String nameC,String phoneC,String passwordC) async {
    isLoading = true;
    auth.createUserWithEmailAndPassword(
        email: emailC,
        password: passwordC)
        .then((value) async {
      String? userUID = auth.currentUser!.uid;
      await fireStore.collection("UserOwners").doc(userUID).set({
        "email": emailC,
        "name": nameC,
        "phone": phoneC,
        "userUID": userUID,
        "type" : "User"
      }).whenComplete(() {
        Get.off(()=>UserHomeScreen());
        isLoading = false;
        notifyListeners();
      });
    }).onError((error, stackTrace) {
      ToastMsg().toastMsg(error.toString());
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }
}