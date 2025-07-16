import 'package:get/get.dart';

import '../ui/pages/activity_detail_page/activity_detail_controller.dart';

class ActivitydetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityDetailController>(
      () => ActivityDetailController(),
    );
    Get.put<ActivityDetailController>(ActivityDetailController());
  }
}
