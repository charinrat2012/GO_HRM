import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'salary_controller.dart';
import 'widgets/current_card.dart';
import 'widgets/current_head.dart';
import 'widgets/list_card.dart';
import 'widgets/list_head.dart';
import 'widgets/salary_head.dart';
import 'widgets/year_filter.dart';




class SalaryPage extends GetView<SalaryController> {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SalaryHead(),
            YearFilter(),
            CurrentHead(),
            CurrentCard(),
            ListHead(),
            ListCard(),

            const SliverToBoxAdapter(child: SizedBox(height: 70.0)),
          ],
        ),
      ),
    );
  }
}
