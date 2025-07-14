import 'package:get/get.dart';

import '../ui/pages/profile_page/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.put<ProfileController>(ProfileController());
  }
}
