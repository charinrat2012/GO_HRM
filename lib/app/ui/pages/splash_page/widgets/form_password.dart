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
        Obx(
          () => TextField(
            controller: controller.passwordController,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            keyboardType: TextInputType.visiblePassword,
            obscureText: controller.obscureText,
            decoration: InputDecoration(
              isDense: false,
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
                
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
                
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
                
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  controller.obscureText = !controller.obscureText;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
