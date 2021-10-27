import 'package:barber/controller/login-controller.dart';
import 'package:barber/helper/custom-functions.dart';
import 'package:barber/views/verify-view.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Image.asset('assets/images/app-logo.png'),

                Text('We will send an one time SMS message to verify your phone number.Please enter your number!',),
                SizedBox( height: 20,),

                CountryCodePicker(
                  onChanged: (code){
                      controller.phoneCode.value = code.toString();
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: '+91',
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: true,

                  dialogBackgroundColor: Colors.black54,
                  searchStyle: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.button!.color),
                ),

            TextField(
              controller: controller.txtController,
              keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 20.0, color: Theme.of(context).textTheme.button!.color),
            decoration: const InputDecoration(
            label: Text("Phone Number",style: TextStyle(fontSize: 20), ),
            border: OutlineInputBorder(),
              hintText: 'Enter Phone Number',

        ),
      ),

                SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(onPressed: () async {

                      await CustomFunctions.hideKeyboard(context);
                      await CustomFunctions.showLoaderDialog(context);

                      if(controller.txtController.text.isEmpty){
                        await  CustomFunctions.closeLoaderDialog(context);
                        Fluttertoast.showToast(msg: 'Please enter a valid number!');
                      }else{
                        controller.sendOTP('${controller.phoneCode}${controller.txtController.text.toString()}', (verificationId, forceResendingToken) {
                          Get.off(() => VerifyView(phoneNumber: '${controller.phoneCode}-${controller.txtController.text.toString()}',
                              verificationId: verificationId));
                          CustomFunctions.closeLoaderDialog(context);
                        }, (error) {
                          CustomFunctions.closeLoaderDialog(context);
                          CustomFunctions.showToast(context, 'Something wants wrong!');
                          print(error);
                        });
                      }
                    },
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.phone),
                        Expanded(child: Text("Login With Phone",textAlign: TextAlign.center,)),
                      ],
                    ),
                    )),
              ],
            ),
          ),
        )
      ),
    );
  }

}
