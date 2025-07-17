import 'package:flutter/material.dart';

import 'all_detail_quota.dart';
import 'filter_quota.dart';
import 'title_quota.dart';

class BodyQuota extends StatelessWidget {
  const BodyQuota({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Divider(color: Colors.grey[400], thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FilterQuota(), // เอา parameter วันที่ออก
                SizedBox(height: 24),
                TitleQuota(),
                SizedBox(height: 24),
                AllDetailQuota(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
