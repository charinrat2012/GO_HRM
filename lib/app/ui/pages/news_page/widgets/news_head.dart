import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../utils/assets.dart';
import '../news_controller.dart';

class NewsHead extends GetView<NewsController> {
  const NewsHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isSwitchedOn.value == true
          ? SliverAppBar(
              title: Image.asset(
                Assets.assetsImgsLogoAbsolute,
                height: 56,
                width: 138,
              ),
              pinned: false,
              floating: false,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: MyColors.blue2,
                    size: 19.5,
                  ),
                ),
              ],
            )
          : SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text(
                'ข่าวสาร',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              centerTitle: false,
              floating: false,
              pinned: false,
              elevation: 1.0,
              bottom: PreferredSize(
                // --- กำหนดความสูงของพื้นที่เส้นคั่น ---
                preferredSize: const Size.fromHeight(1.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
              ),
            ),
    );
  }
}
