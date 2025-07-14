import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  // ตัวแปรสำหรับเก็บ index ของแท็บที่ถูกเลือก (ใช้ .obs เพื่อให้ GetX ติดตามการเปลี่ยนแปลง)
  final RxInt tabIndex = 0.obs;

  // PageController สำหรับควบคุมการแสดงผลของ PageView
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    // เริ่มต้น PageController
    pageController = PageController(initialPage: tabIndex.value);
  }

  // ฟังก์ชันสำหรับเปลี่ยนแท็บ
  void changeTabIndex(int index) {
    // อัปเดตค่า index ของแท็บที่เลือก
    tabIndex.value = index;
    // สั่งให้ PageView เลื่อนไปยังหน้าที่ตรงกับ index
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    // คืนค่า Memory ให้ระบบเมื่อ Controller ถูกทำลาย
    pageController.dispose();
    super.onClose();
  }
}
