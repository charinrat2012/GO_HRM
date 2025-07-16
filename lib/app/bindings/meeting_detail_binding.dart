import 'package:get/get.dart';

import '../ui/pages/meeting_detail_page/meeting_detail_controller.dart';

class MeetingDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingDetailController>(
      () => MeetingDetailController(),
    );
    Get.put<MeetingDetailController>(MeetingDetailController());
  }
}
