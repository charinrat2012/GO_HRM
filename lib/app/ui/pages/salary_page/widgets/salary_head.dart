import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalaryHead extends StatelessWidget {
  const SalaryHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: false,
      pinned: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14.0),
        onPressed: () {
          Get.back();
        },
      ),
      title: const Text(
        'เงินเดือน',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.save_alt, color: Colors.black, size: 18.0),
          onPressed: () {},
        ),
      ],
    );
  }
}
