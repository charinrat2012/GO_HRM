import 'package:get/get.dart';

import '../ui/pages/salary_detail_page/salary_dedail_controller.dart';

class SalaryDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalaryDetailController>(() => SalaryDetailController());
    Get.put<SalaryDetailController>(SalaryDetailController());
  }
}
