// lib/app/ui/pages/menu_chat-page/menu_chat_controller.dart
import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/models/album_model.dart'; // ตรวจสอบว่า import ถูกต้อง

class MenuChatController extends GetxController {
  // [แก้ไข] เปลี่ยนเป็น Rx<Chat>
  late final Rx<Chat> chat;

  // [เพิ่ม] สร้าง getter สำหรับ albums เพื่อให้ MenuChatPage เข้าถึงได้ง่ายขึ้น
  RxList<Album> get albums => chat.value.albums;

  // [เพิ่ม] สร้าง getter สำหรับ imagePaths และ videoPaths
  List<String> get imagePaths => chat.value.imagePaths;
  List<String> get videoPaths => chat.value.videoPaths;

  // [แก้ไข] Getter สำหรับ fileMessages โดยตรง
  RxList<Message> get fileMessages => chat.value.fileMessages; // [เพิ่ม] สำหรับไฟล์เอกสาร

  // [เพิ่ม] Getter สำหรับ links
  RxList<String> get links => chat.value.links;


  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Chat) {
      // [แก้ไข] ห่อ Chat object ด้วย .obs เพื่อให้เป็น Reactive
      chat = (Get.arguments as Chat).obs;
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชท');
      Get.back();
    }
  }

  // หากมี method อื่นๆ ที่เข้าถึง chat.name, chat.isGroup, chat.messages
  // ต้องเปลี่ยนเป็น chat.value.name, chat.value.isGroup, chat.value.messages ด้วย
}