// lib/app/bindings/edit_note_binding.dart
import 'package:get/get.dart';
import '../ui/pages/edit_note_page/edit_note_controller.dart';

class EditNoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditNoteController>(() => EditNoteController());
  }
}