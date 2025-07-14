import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsDetailsHead extends StatelessWidget {
  const NewsDetailsHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: -10,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      floating: false,
      pinned: false,
      expandedHeight: kToolbarHeight,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: Get.back,
      ),
      title: const Text(
        'ย้อนกลับ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
