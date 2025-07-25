import 'package:get/get.dart';
import '../ui/pages/all_albums_page/all_albums_controller.dart';

class AllAlbumsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllAlbumsController>(() => AllAlbumsController());
  }
}