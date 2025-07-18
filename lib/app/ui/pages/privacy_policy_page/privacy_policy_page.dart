import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'privacy_policy_controller.dart';
import 'widgets/privacy_policy_form.dart';
import 'widgets/privacy_policy_head.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            PrivacyPolicyHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            PrivacyPolicyForm(),
          ],
        ),
      ),
    );
  }
}
