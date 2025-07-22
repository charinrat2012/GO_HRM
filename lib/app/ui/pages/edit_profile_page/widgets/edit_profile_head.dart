import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileHead extends StatelessWidget {
  const EditProfileHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

      floating: false,
      pinned: false,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: Get.back,
      ),
      title: const Text(
        'แก้ไขโปรไฟล์',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
