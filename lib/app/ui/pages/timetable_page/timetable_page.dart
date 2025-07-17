import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'timetable_controllers.dart';
import 'widgets/list_head.dart';
import 'widgets/timetable_form.dart';
import 'widgets/timetable_head.dart';

class TimetablePage extends GetView<TimetableController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            TimetableHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ListHead(),
            TimetableForm(),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}
