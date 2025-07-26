// lib/app/ui/pages/create_note_page/create_note_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import 'package:file_picker/file_picker.dart';

import 'create_note_controller.dart';

class CreateNotePage extends GetView<CreateNoteController> {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 14.0,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'สร้างโน้ตใหม่',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อโน้ต',
                    hintText: 'กรุณาใส่ชื่อโน้ต',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'เนื้อหาโน้ต',
                    hintText: 'กรุณาใส่รายละเอียดของโน้ต',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                _buildImageAttachmentSection(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.createNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.blue2,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('บันทึกโน้ต'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รูปภาพประกอบ (ไม่บังคับ)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Obx(() {
          // [แก้ไข] Logic การแสดงผล เพื่อให้สอดคล้องกับ EditNotePage
          if (controller.pickedImagePaths.isEmpty) {
            // ถ้ายังไม่มีรูปภาพ ให้แสดงปุ่ม "เพิ่มรูปภาพ" แบบ EmptyPicker
            return _buildEmptyPicker(() => controller.pickImages());
          } else {
            // ถ้ามีรูปภาพแล้ว ให้แสดง GridView และปุ่ม "เพิ่มรูปภาพอีก"
            return Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0, // [แก้ไข] กำหนดอัตราส่วนเป็น 1.0
                  ),
                  itemCount: controller.pickedImagePaths.length,
                  itemBuilder: (context, index) {
                    final path = controller.pickedImagePaths[index];
                    return _buildImageItem(path, () => controller.removeImage(index));
                  },
                ),
                const SizedBox(height: 12),
                // [แก้ไข] ใช้ _buildAddMoreImagesButton (สไตล์ Container)
                _buildAddMoreImagesButton(() => controller.pickImages()),
              ],
            );
          }
        }),
      ],
    );
  }

  Widget _buildEmptyPicker(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromRGBO(204, 218, 255, 1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_photo_alternate, size: 30, color: MyColors.blue2),
            SizedBox(height: 4),
            Text(
              'เพิ่มรูปภาพ',
              style: TextStyle(color: MyColors.blue2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(String path, VoidCallback onRemove) {
    final bool isAsset = path.startsWith('assets/');
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: isAsset
              ? Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Image.file(
                  File(path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
        GestureDetector(
          onTap: onRemove,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildAddMoreImagesButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromRGBO(204, 218, 255, 1)),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_photo_alternate, size: 30, color: MyColors.blue2),
            SizedBox(width: 8),
            Text(
              'เพิ่มรูปภาพอีก',
              style: TextStyle(color: MyColors.blue2),
            ),
          ],
        ),
      ),
    );
  }
}