import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class MeetingDetailPageController extends GetxController {
  final RxList<File> pickedFiles = <File>[].obs;

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

  // --- เมธอดสำหรับลบไฟล์ออกจาก List ---
  void removeFile(int index) {
    if (index >= 0 && index < pickedFiles.length) {
      pickedFiles.removeAt(index);
    }
  }
}
