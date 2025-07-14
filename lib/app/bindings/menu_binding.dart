import 'package:get/get.dart';

import '../ui/pages/menu_page/menu_controller.dart';

class MenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
    Get.put<MenuController>(MenuController());
  }
}
