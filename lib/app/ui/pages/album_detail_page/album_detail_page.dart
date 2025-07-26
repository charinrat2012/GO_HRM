// Path: lib/app/ui/pages/album_detail_page/album_detail_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/my_colors.dart';
import 'album_detail_controller.dart';

class AlbumDetailPage extends GetView<AlbumDetailController> {
  const AlbumDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5), // สีพื้นหลัง.
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5E5E5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.album.name, // แสดงชื่ออัลบั้ม
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงชื่ออัลบั้มอีกครั้ง (ถ้าต้องการ)
            // Text(
            //   controller.album.name,
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: MyColors.blue,
            //   ),
            // ),
            // const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true, // ทำให้ GridView อยู่ภายใน SingleChildScrollView ได้
              physics: const NeverScrollableScrollPhysics(), // ปิดการ scroll ของ GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 รูปต่อแถว
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // อัตราส่วน 1:1 สำหรับรูปภาพ
              ),
              itemCount: controller.album.imagePaths.length,
              itemBuilder: (context, index) {
                final imagePath = controller.album.imagePaths[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imagePath.startsWith('assets/')
                      ? Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, size: 40),
                            );
                          },
                        )
                      : Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, size: 40),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}