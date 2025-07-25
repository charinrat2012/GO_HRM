import 'package:get/get.dart';
import '../ui/pages/all_media_page/all_media_controller.dart';

class AllMediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllMediaController>(() => AllMediaController());
  }
}