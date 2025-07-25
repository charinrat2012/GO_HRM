import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'all_albums_controller.dart';

class AllAlbumsPage extends GetView<AllAlbumsController> {
  const AllAlbumsPage({Key? key}) : super(key: key);

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
          if (controller.albumImagePaths.isEmpty) {
            return const Center(
              child: Text(
                'ไม่มีรูปภาพในอัลบั้มนี้',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // แสดง 3 คอลัมน์
              crossAxisSpacing: 4.0, // ระยะห่างแนวนอน
              mainAxisSpacing: 4.0, // ระยะห่างแนวตั้ง
            ),
            itemCount: controller.albumImagePaths.length,
            itemBuilder: (context, index) {
              final path = controller.albumImagePaths[index];
              return _ImageGridItem(
                path: path,
              ); // ใช้ Widget ย่อยสำหรับแสดงรูปภาพ
            },
          );
        }),
      ),
    );
  }
}

class _ImageGridItem extends StatelessWidget {
  final String path; //เส้นทางของรู)ภาพ
  const _ImageGridItem({Key? key, required this.path})
    : super(key: key); //เส้นทางของรูปภาพ และนำรูปภาพนั้นๆไปแสดง

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบว่าเป็น asset หรือ file path
    final bool isAsset = path.startsWith('assets/');

    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: isAsset
            ? Image.asset(
                path,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              )
            : Image.file(
                File(path),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
