
import 'package:get/get.dart';

import '../ui/pages/favourite_page/favourite_controller.dart';


class FavouriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteController>(() => FavouriteController());
  }
}