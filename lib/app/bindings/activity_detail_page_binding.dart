import 'package:get/get.dart';

import '../ui/pages/activity_detail_page/activity_detail_page_controller.dart';

class ActivitydetailpageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityDetailPageController>(
      () => ActivityDetailPageController(),
    );
    Get.put<ActivityDetailPageController>(ActivityDetailPageController());
  }
}
