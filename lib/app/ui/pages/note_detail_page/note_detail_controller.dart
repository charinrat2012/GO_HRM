import 'package:get/get.dart';
import 'package:go_hrm/app/data/models/note_model.dart'; // ตรวจสอบเส้นทาง note_model.dart ให้ถูกต้อง

class NoteDetailController extends GetxController {
  // ใช้ late final เพื่อระบุว่า note จะถูกกำหนดค่าในภายหลัง (เมื่อ receive arguments)
  late final NoteModel note;

  @override
  void onInit() {
    super.onInit();
    // ดึง NoteModel จาก Get.arguments
    if (Get.arguments != null && Get.arguments is Map && Get.arguments.containsKey('note')) {
      note = Get.arguments['note'] as NoteModel;
    } else {
      // กรณีเกิดข้อผิดพลาด ไม่พบ NoteModel
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลโน้ตที่จะแสดง');
      Get.back();
    }
  }
}