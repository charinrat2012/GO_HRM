import 'package:flutter/material.dart';

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
            backgroundColor: Colors.grey[50],
            actions: [
              IconButton(
                onPressed: () {},
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