
import 'package:barber/helper/custom-functions.dart';
import 'package:flutter/material.dart';
import 'package:barber/views/main-view.dart';
import 'package:barber/views/order-view.dart';
import 'package:barber/views/profile-view.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var tabIndex = 1.obs;



  List<Widget> widgetOptions = [
    OrderView(),
    MainView(),
    ProfileView()
  ];

  void changeTabIndex(int index){
    tabIndex.value = index;
  }

  @override
  void onInit() {
    CustomFunctions.getLocation();
    super.onInit();
  }

}