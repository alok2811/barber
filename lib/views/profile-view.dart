import 'package:barber/controller/profile-controller.dart';
import 'package:barber/views/login-view.dart';
import 'package:barber/views/update-profile-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Profile'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasData){
              Map map = snapshot.data!.data() as Map;

              return SingleChildScrollView(
                physics:  const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Obx(() =>  CircleAvatar(
                        radius: 70.0,
                        backgroundImage:
                        NetworkImage(controller.imageUrl.value),
                        backgroundColor: Colors.transparent,
                      )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                          borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                FirebaseAuth.instance.currentUser!.displayName!,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Icon(Icons.person,),
                          ],
                        )),


                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                          borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(map['dob'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Icon(Icons.calendar_today)
                          ],
                        )),

                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                          borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                map['email'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Icon(
                              Icons.email,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                          borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                map['sex'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Icon(
                              MdiIcons.genderMaleFemale,
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 10,
                    ),



                    Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                          borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                map['phone'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ), Icon(
                              MdiIcons.phone,
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                          borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                map['address'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ), Icon(
                              Icons.location_on,
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 10,
                    ),


                    InkWell(
                      onTap: (){
                        Get.defaultDialog(title: "Log-Out",
                            middleText: "Are you sure you want to exit!",
                          actions: [
                            TextButton(onPressed: (){
                              Get.back();
                            }, child: Text('Cancel')),
                            TextButton(onPressed: (){
                              FirebaseAuth.instance.signOut();
                              Get.offAll(() => LoginView());
                            }, child: Text('Yes')),
                          ]
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration:  BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            border: Border.all(color: Theme.of(context).secondaryHeaderColor,width: 2),
                            borderRadius: BorderRadius.circular(10),),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                 'Logout',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ), Icon(
                                Icons.power_settings_new,
                              ),
                            ],
                          )),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        Get.to(() => UpdateProfileView());
                      }, child: Text('Edit Profile', style: Theme.of(context).textTheme.button,),),),
                    const SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

}
