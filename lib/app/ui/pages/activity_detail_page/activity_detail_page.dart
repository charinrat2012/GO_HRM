import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'activity_detail_controller.dart';
import 'widgets/activity_detail_box.dart';
import 'widgets/activity_detail_head.dart';

class ActivityDetailPage extends GetView<ActivityDetailController> {
  const ActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
           ActivityDetailHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
           ActivityDetailBox(),
          ],
        ),
      ),
    );
  }
}
