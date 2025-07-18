import 'package:get/get.dart';

import '../ui/pages/privacy_policy_page/privacy_policy_controller.dart';

class PrivacyPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
    Get.put<PrivacyPolicyController>(PrivacyPolicyController());
  }
}
