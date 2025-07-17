import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../news_controller.dart';
import 'images_card.dart';

class SlideImage extends GetView<NewsController> {
  const SlideImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 219,
        child: PageView.builder(
          controller: controller.pageController,
          // ใช้ itemCount จาก imgcard เพื่อให้สไลด์แสดงรูปภาพทั้งหมด
          itemCount: controller.imgcard.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: controller.pageController,
              builder: (context, child) {
                double value = 1.0;
                if (controller.pageController.position.haveDimensions) {
                  value = controller.pageController.page! - index;
                  value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
                }
                return Center(
                  child: SizedBox(
                    height: Curves.easeOut.transform(value) * 200,
                    child: child,
                  ),
                );
              },
              child: ImagesCard(
                imgcard: controller.imgcard[index],
                onTap: () {
                  // --- จุดแก้ไข ---
                  // ตรวจสอบว่า index ของรูปภาพไม่เกินจำนวนข่าวที่มี
                  if (index < controller.newscard.length) {
                    // ดึงข้อมูลข่าวจาก newscard ณ ตำแหน่งเดียวกัน
                    final newsItem = controller.newscard[index];

                    // ส่งข้อมูลข่าว (NewsCardModel) ไปยังหน้า NEWS_DETAILS
                    Get.toNamed(
                      AppRoutes.NEWS_DETAILS,
                      arguments: newsItem, // ส่งข้อมูลที่ถูกต้อง
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}