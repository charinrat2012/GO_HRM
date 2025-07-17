import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalartDetailHead extends StatelessWidget {
  const SalartDetailHead({super.key});

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
        'รายระเอียดเงินเดือน',
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
