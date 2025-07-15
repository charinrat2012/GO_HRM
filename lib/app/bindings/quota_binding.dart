import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/quota_page/quota_controller.dart';



class QuotaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuotaController>(() => (QuotaController()));
  }
}
