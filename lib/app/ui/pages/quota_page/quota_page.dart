import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/quota_page/widgets/head_quota.dart';
import 'package:go_hrm/app/ui/pages/quota_page/widgets/title_quota.dart';


import 'quota_controller.dart';
import 'widgets/all_detail_quota.dart';
import 'widgets/filter_quota.dart';

class QuotaPage extends GetView<QuotaController> {
  const QuotaPage({super.key});


    @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            HeadQuota(),
          SliverToBoxAdapter(
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
    ),
          ],
        ),
      ),
    );
  }
}

