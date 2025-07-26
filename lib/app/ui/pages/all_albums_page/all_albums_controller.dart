import 'package:get/get.dart';

import '../../../data/models/chat_model.dart';

class AllAlbumsController extends GetxController {
  // ชื่อคลาสยังคงเดิมตามที่ผู้ใช้ระบุ
  // สำหรับแท็บ "รูป & วิดีโอ"
  final RxList<String> allMediaPaths = <String>[].obs;

  // สำหรับแท็บ "ลิงก์" (ปัจจุบันยังไม่มีการดึงข้อมูล)
  final RxList<String> allLinkPaths = <String>[].obs; // [เพิ่ม] สำหรับ Links

  // สำหรับแท็บ "ไฟล์"
  final RxList<Message> allFileMessages =
      <Message>[].obs; // [เพิ่ม] สำหรับไฟล์เอกสาร

  // สำหรับควบคุม TabBar
  final RxInt selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;

      // รูปภาพและวิดีโอ
      final List<String> images =
          (args['imagePaths'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      final List<String> videos =
          (args['videoPaths'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];

      allMediaPaths.assignAll([...images, ...videos]);

      // ลิงก์
      final List<String> links =
          (args['links'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      allLinkPaths.assignAll(links); // [เพิ่ม] กำหนดค่า

      // ไฟล์
      final List<Message> files =
          (args['fileMessages'] as List<dynamic>?)
              ?.map((e) => e as Message)
              .toList() ??
          [];
      allFileMessages.assignAll(files);

      // ตั้งค่าแท็บเริ่มต้น
      if (args.containsKey('initialTab') && args['initialTab'] is int) {
        selectedTabIndex.value = args['initialTab'];
      }
    }
  }

  // เมธอดสำหรับเปลี่ยนแท็บ
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
