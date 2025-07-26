import 'package:get/get.dart';
import '../ui/pages/note_detail_page/note_detail_controller.dart'; // ตรวจสอบเส้นทาง controller ให้ถูกต้อง

class NoteDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteDetailController>(() => NoteDetailController());
  }
}