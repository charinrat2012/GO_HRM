import 'package:get/get.dart';
import '../ui/pages/notes_page/notes_controller.dart';
import '../ui/pages/create_note_page/create_note_controller.dart';


class NotesBinding implements Bindings {
  @override
  void dependencies() {
    // [แก้ไข] เปลี่ยนกลับเป็น Get.lazyPut()
    // เพราะ NotesController จะจัดการโน้ตสำหรับ Chat object เฉพาะที่ถูกส่งมา
    // และ Chat object เองจะคงอยู่ด้วย ChatsController
    Get.lazyPut<NotesController>(() => NotesController());
    Get.lazyPut<CreateNoteController>(() => CreateNoteController());
  }
}