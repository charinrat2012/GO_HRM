import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../splash_controllers.dart';

class FormPassword extends GetView<SplashController> {
  const FormPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("รหัสผ่าน", style: TextStyle(color: Colors.black)),
        TextField(
          controller: controller.passwordController,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: const EdgeInsets.all(14.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
          ),
        ),
      ],
    );
  }
}