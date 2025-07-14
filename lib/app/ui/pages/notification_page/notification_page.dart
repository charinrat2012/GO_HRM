import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_controller.dart'; 
import 'widgets/notification_card.dart'; 

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: false,
              pinned: false,
              expandedHeight: kToolbarHeight, //กำหนดความสูงAppbar
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 14,
                ),
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
            ),
            Obx(
              () => SliverList( //คือ Obx คือคอยตรวจสอบและสั่งให้ SliverList อัปเดตตัวเองตามข้อมูลที่เปลี่ยนแปลง
                delegate: SliverChildBuilderDelegate((context, index) {//SliverListสร้าง Widget สำหรับแต่ละรายการ โดยใช้ฟังก์ชันนี้ในการกำหนดว่าแต่ละรายการ ตามลำดับ
                  final notification = controller.notifications[index];//ลำดับรับมาจาก SliverChildBuilderDelegate ไปใช้เป็นตัวระบุตำแหน่ง เพื่อ ดึงข้อมูล 
                  return NotificationCard(//สร้างกราด์ขึ้นในการ์ดจะมีข้อมูลเฉพาะและรู้ว่าตัวเองอยู่ลำดัยที่เท่าไหร่
                    notification: notification,
                    index: index,
                  );
                }, childCount: controller.notifications.length),//บอกSliverList ให้รู้ถึงขอบเขตการเลื่อนว่าต้องเลือนถึงไหน
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}
