import 'package:get/get.dart';

import '../ui/pages/settings_page/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.put<SettingsController>(SettingsController());
  }
}
