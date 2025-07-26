import 'package:get/get.dart';

import '../../../data/models/note_model.dart';
import '../../../data/models/chat_model.dart';

class NotesController extends GetxController {
  late final Chat chat;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Chat) {
      chat = Get.arguments as Chat;
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชทสำหรับโน้ต');
      Get.back();
    }
  }

  void addNote(NoteModel newNote) {
    chat.notes.add(newNote);
  }

  // [แก้ไข] เมธอด updateNote ที่ถูกต้อง
  void updateNote(NoteModel updatedNote) {
    final index = chat.notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      chat.notes[index] = updatedNote;
      // เนื่องจาก chat.notes เป็น RxList การอัปเดตสมาชิกโดยตรงจะ trigger UI update
      // แต่ถ้าต้องการให้แน่ใจว่า UI อัปเดตทันที (เช่น กรณีที่ข้อมูลภายใน NoteModel เปลี่ยนแต่ ID ไม่เปลี่ยน)
      // สามารถใช้ chat.notes.refresh(); ได้ แต่โดยปกติแล้ว GetX จะจัดการให้
    }
  }

  void deleteNote(String id) {
    chat.notes.removeWhere((note) => note.id == id);
  }
}