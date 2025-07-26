// lib/app/ui/pages/create_album_page/create_album_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart'; // Import FilePicker
import '../../../config/my_colors.dart'; // Import MyColors
import 'create_album_controller.dart';

class CreateAlbumPage extends GetView<CreateAlbumController> {
  const CreateAlbumPage({super.key});

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
            'สร้างอัลบั้มใหม่',
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
                  controller: controller.albumNameController,
                  decoration: const InputDecoration(
                    labelText: 'ชื่ออัลบั้ม',
                    hintText: 'กรุณาตั้งชื่ออัลบั้ม',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                _buildImageAttachmentSection(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.createAlbum,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.blue2,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('สร้างอัลบั้ม'),
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
          'รูปภาพในอัลบั้ม (อย่างน้อย 1 รูป)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Obx(() {
          if (controller.pickedImagePaths.isEmpty) {
            return _buildEmptyPicker(() => controller.pickImages());
          } else {
            return Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: controller.pickedImagePaths.length,
                  itemBuilder: (context, index) {
                    final path = controller.pickedImagePaths[index];
                    return _buildImageItem(path, () => controller.removeImage(index));
                  },
                ),
                const SizedBox(height: 12),
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
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10), // [แก้ไข] ลบ const ออก
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate, size: 24, color: MyColors.blue2),
            SizedBox(width: 8),
            Text(
              'เพิ่มรูปภาพอีก',
              style: TextStyle(color: MyColors.blue2, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}