import 'package:get/get.dart';

import '../ui/pages/timetable_page/timetable_controllers.dart';

class TimetableBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimetableController>(() => TimetableController());
    Get.put<TimetableController>(TimetableController());
  }
}
