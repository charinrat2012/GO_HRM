import 'package:get/get.dart';

import '../../../data/models/news_card_model.dart';
import '../../global_widgets/datalist.dart';

class NewsDetailsController extends GetxController {

  final RxList<NewsCardModel> newscard = <NewsCardModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadPosts();
  }

  void loadPosts() {
   

    final List<NewsCardModel> newsData = DataList.newsData.map((map) {
      return NewsCardModel.fromMap(map);
    }).toList();

    newscard.assignAll(newsData);
  }
}
