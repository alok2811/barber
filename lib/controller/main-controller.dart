import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class MainController extends GetxController{

Future<List> getAllData() async{
   var list =[].obs;
   await FirebaseFirestore.instance.collection("LookBook").get().then((querySnapshot) {
    list.clear();
    querySnapshot.docs.forEach((result) {
      list.add(result.data());
    });
   });
   return list;
 }
 @override
  void onInit() {
    // TODO: implement onInit
   getAllData();
    super.onInit();
  }
}
