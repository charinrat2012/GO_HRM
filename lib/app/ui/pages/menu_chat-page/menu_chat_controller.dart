// Path: lib/app/ui/pages/menu_chat-page/menu_chat_controller.dart
import 'package:get/get.dart';
import '../../../data/models/chat_model.dart'; // Import Chat model

class MenuChatController extends GetxController {
  late final Chat chat; // ตัวแปรสำหรับเก็บอ็อบเจกต์ chat ที่ส่งมาจาก ChatDetailPage

  // ลิสต์ที่เป็น Reactive สำหรับเก็บเส้นทางของรูปภาพและวิดีโอ
  final RxList<String> imagePaths = <String>[].obs;
  final RxList<String> videoPaths = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // ดึงอ็อบเจกต์ chat จาก arguments ที่ส่งมา
    if (Get.arguments is Chat) {
      chat = Get.arguments as Chat;
      _extractMediaPaths(); // เรียกเมธอดเพื่อแยกสื่อ
    } else {
      // จัดการข้อผิดพลาดหากไม่พบอ็อบเจกต์ chat
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชท');
      // คุณอาจต้องการนำทางกลับหรือแสดงหน้าข้อผิดพลาด
    }
  }

  // เมธอดสำหรับแยกเส้นทางของรูปภาพและวิดีโอออกจากข้อความในแชท
  void _extractMediaPaths() {
    // เคลียร์ข้อมูลเก่า
    imagePaths.clear();
    videoPaths.clear();

    for (var message in chat.messages) {
      if (message.imagePath != null && message.imagePath!.isNotEmpty) {
        imagePaths.add(message.imagePath!);
      } else if (message.filePath != null && message.filePath!.isNotEmpty) {
        final lowerCasePath = message.filePath!.toLowerCase();
        // ตรวจสอบนามสกุลไฟล์ว่าเป็นวิดีโอหรือไม่
        if (lowerCasePath.endsWith('.mp4') || lowerCasePath.endsWith('.mov') || lowerCasePath.endsWith('.webm')) {
          videoPaths.add(lowerCasePath); // เพิ่มเส้นทางวิดีโอ
        }
      }
    }
    // เรียงลำดับเพื่อให้สื่อที่ส่งล่าสุดอยู่ด้านบนสุด (หากต้องการ)
    imagePaths.sort((a, b) => b.compareTo(a));
    videoPaths.sort((a, b) => b.compareTo(a));
  }
}