import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../news_controller.dart';
import 'news_card.dart';

class NewsFeed extends GetView<NewsController> {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.newscard.isEmpty
          ? const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(48.0),
                child: Center(child: Text('ไม่มีข่าว')),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final news = controller.newscard[index];
                return NewsCard(
                  news: news,
                  onTap: () =>
                      Get.toNamed(AppRoutes.NEWS_DETAILS, arguments: news),
                );
              }, childCount: controller.newscard.length),
            ),
    );
  }
}
