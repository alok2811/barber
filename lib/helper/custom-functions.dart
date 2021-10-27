import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';

class CustomFunctions{

  static void showToast(BuildContext context, String s) async{
    await Fluttertoast.showToast(msg: s,
        textColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        fontSize: 16
    );
  }

  static showLoaderDialog(BuildContext context) async{
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Theme.of(context).primaryColor
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false
      ..dismissOnTap= false;

    await EasyLoading.show(status: 'Please Wait...',);
  }
  static  closeLoaderDialog(BuildContext context) async{
    await EasyLoading.dismiss();
  }
  static getLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      await Geolocator.requestPermission();
    }else if(permission == LocationPermission.deniedForever){
      await Geolocator.openLocationSettings();
    }else{
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'latitude' : position.latitude,
        'longitude' : position.longitude,
          });

    }

  }
  static hideKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}