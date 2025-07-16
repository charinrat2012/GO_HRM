import 'package:get/get.dart';

import '../ui/pages/salary_page/salary_controller.dart';

class SalaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalaryController>(() => SalaryController());
    Get.put<SalaryController>(SalaryController());
  }
}
