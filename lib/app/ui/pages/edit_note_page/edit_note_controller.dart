// lib/app/ui/pages/edit_note_page/edit_note_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart'; // [เพิ่ม] Import FilePicker

import '../../../data/models/note_model.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/services/auth_service.dart';

class EditNoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final RxList<String> pickedImagePaths = <String>[].obs;

  late NoteModel originalNote;
  late final Chat chat;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Map && Get.arguments.containsKey('note') && Get.arguments.containsKey('chat')) {
      originalNote = Get.arguments['note'] as NoteModel;
      chat = Get.arguments['chat'] as Chat;

      titleController.text = originalNote.title;
      contentController.text = originalNote.content;
      pickedImagePaths.assignAll(originalNote.imagePaths);
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลโน้ตหรือแชทสำหรับแก้ไข');
      Get.back();
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  // [เพิ่ม] เมธอด pickImages()
  Future<void> pickImages() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        allowCompression: true,
      );
      if (result != null && result.paths.isNotEmpty) {
        final newPaths = result.paths.whereType<String>().toList();
        pickedImagePaths.addAll(newPaths);
      }
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้: $e');
    }
  }

  void addImages(List<String> newPaths) {
    pickedImagePaths.addAll(newPaths);
  }

  void removeImage(int index) {
    if (index >= 0 && index < pickedImagePaths.length) {
      pickedImagePaths.removeAt(index);
    }
  }

  void saveNote() {
    final updatedTitle = titleController.text.trim();
    final updatedContent = contentController.text.trim();

    if (updatedTitle.isEmpty) {
      Get.snackbar('ข้อผิดพลาด', 'กรุณาใส่ชื่อโน้ต');
      return;
    }

    final currentUser = _authService.currentUser.value;
    final senderId = currentUser?.userId ?? '';
    final senderName = currentUser?.userName ?? 'ผู้ใช้ไม่ระบุชื่อ';
    final senderImageUrl = currentUser?.imgProfile ?? '';

    final updatedNote = originalNote.copyWith(
      title: updatedTitle,
      content: updatedContent,
      imagePaths: pickedImagePaths.toList(),
      senderName: originalNote.senderId == senderId ? senderName : originalNote.senderName,
      senderImageUrl: originalNote.senderId == senderId ? senderImageUrl : originalNote.senderImageUrl,
    );

    final index = chat.notes.indexWhere((note) => note.id == originalNote.id);
    if (index != -1) {
      chat.notes[index] = updatedNote;
      Get.back();
      Get.snackbar('สำเร็จ', 'แก้ไขโน้ต "$updatedTitle" แล้ว');
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบโน้ตที่ต้องการแก้ไข');
    }
  }
}