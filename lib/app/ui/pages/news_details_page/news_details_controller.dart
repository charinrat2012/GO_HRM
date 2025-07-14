import 'package:get/get.dart';

import '../../../data/models/images_card_model.dart';
import '../../../data/models/news_card_model.dart';
import '../news_page/widgets/datalist.dart';

class NewsDetailsController extends GetxController {
  final RxList<ImageCardModel> imgcard = <ImageCardModel>[].obs;
  final RxList<NewsCardModel> newscard = <NewsCardModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadPosts();
  }

  void loadPosts() {
    final List<ImageCardModel> picData = DataList.picData.map((map) {
      return ImageCardModel.fromMap(map);
    }).toList();

    imgcard.assignAll(picData);

    final List<NewsCardModel> newsData = DataList.newsData.map((map) {
      return NewsCardModel.fromMap(map);
    }).toList();

    newscard.assignAll(newsData);
  }
}
