import 'package:get/get.dart';

import '../ui/pages/chats_page/chats_controller.dart';

class ChatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsController>(() => ChatsController());
    Get.put<ChatsController>(ChatsController());
  }
}
