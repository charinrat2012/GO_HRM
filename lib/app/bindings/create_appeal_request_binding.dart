import 'package:get/get.dart';

import '../ui/pages/create_ appeal_request_page/create_appeal_request_controller.dart';

class CreateAppealRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAppealRequestController>(
      () => CreateAppealRequestController(),
    );
    Get.put<CreateAppealRequestController>(CreateAppealRequestController());
  }
}
