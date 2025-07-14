import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:go_hrm/app/routes/app_routes.dart';

import '../../../utils/assets.dart';

class HomeHead extends StatelessWidget {
  const HomeHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
            title: Image.asset(
              Assets.assetsImgsLogoAbsolute,
              height: 56,
              width: 138,
            ),
            pinned: false,
            floating: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.NOTIFICATION),
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 19.5,
                ),
              ),
            ],
          );
  }
}