import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../notification_controller.dart';
import 'notification_card.dart';

class NotificationList extends GetView<NotificationController> {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList(
        //คือ Obx คือคอยตรวจสอบและสั่งให้ SliverList อัปเดตตัวเองตามข้อมูลที่เปลี่ยนแปลง
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            //SliverListสร้าง Widget สำหรับแต่ละรายการ โดยใช้ฟังก์ชันนี้ในการกำหนดว่าแต่ละรายการ ตามลำดับ
            final notification = controller
                .notifications[index]; //ลำดับรับมาจาก SliverChildBuilderDelegate ไปใช้เป็นตัวระบุตำแหน่ง เพื่อ ดึงข้อมูล
            return NotificationCard(
              //สร้างกราด์ขึ้นในการ์ดจะมีข้อมูลเฉพาะและรู้ว่าตัวเองอยู่ลำดัยที่เท่าไหร่
              notification: notification,
              index: index,
            );
          },
          childCount: controller.notifications.length,
        ), //บอกSliverList ให้รู้ถึงขอบเขตการเลื่อนว่าต้องเลือนถึงไหน
      ),
    );
  }
}
