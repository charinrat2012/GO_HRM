
import 'package:get/get.dart';

import '../../ui/pages/main_page/main_controller.dart';
import '../../ui/pages/navigation_page/navigation_controller.dart';

class DependecyInjection {
  static void init() {
    Get.put<NavigationController>(NavigationController());
    Get.put<MainController>(MainController());
  }
}