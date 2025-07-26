// lib/app/ui/pages/create_note_page/create_note_controller.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for DateFormat
import '../../../data/models/note_model.dart';

import '../../../data/services/auth_service.dart';
import '../../../data/models/chat_model.dart';
import '../../../ui/utils/assets.dart';

class CreateNoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final RxList<String> pickedImagePaths = <String>[].obs;

  final AuthService _authService = Get.find<AuthService>();
  late final Chat chat;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Chat) {
      chat = Get.arguments as Chat;
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชทสำหรับสร้างโน้ต');
      Get.back();
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

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

  void removeImage(int index) {
    if (index >= 0 && index < pickedImagePaths.length) {
      pickedImagePaths.removeAt(index);
    }
  }

  void createNote() {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    final currentUser = _authService.currentUser.value;
    final senderId = currentUser?.userId ?? '';
    final senderName = currentUser?.userName ?? 'ผู้ใช้ไม่ระบุชื่อ';
    final senderImageUrl = currentUser?.imgProfile ?? Assets.assetsImgsProfile;

    if (title.isEmpty) {
      Get.snackbar('ข้อผิดพลาด', 'กรุณาใส่ชื่อโน้ต');
      return;
    }

    // สร้าง NoteModel ใหม่
    final newNote = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      senderName: senderName,
      senderImageUrl: senderImageUrl,
      title: title,
      content: content,
      imagePaths: pickedImagePaths.toList(),
    );

    // [แก้ไข] เพิ่มโน้ตเข้าสู่รายการโน้ตของแชท (ให้โน้ตล่าสุดอยู่บนสุด)
    chat.notes.insert(0, newNote);

    // [เพิ่ม] สร้าง Message ใหม่สำหรับโน้ตและเพิ่มเข้าสู่รายการข้อความของแชท
    final newMessage = Message(
      senderName: senderName,
      senderImageUrl: senderImageUrl,
      text: null, // Note messages don't have direct text content, it's in the note object
      time: DateFormat('HH:mm').format(DateTime.now()), // เวลาปัจจุบัน
      isMe: true, // หรือกำหนดตามผู้ใช้ปัจจุบัน
      note: newNote, // แนบ NoteModel เข้าไปใน Message
    );

    chat.messages.add(newMessage); // เพิ่มข้อความโน้ตเข้าสู่ chat.messages
    chat.lastMessage.value = 'สร้างโน้ต: "$title"'; // อัปเดตข้อความล่าสุด
    chat.time.value = DateFormat('HH:mm').format(DateTime.now()); // อัปเดตเวลาล่าสุด

    Get.back();
    Get.snackbar('สำเร็จ', 'สร้างโน้ต "$title" แล้ว');
  }
}