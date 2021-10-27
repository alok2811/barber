import 'package:barber/controller/update-profile-controller.dart';
import 'package:barber/widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class UpdateProfileView extends StatelessWidget {
  final controller = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text('Update Profile'),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
          ),
          child: editUserInfo(context)
      ),
    );
  }

  Widget editUserInfo(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Stack(
                children: [
            Obx(() =>  CircleAvatar(
                    radius: 70.0,
                    backgroundImage:
                   NetworkImage(controller.imageUrl.value),
                    backgroundColor: Colors.transparent,
                  )),

                  Positioned(
                      bottom: 0,
                      right: -22,
                      child: RawMaterialButton(
                        onPressed: () {
                          Get.defaultDialog(title: 'Profile Photo',content: pickImageDialog(context));
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(Icons.add_a_photo, color: Theme.of(context).primaryColor,),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      )),


                ],
              ),
            ),
            const SizedBox(height: 10,),

            const Text('User Name',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800), textAlign: TextAlign.left,),
            const SizedBox(height: 10,),
            makeInput(context, label: 'Enter Name', controller: controller.nameController,prefix: Icon(Icons.person)),

            const SizedBox(height: 10,),

            const Text('Sex', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: [
                    Obx(() => Radio(
                      value: 1,
                      groupValue: controller.radioButtonId.value,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        controller.sex.value = 'Male';
                        controller.radioButtonId.value = 1;

                      },
                    ),),
                    const Text(
                      'Male',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Obx(() => Radio(
                      value: 2,
                      groupValue:  controller.radioButtonId.value,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        controller.sex.value = 'Female';
                        controller.radioButtonId.value = 2;
                      },
                    ),),
                    const Text(
                      'Female',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),

                  ],
                ),

              ],
            ),

            const Text('Date of Birth', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),),
            const SizedBox(height: 10,),
            InkWell(
                onTap: (){
                  controller.selectDate(context);
                },
                child: TextField(
                  enabled: false,
                  controller: controller.dobController,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                    hintText: 'Select your DOB',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                )
            ),
            const SizedBox(height: 10,),

            const Text('Email Address', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),),
            const SizedBox(height: 10,),
            makeInput(context,label: 'Enter your Email Address', controller: controller.emailController, prefix: Icon(Icons.email)),
            const SizedBox(height: 10,),
            const Text('Complete Address', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),),
            const SizedBox(height: 10,),
            makeInput(context,label: 'Enter your Complete Address (with house no.)', controller: controller.addressController, prefix: Icon(Icons.location_on)),

            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton( child: Text('Save'),

                  onPressed: () async {
                controller.validation(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget pickImageDialog(context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            icon: Icon(Icons.camera, color: Colors.white,),
            label: Text('Take A Photo From CAMERA'),
            onPressed: () {
              Get.back();
              controller.pickImage(context, ImageSource.camera);
            },
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            icon: Icon(Icons.photo, color: Colors.white,),
            label: Text('Take A Photo From GALLERY'),
            onPressed: () {
              Get.back();
              controller.pickImage(context, ImageSource.gallery);
            },
          ),
        ),
      ],
    );
  }

}
