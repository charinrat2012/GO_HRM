import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationHead extends StatelessWidget {
  const NotificationHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      floating: false,
      pinned: false,
      expandedHeight: kToolbarHeight, //กำหนดความสูงAppbar
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14),
        onPressed: Get.back,
      ),
      title: const Text(
        'การแจ้งเตือน',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true, // กําหนดให้ title อยู่กลาง
    );
  }
}
