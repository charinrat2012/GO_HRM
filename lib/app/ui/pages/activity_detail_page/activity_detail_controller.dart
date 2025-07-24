import 'package:get/get.dart';

import '../../../data/models/calender_model.dart';

class ActivityDetailController extends GetxController {
  late final CalenderEventModel event;
  
  @override
  void onInit() {
    super.onInit();

    event = Get.arguments as CalenderEventModel;
  }
}
