import 'package:get/get.dart';

import '../../../data/models/chat_model.dart'; // Make sure Chat model is imported

class AllAlbumsController extends GetxController {
  late final Chat chat; // This will hold the Chat object

  // Reactive getters that directly expose the RxLists from the Chat object
  RxList<String> get allMediaPaths => chat.imagePaths; // Expose imagePaths as allMediaPaths
  RxList<String> get allVideoPaths => chat.videoPaths; // Expose videoPaths explicitly if needed, or combine in UI
  RxList<String> get allLinkPaths => chat.links;
  RxList<Message> get allFileMessages => chat.fileMessages;

  final RxInt selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Receive the Chat object directly as an argument
    if (Get.arguments != null && Get.arguments is Map<String, dynamic> && Get.arguments.containsKey('chat')) {
      chat = Get.arguments['chat'] as Chat;
      if (Get.arguments.containsKey('initialTab') && Get.arguments['initialTab'] is int) {
        selectedTabIndex.value = Get.arguments['initialTab'];
      }
    } else {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลแชทสำหรับดูสื่อทั้งหมด');
      Get.back();
      return;
    }
  }

  // Method for changing tab (already exists)
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}