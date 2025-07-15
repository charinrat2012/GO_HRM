import 'package:get/get.dart';

import '../ui/pages/create_leave_request_page/create_leave_request_controller.dart';

class CreateLeaveRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateLeaveRequestController>(() => CreateLeaveRequestController());
  }
}