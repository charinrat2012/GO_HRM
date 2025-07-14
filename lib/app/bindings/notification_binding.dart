import 'package:get/get.dart';

import '../ui/pages/notification_page/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.put<NotificationController>(NotificationController());
  }
}
