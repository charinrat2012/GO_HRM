import 'package:get/get.dart';

class AllAlbumsController extends GetxController {
  final RxList<String> albumImagePaths = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // รับ arguments ที่ส่งมาจากหน้าก่อนหน้า (ในที่นี้คือ imagePaths ของอัลบั้ม)
    if (Get.arguments != null && Get.arguments is List<String>) {
      albumImagePaths.assignAll(Get.arguments as List<String>);
    }
  }
}