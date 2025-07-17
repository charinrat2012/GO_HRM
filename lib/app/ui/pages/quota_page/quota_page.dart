import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'quota_controller.dart';
import 'widgets/body_quota.dart';
import 'widgets/head_quota.dart';

class QuotaPage extends GetView<QuotaController> {
  const QuotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [HeadQuota(), BodyQuota()]),
      ),
    );
  }
}
