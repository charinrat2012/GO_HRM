import 'package:get/get.dart';

import '../ui/pages/news_details_page/news_details_controller.dart';
import '../ui/pages/news_page/news_controller.dart';

class NewsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailsController>(() => NewsDetailsController());
    Get.put<NewsDetailsController>(NewsDetailsController());
    Get.lazyPut<NewsController>(() => NewsController());
  }
}
