import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../config/my_colors.dart';
import '../splash_controllers.dart';


class LoginButton extends GetView<SplashController> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.fetchLogin,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 45),
            backgroundColor: MyColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(64),
            ),
            
          ),
          child: const Text(
            'ลงชื่อเข้าใช้',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              
            ),
          ),
        ),
      ],
    );
  }
}