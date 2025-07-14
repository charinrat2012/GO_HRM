import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/data/models/images_card_model.dart';

import '../../../data/models/news_card_model.dart';
import '../news_page/widgets/datalist.dart';

class HomeController extends GetxController {
  // final pageController = PageController( viewportFraction: 0.85);

  // final currentPageIndex = 1.obs;

  // final RxList<ImageCardModel> imgcard = <ImageCardModel>[].obs;
  // final RxList<NewsCardModel> newscard = <NewsCardModel>[].obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   // เพิ่ม Listener เพื่อติดตามการเปลี่ยนแปลงหน้า
  //   pageController.addListener(() {
  //     int nextPageIndex = pageController.page!.round();
  //     if (currentPageIndex.value != nextPageIndex) {
  //       // อัปเดตค่าของตัวแปร .obs โดยใช้ .value
  //       currentPageIndex.value = nextPageIndex;
  //     }
  //   });
  //   loadPosts();
  // }
  // void loadPosts() {

  //   final List<ImageCardModel> picData = DataList.picData.map((map) {
  //     return ImageCardModel.fromMap(map);
  //   }).toList();

  //   imgcard.assignAll(picData);

  //     final List<NewsCardModel> newsData = DataList.newsData.map((map) {
  //     return NewsCardModel.fromMap(map);
  //   }).toList();

  //   newscard.assignAll(newsData);
  //    Future.delayed(const Duration(milliseconds: 50), () {
  //     if (pageController.hasClients) {
  //       pageController.jumpToPage(1); // สั่งให้ไปหน้าที่ 2 (index 1)
  //     }
  //   });

  // }

  // @override
  // void onClose() {
  //   // ใช้ onClose สำหรับ dispose ใน GetxController
  //   pageController.dispose();
  //   super.onClose();
  // }
}
