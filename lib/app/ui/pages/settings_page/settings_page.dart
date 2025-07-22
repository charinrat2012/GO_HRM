import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';
import 'widgets/settings_head.dart';
import 'widgets/settings_language.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SettingsHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 30.0)),
            SettingsLanguage(),
            const SliverToBoxAdapter(child: SizedBox(height: 30.0)),
          ],
        ),
      ),
    );
  }
}
