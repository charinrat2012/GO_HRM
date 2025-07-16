// lib/app/ui/pages/notification_page/notification_controller.dart
import 'package:get/get.dart';

import '../../../data/models/notification_model.dart';

class NotificationController extends GetxController {
  //ถ้ามีข้อมูลการแจ้งเตือนเพิ่ม, ลบ, หรือเปลี่ยนเมื่อไหร่ ก็จะ อัปเดตตามทันทีโดยอัตโนมัติ
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  // ตัวแปรใหม่สำหรับติดตาม index ของการ์ดแจ้งเตือนที่กำลังขยายอยู่ (เริ่มต้นที่ -1 คือไม่มีการ์ดใดขยาย)
  final RxInt _currentlyExpandedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.assignAll([
      NotificationModel(
        type: "ออกใบลา",
        title: "ณัฐดนย์ ธวัชผ่องศรี ยื่นขอ “ลากิจล่วงหน้า”",
        date: "วันที่ 25/06/2025 เวลา 12.08 น.",
        isExpanded: false, // ทุกการ์ดปิดอยู่เริ่มต้น
      ),

      NotificationModel(
        type: "ออกเอกสาร",
        title: "ณัฐดนย์ ธวัชผ่องศรี ยื่นขอ “โอทีล่วงหน้า”",
        date: "วันที่ 25/06/2025 เวลา 12.08 น.",
        isExpanded: false,
      ),
      NotificationModel(
        type: "ร้องเรียน",
        title: "ณัฐดนย์ ธวัชผ่องศรี ส่งคำร้อง ให้ซ่อมแอร์",
        date: " 25/06/2025 เวลา 12.08 น.",
        isExpanded: false,
      ),
      NotificationModel(
        type: "ร้องเรียน",
        title: "ณัฐดนย์ ธวัชผ่องศรี ส่งคำร้อง ขอความเงียบสงบ",
        date: " 25/06/2025 เวลา 12.08 น.",
        isExpanded: false,
      ),
      NotificationModel(
        type: "ออกใบลา",
        title: "ณัฐดนย์ ธวัชผ่องศรี ยื่นขอ “ลาป่วย”",
        date: " วันที่ 25/06/2025 เวลา 12.08 น.",
        isExpanded: false,
      ),
      NotificationModel(
        type: "ออกเอกสาร",
        title: "ณัฐดนย์ ธวัชผ่องศรี ยื่นขอ  “โอทีล่วงหน้า”",
        date: " วันที่ 25/06/2025 เวลา 12.08 น.",
        isExpanded: false,
      ),
      NotificationModel(
        type: "ออกเอกสาร",
        title: "ณัฐดนย์ ธวัชผ่องศรี ยื่นขอ “โอทีล่วงหน้า”",
        date: " วันที่ 25/06/2025 เวลา 12.08 น.",
        isExpanded: false,
      ),
    ]);

   
  }
   // ตั้งค่าให้ไม่มีการ์ดใดขยายเริ่มต้น (เริ่มต้นที่ -1 คือไม่มีการ์ดใดขยาย)

  // เมธอดสำหรับสลับสถานะการขยาย/ยุบของการแจ้งเตือน (เพื่อให้ขยายได้ทีละหนึ่ง)
  void toggleNotificationExpansion(int tappedIndex) {
    final int previousExpandedIndex =
        _currentlyExpandedIndex.value; // เก็บ index ของการ์ดที่เคยขยายอยู่

    // ถ้ามีการ์ดอื่นที่เคยขยายอยู่ และมันไม่ใช่การ์ดที่เพิ่งถูกกดซ้ำ ให้ยุบการ์ดนั้นลง
    if (previousExpandedIndex != -1 &&
        previousExpandedIndex != tappedIndex &&
        previousExpandedIndex < notifications.length) {
      notifications[previousExpandedIndex].isExpanded.value =
          false; // อัปเดตสถานะในโมเดล
    }

    //จัดการกับการ์ดที่เพิ่งถูกกด:
    if (tappedIndex == previousExpandedIndex) {
      // ถ้ากดการ์ดที่กำลังขยายอยู่ (คือ tappedIndex เป็นการ์ดเดียวกับ previousExpandedIndex) ให้ยุบมันลง
      notifications[tappedIndex].isExpanded.value = false; // อัปเดตสถานะในโมเดล
      _currentlyExpandedIndex.value = -1; // ตอนนี้ไม่มีใครขยาย
    } else {
      // ถ้ากดการ์ดใหม่ (หรือการ์ดที่ยุบอยู่แต่ไม่ใช่การ์ดเดียวกับ previousExpandedIndex) ให้ขยายมัน
      notifications[tappedIndex].isExpanded.value = true; // อัปเดตสถานะในโมเดล
      _currentlyExpandedIndex.value =
          tappedIndex; // บันทึก index ของการ์ดที่ขยายอยู่
    }
  }

  // Getter เพื่อให้ UI เช็คว่าการ์ดไหนกำลังขยายอยู่ (ปัจจุบัน UI ใช้ notifications[index].isExpanded.value)
  bool isNotificationExpanded(int index) {
    return _currentlyExpandedIndex.value == index;
  }
}
