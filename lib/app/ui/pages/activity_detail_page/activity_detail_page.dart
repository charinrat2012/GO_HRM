import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/activity_detail_page/widgets/activity_detail_page_box.dart';
import 'package:go_hrm/app/ui/pages/activity_detail_page/widgets/activity_detail_page_head.dart';

import 'activity_detail_page_controller.dart';

class ActivityDetailPage extends GetView<ActivityDetailPageController> {
  const ActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
           ActivityDetailPageHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
           ActivityDetailPageBox(),
          ],
        ),
      ),
    );
  }
}
