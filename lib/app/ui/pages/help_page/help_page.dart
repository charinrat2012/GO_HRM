import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'help_controller.dart';
import 'widgets/help_from.dart';
import 'widgets/help_head.dart';

class HelpPage extends GetView<HelpController> {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            HelpHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 30.0)),
            HelpFrom(),
            const SliverToBoxAdapter(child: SizedBox(height: 30.0)),
          ],
        ),
      ),
    );
  }
}
