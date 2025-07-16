import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_controller.dart';
import 'widgets/notification_head.dart';
import 'widgets/notification_list.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            NotificationHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            NotificationList(),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}
