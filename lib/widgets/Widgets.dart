import 'package:flutter/material.dart';

Widget makeInput(context, {label,obscureText = false, prefix,controller, inputType = TextInputType.text}){
  return TextField(
    obscureText: obscureText,
    controller: controller,
    keyboardType: inputType,
    style: Theme.of(context).textTheme.bodyText1,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
      prefixIcon: prefix,
      hintText: label,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
      ),
    ),
  );
}