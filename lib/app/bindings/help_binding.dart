import 'package:get/get.dart';

import '../ui/pages/help_page/help_controller.dart';

class HelpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpController>(() => HelpController());
    Get.put<HelpController>(HelpController());
  }
}
