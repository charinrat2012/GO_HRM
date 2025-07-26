// Path: lib/app/ui/pages/album_detail_page/album_detail_controller.dart
import 'package:get/get.dart';
import '../../../data/models/album_model.dart'; // ตรวจสอบว่า import ถูกต้อง

class AlbumDetailController extends GetxController {
  late final Album album; // ตัวแปรสำหรับเก็บข้อมูลอัลบั้ม

  @override
  void onInit() {
    super.onInit();
    // รับอาร์กิวเมนต์ที่ส่งมา (ซึ่งควรเป็นออบเจกต์ Album)
    if (Get.arguments is Album) {
      album = Get.arguments as Album;
    } else {
      // จัดการกรณีที่ไม่มีอาร์กิวเมนต์หรืออาร์กิวเมนต์ไม่ถูกต้อง
      Get.back(); // ย้อนกลับไปหน้าเดิม
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่พบข้อมูลอัลบั้ม',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}