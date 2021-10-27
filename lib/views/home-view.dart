import 'package:barber/controller/home-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() =>Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          controller.changeTabIndex(index);
        },
        currentIndex: controller.tabIndex.value,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.notes), label: 'Order'),

          BottomNavigationBarItem(
              icon: new Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
              icon: new Icon(Icons.person), label: 'Profile'),
        ],
      ),

      body: Center(
        child: controller.widgetOptions.elementAt(controller.tabIndex.value),
      ),
    ));
  }
}
