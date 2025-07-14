import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'news_controller.dart';
import 'widgets/activity_bar.dart';
import 'widgets/image_dots.dart';
import 'widgets/news_head.dart';
import 'widgets/news_feed.dart';
import 'widgets/slide_image.dart';




class NewsPage extends GetView<NewsController> {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          NewsHead(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SlideImage(),
                const SizedBox(height: 24),
                ImageDots(),
                const SizedBox(height: 16),
                ActivityBar(),
              ],
            ),
          ),

          NewsFeed(),
        ],
      ),
    );
  }
}
