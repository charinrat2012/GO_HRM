import 'package:get/get.dart';

import '../ui/pages/edit_profile_page/edit_profile_controller.dart';

class EditprofileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditprofileController>(() => EditprofileController());
    Get.put<EditprofileController>(EditprofileController());
  }
}
