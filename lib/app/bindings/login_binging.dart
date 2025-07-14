import 'package:get/get.dart';

import '../ui/pages/login_page/login_controller.dart';

class LoginBinging implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put<LoginController>(LoginController());
  }
}
