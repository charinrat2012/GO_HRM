import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityDetailHead extends StatelessWidget {
  const ActivityDetailHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14.0),
        onPressed: () {
          Get.back();
        },
      ),
      title: const Text(
        'รายละเอียดกิจกรรม',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      pinned: true,
    );
  }
}
