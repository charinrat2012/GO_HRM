import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// --- ตรวจสอบว่า Path ของไฟล์ Model และ DataList ถูกต้อง ---
import '../../../data/models/quota_model.dart';
import '../../global_widgets/datalist.dart';

class CreateLeaveRequestController extends GetxController {
  // --- 1. เปลี่ยนมาใช้ List ของ Model สำหรับเก็บข้อมูลทั้งหมด ---
  final RxList<QuotaModel> quotaItems = <QuotaModel>[].obs;

  // --- 2. สร้าง State สำหรับเก็บ "ประเภทการลาที่ถูกเลือก" ---
  // ใช้ Rx<QuotaModel?> เพื่อให้สามารถเก็บอ็อบเจกต์ Model ทั้งก้อนได้
  final Rx<QuotaModel?> selectedQuota = Rx(null);

  // สำหรับเก็บข้อมูลวันที่และเวลาที่เลือก
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    loadQuotaData();
  }

  void loadQuotaData() {
    final List<QuotaModel> quotaData = DataList.quotasData.map((map) {
      return QuotaModel.fromMap(map);
    }).toList();

    // นำข้อมูลที่แปลงแล้วมาใส่ใน List ที่เป็น .obs
    quotaItems.assignAll(quotaData);

    // ตรวจสอบว่ามีข้อมูลใน List หรือไม่ แล้วกำหนดให้ตัวแรกเป็นค่าที่ถูกเลือกไว้
    if (quotaItems.isNotEmpty) {
      selectedQuota.value = quotaItems.first;
    }
  }

  @override
  void onClose() {
    // ทำลาย Controller เพื่อป้องกัน Memory Leak
    startDateController.dispose();
    endDateController.dispose();
    detailsController.dispose();
    super.onClose();
  }

  // ฟังก์ชันสำหรับเลือกวันที่และเวลา 
  Future<void> selectDateTime(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.text = DateFormat('dd/MM/yyyy HH:mm').format(finalDateTime);
      }
    }
  }

  // 1. สร้าง State สำหรับเก็บไฟล์รูปภาพที่เลือก (ใช้ .obs เพื่อให้สังเกตการณ์ได้)
  final Rx<File?> selectedImage = Rx(null);
  
  // 2. สร้างตัวแปรสำหรับเรียกใช้ ImagePicker
  final ImagePicker _picker = ImagePicker();

  // 3. สร้างเมธอดสำหรับเลือกรูปภาพจากแกลเลอรี
  Future<void> pickImage() async {
    try {
      // ใช้ _picker เพื่อเปิดหน้าแกลเลอรีและรอผู้ใช้เลือกรูป
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      // ตรวจสอบว่าผู้ใช้ได้เลือกรูปมาหรือไม่
      if (image != null) {
        // ถ้ามีรูป ให้แปลง XFile เป็น File แล้วเก็บไว้ใน State
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      // จัดการ Error กรณีที่เกิดปัญหา
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้');
    }
  }

  // 4. สร้างเมธอดสำหรับลบรูปภาพที่เลือก
  void removeImage() {
    selectedImage.value = null;
  }
}
