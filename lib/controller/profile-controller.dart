import 'dart:io';

import 'package:barber/helper/custom-functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  var imageUrl ='https://firebasestorage.googleapis.com/v0/b/barber-9ca8e.appspot.com/o/user.png?alt=media&token=8d22090f-d161-4243-b5cf-e20b4756b3b4'.obs;
  final ImagePicker picker = ImagePicker();
  @override
  void onInit() {
    // TODO: implement onInit

    if(FirebaseAuth.instance.currentUser!.photoURL != null){
      imageUrl.value = FirebaseAuth.instance.currentUser!.photoURL!;
    }

    super.onInit();
  }
}