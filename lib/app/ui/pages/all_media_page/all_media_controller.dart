import 'package:get/get.dart';

class AllMediaController extends GetxController {
  final RxList<String> allMediaPaths = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // รับ arguments ที่ส่งมาจากหน้าก่อนหน้า
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
      final List<String> images = (args['imagePaths'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
      final List<String> videos = (args['videoPaths'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

      allMediaPaths.assignAll([...images, ...videos]);
    }
  }
}