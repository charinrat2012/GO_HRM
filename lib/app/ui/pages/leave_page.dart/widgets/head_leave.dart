import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadLeave extends StatelessWidget {
  const HeadLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                'ขอลางาน',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              elevation: 1.0,
              centerTitle: true,
              floating: false, // ทำให้ AppBar เลื่อนกลับมาแสดงผลได้เร็วขึ้น
              pinned: false, // ทำให้ AppBar ปักหมุดอยู่ด้านบนเสมอ
              expandedHeight: kToolbarHeight,
            );
  }
}