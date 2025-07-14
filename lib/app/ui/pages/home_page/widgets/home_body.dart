import 'package:flutter/material.dart';

import 'home_menu.dart';
import 'quota_detail.dart';
import 'status_detail.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey[400], thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StatusDetail(), // เอา parameter วันที่ออก
                SizedBox(height: 24),
                HomeMenu(),
                SizedBox(height: 24),
                QuotaDetail(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
