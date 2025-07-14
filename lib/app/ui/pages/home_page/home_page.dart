import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        //   onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        //   child: Scaffold(
        //     body: SingleChildScrollView(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(16.0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 const Text(
        //                   'ข่าวสาร',
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //                 const Divider(color: Color.fromRGBO(194, 198, 204, 0.65)),
        //                 const SizedBox(height: 8), // เพิ่มระยะห่างหลัง Divider
        //               ],
        //             ),
        //           ),
        //           Obx(
        //             () => SizedBox(
        //               height: 219,
        //               child: PageView.builder(
        //                 controller:
        //                 controller.pageController, // ใช้ controller จาก GetX
        //                 itemCount: controller.imgcard.length,
        //                 itemBuilder: (context, index) {
        //                   return AnimatedBuilder(
        //                     animation: controller.pageController,
        //                     builder: (context, child) {
        //                       double value = 1.0;
        //                       if (controller
        //                           .pageController
        //                           .position
        //                           .haveDimensions) {
        //                         value = controller.pageController.page! - index;
        //                         value = (1 - (value.abs() * 0.15)).clamp(
        //                           0.85,
        //                           1.0,
        //                         );
        //                       }
        //                       return Center(
        //                         child: SizedBox(
        //                           height: Curves.easeOut.transform(value) * 200,
        //                           child: child,
        //                         ),
        //                       );
        //                     },
        //                     child: ImagesCard(imgcard: controller.imgcard[index]),
        //                   );
        //                 },
        //               ),
        //             ),
        //           ),
        //           const SizedBox(height: 24),

        //           // --- ส่วนของ Indicator (จุดแสดงตำแหน่ง) ---
        //           // ห่อด้วย Obx เพื่อให้มัน re-build อัตโนมัติเมื่อค่า currentPageIndex เปลี่ยน
        //           Obx(
        //             () => Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: List.generate(
        //                 controller.imgcard.length,
        //                 (index) => buildIndicator(
        //                   index == controller.currentPageIndex.value,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: 16),
        //           Padding(
        //             padding: const EdgeInsets.all(16.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'กิจกรรม',
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 21,
        //                   ),
        //                 ),
        //                 Spacer(),
        //                 PopupMenuButton<String>(
        //                   icon: const Icon(Icons.more_horiz),
        //                   onSelected: (String result) {
        //                     // โค้ดที่ทำงานเมื่อเลือกเมนู
        //                   },
        //                   itemBuilder: (BuildContext context) =>
        //                       <PopupMenuEntry<String>>[
        //                         const PopupMenuItem<String>(
        //                           value: 'profile',
        //                           child: Text('โปรไฟล์'),
        //                         ),
        //                         const PopupMenuItem<String>(
        //                           value: 'settings',
        //                           child: Text('ตั้งค่า'),
        //                         ),
        //                         const PopupMenuItem<String>(
        //                           value: 'logout',
        //                           child: Text('ออกจากระบบ'),
        //                         ),
        //                       ],
        //                 ),

        //                 // IconButton(
        //                 //   onPressed: () {},
        //                 //   icon: const Icon(Icons.more_horiz),
        //                 // ),
        //               ],
        //             ),
        //           ),
        //           Obx(
        //             () => controller.newscard.isEmpty
        //                 ? const Center(child: Text('No news'))
        //                 : ListView.separated(
        //                     shrinkWrap: true, // ทำให้ ListView สูงตามจำนวน item
        //                     physics:
        //                         const NeverScrollableScrollPhysics(), // ปิดการ scroll ของ ListView
        //                     itemCount: controller.newscard.length,
        //                     itemBuilder: (context, index) {
        //                       final news = controller.newscard[index];
        //                       return NewsCard(news: news);
        //                     },
        //                     separatorBuilder: (context, index) {
        //                       // เพิ่มเส้นคั่นระหว่างแต่ละรายการ ยกเว้นรายการสุดท้าย
        //                       return const Padding(
        //                         padding: EdgeInsets.symmetric(horizontal: 16.0),
        //                         child: Divider(
        //                           height: 1,
        //                           color: Color.fromRGBO(194, 198, 204, 0.65),
        //                         ),
        //                       );
        //                     },
        //                   ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
      ),
    );
  }
}
