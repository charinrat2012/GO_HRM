import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_leave_request_controller.dart';

class FilePickerRequest extends GetView<CreateLeaveRequestController> {
  const FilePickerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'แนบรูปภาพ',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      // 1. หุ้มด้วย Obx เพื่อให้ UI อัปเดตเมื่อ selectedImage ใน Controller เปลี่ยน
      Obx(() {
        // 2. ตรวจสอบว่ามีรูปภาพถูกเลือกหรือยัง
        if (controller.selectedImage.value == null) {
          // --- ถ้ายังไม่มีรูป ---
          // แสดงกล่องสำหรับกดอัปโหลด
          return GestureDetector(
            onTap: controller.pickImage, // เมื่อแตะ ให้เรียกฟังก์ชันเลือกรูป
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined, size: 40, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text('อัปโหลดรูปภาพหรือไฟล์', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          );
        } else {
          // --- ถ้ามีรูปแล้ว ---
          // แสดงรูปภาพที่เลือกพร้อมปุ่มลบ
          return Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  controller.selectedImage.value!, // แสดงรูปจาก File
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // ปุ่มสำหรับลบรูป
              IconButton(
                onPressed: controller.removeImage,
                icon: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ],
          );
        }
      }),
    ],
  );
  }
}