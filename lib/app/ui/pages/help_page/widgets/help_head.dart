import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpHead extends StatelessWidget {
  const HelpHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14.0),
        onPressed: () {
          Get.back();
        },
      ),
      title: const Text(
        'ช่วยเหลือ',
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
