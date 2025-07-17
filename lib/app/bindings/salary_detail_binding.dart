import 'package:get/get.dart';

import '../ui/pages/salary_detail_page/salary_dedail_controller.dart';

class SalaryDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalaryDedailController>(() => SalaryDedailController());
    Get.put<SalaryDedailController>(SalaryDedailController());
  }
}
