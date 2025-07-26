// lib/app/ui/pages/albums_overview_page/albums_overview_controller.dart
import 'package:get/get.dart';
import '../../../data/models/album_model.dart'; // ตรวจสอบเส้นทาง AlbumModel ให้ถูกต้อง
import '../../../data/models/chat_model.dart'; // [เพิ่ม] Import Chat model

class AlbumsOverviewController extends GetxController {
  late final Chat chat; // [แก้ไข] เปลี่ยนเป็น Chat object

  // allAlbums จะเป็นเพียง reference ไปยัง chat.albums
  // ไม่จำเป็นต้องประกาศเป็น RxList แยกต่างหากแล้ว เพราะจะทำงานโดยตรงกับ chat.albums
  // และ chat.albums เองก็เป็น RxList อยู่แล้ว
  RxList<Album> get allAlbums => chat.albums; // [เพิ่ม] Getter สำหรับ allAlbums

  @override
  void onInit() {
    super.onInit();
    // รับ arguments ที่ส่งมาจาก MenuChatPage ซึ่งควรจะเป็น Chat object
    if (Get.arguments != null && Get.arguments is Chat) {
      chat = Get.arguments as Chat;
      // ไม่ต้องใช้ allAlbums.assignAll(Get.arguments as List<Album>);
      // เพราะ allAlbums เป็น getter ที่ชี้ไปที่ chat.albums แล้ว
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชทสำหรับอัลบั้ม');
      Get.back();
    }
  }

  // เมธอดสำหรับเพิ่มอัลบั้มใหม่ (เรียกใช้จาก CreateAlbumController)
  void addAlbum(Album newAlbum) {
    chat.albums.add(newAlbum); // [แก้ไข] เพิ่มอัลบั้มลงใน chat.albums โดยตรง
    // คุณอาจต้องการบันทึก allAlbums ลงใน Persistent Storage ที่นี่ด้วย
    Get.snackbar('สำเร็จ', 'เพิ่มอัลบั้ม "${newAlbum.name}" แล้ว');
  }
}