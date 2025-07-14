import 'package:get/get.dart';

import '../../../data/models/notification_model.dart';

class NotificationController extends GetxController {
  //ถ้ามีข้อมูลการแจ้งเตือนเพิ่ม, ลบ, หรือเปลี่ยนเมื่อไหร่ หน้าจอแอปที่แสดงการแจ้งเตือนก็จะ อัปเดตตามทันทีโดยอัตโนมัติ
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

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
        isExpanded: false,
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

  // เมธอดสำหรับสลับสถานะการขยาย/ยุบของการแจ้งเตือน
  void toggleNotificationExpansion(int index) {
    notifications[index].isExpanded.toggle();
  }

  void rejectNotification(int index) {
    // TODO: เพิ่ม Logic สำหรับการปฏิเสธการแจ้งเตือน (เช่น ลบรายการออกจาก list หรือเปลี่ยนสถานะ)
    // ลบ Get.snackbar ออกตามที่คุณต้องการ
    // notifications.removeAt(index); // ตัวอย่าง: หากต้องการลบรายการที่ถูกปฏิเสธออก
  }

  void approveNotification(int index) {
    // TODO: เพิ่ม Logic สำหรับการอนุมัติการแจ้งเตือน (เช่น ลบรายการออกจาก list หรือเปลี่ยนสถานะ)
    // ลบ Get.snackbar ออกตามที่คุณต้องการ
    // notifications.removeAt(index); // ตัวอย่าง: หากต้องการลบรายการที่ถูกอนุมัติออก
  }
}
