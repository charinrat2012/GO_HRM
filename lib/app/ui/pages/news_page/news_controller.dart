import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/news_card_model.dart';
import '../../global_widgets/datalist.dart';

class NewsController extends GetxController {
  final pageController = PageController(initialPage: 1, viewportFraction: 0.85);

  final currentPageIndex = 1.obs;

  final RxList<NewsCardModel> imgcard = <NewsCardModel>[].obs;
  final RxList<NewsCardModel> newscard = <NewsCardModel>[].obs;

  Timer? _timer; // เพิ่ม Timer

  @override
  void onReady() {
    super.onReady();
    // เพิ่ม Listener เพื่อติดตามการเปลี่ยนแปลงหน้า
    pageController.addListener(() {
      int nextPageIndex = pageController.page!.round();
      if (currentPageIndex.value != nextPageIndex) {
        // อัปเดตค่าของตัวแปร .obs โดยใช้ .value
        currentPageIndex.value = nextPageIndex;
      }
    });
    loadPosts();
    _startAutoScroll(); // เริ่มการเลื่อนอัตโนมัติ
  }

  void _startAutoScroll() {
    // สร้าง Timer ให้ทำงานทุก 5 วินาที
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (imgcard.isNotEmpty && pageController.hasClients) {
        int nextPage = currentPageIndex.value + 1;
        if (nextPage >= imgcard.length) {
          nextPage = 0; // วนกลับไปหน้าแรก
        }
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void loadPosts() {
    final List<NewsCardModel> picData = DataList.newsData.map((map) {
      return NewsCardModel.fromMap(map);
    }).toList();

    imgcard.assignAll(picData);

    final List<NewsCardModel> newsData = DataList.newsData.map((map) {
      return NewsCardModel.fromMap(map);
    }).toList();

    newscard.assignAll(newsData);

    final newsIm = picData.take(5).toList();
    imgcard.assignAll(newsIm);

    currentPageIndex.value = pageController.page?.round() ?? 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        // สั่งให้กระโดดไปหน้าที่ 2 (index 1)
        pageController.jumpToPage(1);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // ยกเลิก Timer เมื่อ Controller ถูกทำลาย
    pageController.dispose();
    super.onClose();
  }


  final isSwitchedOn = false.obs;
  void toggleSwitch(bool value) {
    isSwitchedOn.value = value;
    // isSwitchedOn.value = !isSwitchedOn.value;
    // คุณสามารถใส่ Logic เพิ่มเติมตรงนี้ได้
    // เช่น ถ้าสวิตช์เปิด ให้ทำอะไรบางอย่าง
    if (value) {
      print("สวิตช์เปิดแล้ว");
    } else {
      print("สวิตช์ปิดแล้ว");
    }
  }
}
