
import 'package:get/get.dart';
import '../ui/pages/chat_detail_page/chat_detail_controller.dart';

class ChatDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailController>(() => ChatDetailController());
  }
}
