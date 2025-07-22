import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadLeaveRequest extends StatelessWidget {
  const HeadLeaveRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'ย้อนกลับ',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

      pinned: false,
      floating: false,
    );
  }
}
