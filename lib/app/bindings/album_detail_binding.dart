// Path: lib/app/bindings/album_detail_binding.dart
import 'package:get/get.dart';

import '../ui/pages/album_detail_page/album_detail_controller.dart';

class AlbumDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumDetailController>(
      () => AlbumDetailController(),
    );
  }
}