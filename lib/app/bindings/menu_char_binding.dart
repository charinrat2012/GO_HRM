import 'package:get/get.dart';

import '../ui/pages/menu_chat-page/menu_chat_controller.dart';

class MenuCharBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuChatController>(() => MenuChatController());
  }
}
