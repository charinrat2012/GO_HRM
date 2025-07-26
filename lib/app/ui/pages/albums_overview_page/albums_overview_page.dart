// lib/app/ui/pages/albums_overview_page/albums_overview_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'albums_overview_controller.dart';
import '../../../config/my_colors.dart'; 

class AlbumsOverviewPage extends GetView<AlbumsOverviewController> {
  const AlbumsOverviewPage({Key? key}) : super(key: key);

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
            'อัลบั้มทั้งหมด',
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
        body: Obx(() {
          if (controller.chat.albums.isEmpty) { 
            return const Center(
              child: Text(
                'ไม่มีอัลบั้มที่สร้างไว้',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 8.0, 
              mainAxisSpacing: 8.0, 
              childAspectRatio: 1.0, 
            ),
            itemCount: controller.chat.albums.length, 
            itemBuilder: (context, index) {
              final album = controller.chat.albums[index]; 
              final String thumbnailPath = album.imagePaths.isNotEmpty
                  ? album.imagePaths.first
                  : ''; 
              return GestureDetector(
                onTap: () {
                  // [แก้ไข] เมื่อแตะที่อัลบั้ม ให้ไปหน้า AllAlbumsPage พร้อมส่ง Chat object และตั้งค่า initialTab
                  Get.toNamed(
                    AppRoutes.ALBUM_DETAIL,
                    arguments: album, // ส่ง Album object ที่เลือกไป
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8.0),
                          ),
                          child: _buildThumbnailWidget(thumbnailPath),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          album.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          '${album.imagePaths.length} รูปภาพ',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton( 
          onPressed: () {
            Get.toNamed(AppRoutes.CREATE_ALBUM, arguments: controller.chat);
          },
          child: const Icon(Icons.add),
          backgroundColor: MyColors.blue2, 
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildThumbnailWidget(String path) {
    if (path.isEmpty) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.photo_library, color: Colors.grey, size: 40),
        ),
      );
    }
    final bool isAsset = path.startsWith('assets/');
    if (isAsset) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
        },
      );
    } else {
      final File file = File(path);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
          },
        );
      } else {
        return Container(
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      }
    }
  }
}