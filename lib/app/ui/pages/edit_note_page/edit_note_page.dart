// lib/app/ui/pages/edit_note_page/edit_note_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../../routes/app_routes.dart';
import 'edit_note_controller.dart';
import '../../../ui/utils/assets.dart';
import '../../../config/my_colors.dart'; // Import MyColors

class EditNotePage extends GetView<EditNoteController> {
  const EditNotePage({super.key});

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
            'แก้ไขโน้ต',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อโน้ต',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.contentController,
                decoration: const InputDecoration(
                  labelText: 'เนื้อหาโน้ต',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                minLines: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'รูปภาพประกอบ (ไม่บังคับ)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return GridView.builder(
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
                    final imagePath = controller.pickedImagePaths[index];
                    final bool isAsset = imagePath.startsWith('assets/');
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: isAsset
                              ? Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(color: Colors.grey[200], child: const Icon(Icons.broken_image));
                                  },
                                )
                              : Image.file(
                                  File(imagePath),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(color: Colors.grey[200], child: const Icon(Icons.broken_image));
                                  },
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () => controller.removeImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
              const SizedBox(height: 16),
              // ปุ่ม "เพิ่มรูปภาพอีก" ถูกปรับแก้ Row และ MainAxisSize
              _buildAddMoreImagesButton(() async {
                final result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.image,
                  allowCompression: true,
                );
                if (result != null && result.paths.isNotEmpty) {
                  final newPaths = result.paths.whereType<String>().toList();
                  controller.addImages(newPaths);
                }
              }),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.blue2,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('บันทึกโน้ต', style: TextStyle(fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildAddMoreImagesButton ถูกแก้ไขให้ไอคอนและข้อความอยู่บรรทัดเดียวกัน
  Widget _buildAddMoreImagesButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color.fromRGBO(204, 218, 255, 1)),
        ),
        child: Row( // เปลี่ยนจาก Column เป็น Row
          mainAxisAlignment: MainAxisAlignment.center, // จัดตำแหน่งให้อยู่ตรงกลางแนวนอน
          mainAxisSize: MainAxisSize.min, // ทำให้ Row ใช้พื้นที่เท่าที่จำเป็น
          children: const [
            Icon(Icons.add_photo_alternate, size: 24, color: MyColors.blue2), // ปรับขนาดไอคอนเล็กน้อยเพื่อให้ดูดีขึ้น
            SizedBox(width: 8), // เพิ่มระยะห่างระหว่างไอคอนกับข้อความ
            Text(
              'เพิ่มรูปภาพอีก',
              style: TextStyle(color: MyColors.blue2, fontSize: 16), // ปรับขนาดฟอนต์เล็กน้อย
            ),
          ],
        ),
      ),
    );
  }
}