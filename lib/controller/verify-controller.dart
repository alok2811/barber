import 'package:barber/helper/custom-functions.dart';
import 'package:barber/views/home-view.dart';
import 'package:barber/views/update-profile-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController{
  var smsCode =''.obs;

  Future<void> submitOTP(BuildContext context, String verificationId, String smsCode, String phoneNumber) async {
    /// get the `smsCode` from the user
    String otp = smsCode.toString().trim();

    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        await CustomFunctions.closeLoaderDialog(context);
        if (userCredential.additionalUserInfo!.isNewUser) {
          Get.offAll(() => UpdateProfileView());
        }
        else {
          Get.offAll(() => HomeView());
        }

      } else {
        await CustomFunctions.closeLoaderDialog(context);
        Fluttertoast.showToast(msg: 'Sorry, Something wrong!');
      }
    }catch(e){
      await CustomFunctions.closeLoaderDialog(context);
      print(e);
    }

  }
}