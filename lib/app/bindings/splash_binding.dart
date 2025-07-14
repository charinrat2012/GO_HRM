import 'package:get/get.dart';

import '../ui/pages/splash_page/splash_controllers.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.put<SplashController>(SplashController());
  }
}
