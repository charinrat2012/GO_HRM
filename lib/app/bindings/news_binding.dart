import 'package:get/get.dart';

import '../ui/pages/news_page/news_controller.dart';


class NewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
    Get.put<NewsController>(NewsController());
  }
}
