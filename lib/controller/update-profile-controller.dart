import 'dart:io';

import 'package:barber/helper/custom-functions.dart';
import 'package:barber/views/home-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateProfileController extends GetxController{

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController(text: 'Select your DOB');
  final addressController = TextEditingController();
  var sex = 'Male'.obs;
  var phoneCode = '+91'.obs;

  // Group Value for Radio Button.
  var radioButtonId = 1.obs;

  var imageUrl ='https://firebasestorage.googleapis.com/v0/b/barber-9ca8e.appspot.com/o/user.png?alt=media&token=8d22090f-d161-4243-b5cf-e20b4756b3b4'.obs;


  final ImagePicker picker = ImagePicker();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      dobController.text = DateFormat('MMMM dd, yyyy').format(pickedDate);
    }
  }

  Future<void> saveDataFirebase(BuildContext context) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(nameController.text.toString());

    var firebaseUser =  FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("Users").doc(firebaseUser!.uid).set(
        {
          'name': nameController.text.toString(),
          'email': emailController.text.toString().toLowerCase(),
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'sex': sex.toString(),
          'dob': dobController.text.toString(),
          'address': addressController.text.toString(),
          'phone': FirebaseAuth.instance.currentUser!.phoneNumber,
          'image': FirebaseAuth.instance.currentUser!.photoURL,
        }).then((_){
      Get.offAll(() => HomeView());
    }).catchError((onError){
      print(onError.toString());
    });

    await CustomFunctions.getLocation();
    await CustomFunctions.closeLoaderDialog(context);

  }

  Future<void> validation(BuildContext context) async {

    if(nameController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please enter a valid name!");
    }else if(sex.isEmpty){
      Fluttertoast.showToast(msg: "Please select your sex!");
    }else if(dobController.text.toString() == 'Select your DOB'){
      Fluttertoast.showToast(msg: "Please select your DOB!");
    }else if(emailController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please enter a valid email!");
    }else if((!emailController.text.toString().contains('@')) && (!emailController.text.toString().contains('.'))){
      Fluttertoast.showToast(msg: "Please enter a valid email!");
    }else if(addressController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please enter your complete address!");
    }else{
      await CustomFunctions.showLoaderDialog(context);
      saveDataFirebase(context);
    }

  }

 void pickImage(context, ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource,maxWidth:
    200, maxHeight: 300);

      if (pickedFile != null) {
        CustomFunctions.showLoaderDialog(context);
        var imageFile = File(pickedFile.path);
        uploadImageToFirebase(context, imageFile);
      } else {
        CustomFunctions.showToast(context, 'No image selected.');
      }

  }

  uploadImageToFirebase(context, imageFile) async {
    String fileName = basename(imageFile.path);
    var firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    uploadTask.then((res) async {
      var url = await res.ref.getDownloadURL();
      imageUrl.value = url;
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      CustomFunctions.closeLoaderDialog(context);
      CustomFunctions.showToast(context, 'Profile Updated Successful.');
    });
  }

  @override
  void onInit() {

    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
      if(value.data() != null){
        Map? map = value.data();
        nameController.text = map!['name'];
        dobController.text = map['dob'];
        addressController.text = map['address'];
        emailController.text = map['email'];
        if(map['sex'] == 'Male'){
          radioButtonId.value = 1;
        }else{
          radioButtonId.value = 2;
        }
        sex.value= map['sex'];
        if(FirebaseAuth.instance.currentUser!.photoURL != null){
          imageUrl.value = FirebaseAuth.instance.currentUser!.photoURL!;
        }

      }
    });
    super.onInit();
  }



}