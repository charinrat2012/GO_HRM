// Path: lib/app/bindings/albums_overview_binding.dart
import 'package:get/get.dart';
import '../ui/pages/albums_overview_page/albums_overview_controller.dart';

class AlbumsOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumsOverviewController>(() => AlbumsOverviewController());
  }
}