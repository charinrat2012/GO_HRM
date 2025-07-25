import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/appeal_model.dart';
import '../../global_widgets/datalist.dart';

class CreateAppealRequestController extends GetxController {
  final RxList<AppealModel> appealItems = <AppealModel>[].obs;
  final Rx<AppealModel?> selectedAppeal = Rx(null);
  // สำหรับเก็บข้อมูลวันที่และเวลาที่เลือก
  final TextEditingController DateController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    loadDataType();
  }

  void loadDataType() {
    final List<AppealModel> appealTypes = DataList.appealTypes.map((map) {
      return AppealModel.fromMap(map);
    }).toList();

    // นำข้อมูลที่แปลงแล้วมาใส่ใน List ที่เป็น .obs
    appealItems.assignAll(appealTypes);

    // ตรวจสอบว่ามีข้อมูลใน List หรือไม่ แล้วกำหนดให้ตัวแรกเป็นค่าที่ถูกเลือกไว้
    if (appealItems.isNotEmpty) {
      selectedAppeal.value = appealItems.first;
    }
  }

  @override
  void onClose() {
    // ทำลาย Controller เพื่อป้องกัน Memory Leak
    DateController.dispose();
    detailsController.dispose();
    super.onClose();
  }

  // ฟังก์ชันสำหรับเลือกวันที่และเวลา
  Future<void> selectDateTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
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

  final RxList<File> pickedFiles = <File>[].obs;

  Future<void> pickMultipleFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'appeal', 'appealx'],
      );

      if (result != null) {
        pickedFiles.addAll(result.paths.map((path) => File(path!)));
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกไฟล์ได้: $e');
    }
  }

  // --- เมธอดสำหรับลบไฟล์ออกจาก List ---
  void removeFile(int index) {
    if (index >= 0 && index < pickedFiles.length) {
      pickedFiles.removeAt(index);
    }
  }
}
