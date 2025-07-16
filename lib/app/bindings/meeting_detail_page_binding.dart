import 'package:get/get.dart';

import '../ui/pages/meeting_detail_page/meeting_detail_page_controller.dart';

class MeetingDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingDetailPageController>(
      () => MeetingDetailPageController(),
    );
    Get.put<MeetingDetailPageController>(MeetingDetailPageController());
  }
}
