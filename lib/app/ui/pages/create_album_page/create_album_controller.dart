// File: lib/app/ui/pages/create_album_page/create_album_controller.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

import '../../../data/models/album_model.dart';
import '../../../data/models/chat_model.dart'; // Import Chat model
import '../../../data/services/auth_service.dart'; // Import AuthService
import '../../../ui/utils/assets.dart'; // Import Assets

class CreateAlbumController extends GetxController {
  final TextEditingController albumNameController = TextEditingController();
  final RxList<String> pickedImagePaths = <String>[].obs;

  late final Chat chat; // เก็บ Chat object ที่ส่งมา

  @override
  void onInit() {
    super.onInit();
    // รับ Chat object จาก arguments
    if (Get.arguments is Chat) {
      chat = Get.arguments as Chat;
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชทสำหรับสร้างอัลบั้ม');
      Get.back();
    }
  }

  @override
  void onClose() {
    albumNameController.dispose();
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

  void createAlbum() {
    final albumName = albumNameController.text.trim();

    if (albumName.isEmpty) {
      Get.snackbar('ข้อผิดพลาด', 'กรุณาใส่ชื่ออัลบั้ม');
      return;
    }
    if (pickedImagePaths.isEmpty) {
      Get.snackbar('ข้อผิดพลาด', 'กรุณาเลือกรูปภาพอย่างน้อย 1 รูปสำหรับอัลบั้ม');
      return;
    }

    final newAlbum = Album(name: albumName, imagePaths: pickedImagePaths.toList());

    // เพิ่มอัลบั้มใหม่เข้าสู่ chat.albums โดยตรง
    chat.albums.add(newAlbum);

    // สร้าง Message สำหรับอัลบั้มและเพิ่มเข้าสู่ chat.messages
    final currentUser = Get.find<AuthService>().currentUser.value;
    final newMessage = Message(
      senderName: currentUser?.userName ?? 'Me',
      senderImageUrl: currentUser?.imgProfile ?? Assets.assetsImgsProfile,
      text: 'อัลบั้ม: $albumName', // [แก้ไข] แสดงชื่ออัลบั้มเป็นข้อความ
      // เพิ่ม imagePath โดยใช้รูปภาพแรกของอัลบั้มเป็น thumbnail
      imagePath: pickedImagePaths.isNotEmpty ? pickedImagePaths.first : null, // [แก้ไข] เพิ่ม imagePath ตรงนี้
      time: DateFormat('HH:mm').format(DateTime.now()), // เวลาปัจจุบัน
      isMe: true,
      album: newAlbum, // แนบ AlbumModel เข้าไปใน Message
    );
    chat.messages.add(newMessage);
    chat.lastMessage.value = 'สร้างอัลบั้ม: "$albumName"'; // อัปเดตข้อความล่าสุด
    chat.time.value = DateFormat('HH:mm').format(DateTime.now()); // อัปเดตเวลาล่าสุด

    Get.back(); // ปิดหน้าสร้างอัลบั้ม
    Get.snackbar('สำเร็จ', 'สร้างอัลบั้ม "$albumName" เรียบร้อยแล้ว!');
  }
}