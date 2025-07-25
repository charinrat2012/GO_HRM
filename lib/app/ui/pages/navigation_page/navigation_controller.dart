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
  void resetToHome() {
    
    // 1. เปลี่ยนค่า tabIndex ที่เป็น Observable กลับไปเป็น 0 (หน้า Home)
    tabIndex.value = 0;
    // 2. ตรวจสอบว่า PageController พร้อมใช้งานหรือไม่
    if (pageController.hasClients) {
      // 3. สั่งให้ PageView เลื่อนกลับไปที่หน้าแรก
      pageController.jumpToPage(0);
    }
  }

  @override
  void onClose() {
    // คืนค่า Memory ให้ระบบเมื่อ Controller ถูกทำลาย
    pageController.dispose();
    super.onClose();
  }
}
