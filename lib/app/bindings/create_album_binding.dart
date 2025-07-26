import 'package:get/get.dart';
import '../ui/pages/create_album_page/create_album_controller.dart';

class CreateAlbumBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAlbumController>(() => CreateAlbumController());
  }
}