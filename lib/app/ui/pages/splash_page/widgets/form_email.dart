import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../splash_controllers.dart';

class FormEmail extends GetView<SplashController> {
  const FormEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("อีเมล", style: TextStyle(color: Colors.black)),
        TextField(
          controller: controller.emailController,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
          keyboardType: TextInputType.emailAddress,

          obscureText: false,
          decoration: InputDecoration(
            isDense: false,
            hintText: 'Email',
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
          ),
        ),
      ],
    );
  }
}
