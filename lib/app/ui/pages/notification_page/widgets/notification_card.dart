// lib/app/ui/pages/notification_page/widgets/notification_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import '../../../../data/models/notification_model.dart';
import '../notification_controller.dart';

class NotificationCard extends GetView<NotificationController> {
  final NotificationModel notification;
  final int index;
  final bool isComplaint;

  NotificationCard({super.key, required this.notification, required this.index})
    : isComplaint = notification.type == "ร้องเรียน"; //ถ้ามีสถานะเป็นร้องเรียน ก็จะไม่ต้องมีicon ลูกศร

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: notification.isExpanded.value && !isComplaint
              ? BorderSide(color: MyColors.blue, width: 2.0)
              : BorderSide(color: Colors.transparent),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (!isComplaint) { //ถ้าเป็นtrue คือร้องเรียน จะไม่แสดงไอคอน ถ้าเป็นfalse จะแสดงไอคอนลูกศร
                    controller.toggleNotificationExpansion(index);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        notification.type,
                        style: TextStyle(
                          color: MyColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0, // <-- ปรับขนาดฟอนต์ของ type ที่นี่
                        ),
                      ),
                    ),
                    if (!isComplaint)
                      Icon(
                        notification.isExpanded.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                notification.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // หัวเรื่อง
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                notification.date,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.0,
                ), // วันที่
              ),
              //ควบคุมให้ส่วนของ หมายเหตุ,ปฏิเสธ,อนุมัติ 
              //จะปรากฏขึ้นมาก็ต่อเมื่อการ์ดแจ้งเตือนนั้นถูกขยายออก และ การแจ้งเตือนนั้นไม่ใช่ประเภท "ร้องเรียน" เท่านั้น
              if (notification.isExpanded.value && !isComplaint) ...[
                const SizedBox(height: 16.0),
                const Text(
                  'หมายเหตุ:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: MyColors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: Text(
                          'ปฏิเสธ',
                          style: TextStyle(color: MyColors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: const Text(
                          'อนุมัติ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
