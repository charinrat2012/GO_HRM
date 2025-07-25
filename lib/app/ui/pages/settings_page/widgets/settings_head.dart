import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsHead extends StatelessWidget {
  const SettingsHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14.0),
        onPressed: () {
          Get.back();
        },
      ),
      title: const Text(
        'การตั้งค่า',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
