import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/my_colors.dart';
import '../calender_page/calender_page.dart';
import '../chats_page/chats_page.dart';
import '../home_page/home_page.dart';
import '../menu_page/menu_page.dart';
import '../news_page/news_page.dart';
import 'navigation_controller.dart';

class NavigationPage extends GetView<NavigationController> {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วน Body ใช้ PageView เพื่อแสดงหน้าต่างๆ
      body: PageView(
        // เชื่อม PageController จาก NavigationController
        controller: controller.pageController,
        // ปิดการเลื่อนหน้าด้วยการปัดนิ้ว (swipe)
        physics: const NeverScrollableScrollPhysics(),
        // รายการหน้าที่จะแสดงใน PageView
        children: const [
          HomePage(),
          NewsPage(),
          ChatsPage(),
          CalenderPage(),
          MenuPage(),

          // LoginPage(),
        ],
      ),
      // ส่วน BottomNavigationBar
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          // currentIndex บอกว่าแท็บไหนกำลังถูกเลือก
          currentIndex: controller.tabIndex.value,
          // onTap คือ event ที่จะทำงานเมื่อกดที่แท็บ
          onTap: controller.changeTabIndex,
          // ตั้งค่าสไตล์ของแท็บ
          selectedItemColor: MyColors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          // รายการของปุ่มใน Bottom Bar
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              activeIcon: Icon(Icons.chrome_reader_mode),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              activeIcon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_outlined),
              activeIcon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
