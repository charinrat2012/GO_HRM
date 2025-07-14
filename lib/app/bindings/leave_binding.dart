import 'package:get/get.dart';

import '../ui/pages/leave_page.dart/leave_controller.dart';

class LeavePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeavePageController>(() => LeavePageController());
  }
}
