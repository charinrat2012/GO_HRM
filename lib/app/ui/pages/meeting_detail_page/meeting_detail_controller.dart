import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../data/models/calender_model.dart';

class MeetingDetailController extends GetxController {
  final RxList<File> pickedFiles = <File>[].obs;
   late final CalenderEventModel event;

  // Function สำหรับเลือกหลายไฟล์/รูปภาพ
  Future<void> pickMultipleFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        pickedFiles.addAll(result.paths.map((path) => File(path!)));
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกไฟล์ได้: $e');
    }
  }
  @override
  void onInit() {
    super.onInit();

    event = Get.arguments as CalenderEventModel;
  }
  // --- เมธอดสำหรับลบไฟล์ออกจาก List ---
  void removeFile(int index) {
    if (index >= 0 && index < pickedFiles.length) {
      pickedFiles.removeAt(index);
    }
  }
}
