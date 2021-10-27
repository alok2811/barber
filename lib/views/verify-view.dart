import 'package:barber/controller/verify-controller.dart';
import 'package:barber/helper/custom-functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class VerifyView extends StatelessWidget {
  final phoneNumber;
  final verificationId;
  VerifyView({this.phoneNumber,this.verificationId});
  final controller = Get.put(VerifyController());

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
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Image.asset('assets/images/app-logo.png'),

              Text('One Time Password (OTP) has been sent to your mobile $phoneNumber, please enter OTP here to verify your mobile.',),
              SizedBox( height: 20,),

              PinCodeTextField(
                autoFocus: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: Colors.grey,
                  selectedColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  selectedFillColor: Theme.of(context).textTheme.button!.color
                ),
                textStyle: TextStyle(color: Theme.of(context).textTheme.button!.color),
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                animationDuration: Duration(milliseconds: 300),
                onCompleted: (value) async {
                  await CustomFunctions.showLoaderDialog(context);
                  await CustomFunctions.hideKeyboard(context);
                  controller.smsCode.value = value.toString();
                  controller.submitOTP(context,verificationId, controller.smsCode.value,phoneNumber);
                },
                onChanged: (value) {
                    controller.smsCode.value = value.toString();

                }, appContext: context,
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async {
                  await CustomFunctions.showLoaderDialog(context);
                  controller.submitOTP(context,verificationId, controller.smsCode.value, phoneNumber);
                }, child: Text('Submit'),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
