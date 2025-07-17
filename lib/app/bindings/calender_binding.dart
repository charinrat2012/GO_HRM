import 'package:get/get.dart';

import '../ui/pages/calender_page/calender_controller.dart';



class CalenderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderController>(() => CalenderController());
    Get.put<CalenderController>(CalenderController());
  }
}
