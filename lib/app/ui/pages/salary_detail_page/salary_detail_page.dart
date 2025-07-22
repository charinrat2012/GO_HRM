import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../config/my_colors.dart';
import 'salary_detail_controller.dart';
import 'widgets/salary_detail_body.dart';
import 'widgets/salary_detail_card.dart';
import 'widgets/salary_detail_head.dart';

class SalaryDetailPage extends GetView<SalaryDetailController> {
  const SalaryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SalaryDetailHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            SalaryDetailCard(),
            SalaryDetailBody(user: controller.currentUser),
          
          ],
        ),
      ),
    );
  }



}
