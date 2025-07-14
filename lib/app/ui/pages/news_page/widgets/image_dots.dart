import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../news_controller.dart';
import 'indicator.dart';

class ImageDots extends GetView<NewsController> {
  const ImageDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.imgcard.length,
          (index) =>
              Indicator(isActive: controller.currentPageIndex.value == index),
        ),
      ),
    );
  }
}
