import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/leave_page.dart/widgets/segmented_control.dart';

import 'package:intl/intl.dart';

import '../../../config/my_colors.dart';
import '../../../data/models/leave_status_model.dart';
import 'leave_controller.dart';
import 'widgets/card_title.dart';
import 'widgets/filter_section.dart';
import 'widgets/history_card_list.dart';
import 'widgets/request_button.dart';

class LeavePage extends GetView<LeavePageController> {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                'ขอลางาน',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1.0,
              centerTitle: true,
              floating: false, // ทำให้ AppBar เลื่อนกลับมาแสดงผลได้เร็วขึ้น
              pinned: false, // ทำให้ AppBar ปักหมุดอยู่ด้านบนเสมอ
              expandedHeight: kToolbarHeight,
            ),

           
            const SliverToBoxAdapter(
              child: Divider(color: Colors.grey, thickness: 1),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedControl(),
                    const SizedBox(height: 16),
                   RequestButton(),
                    const SizedBox(height: 16),
                    FilterSection(),
                    const SizedBox(height: 24),
                    CardTitle(), 
                  ],
                ),
              ),
            ),

            // --- แก้ไข: เปลี่ยน _buildHistoryList ให้เป็น SliverList ---
            HistoryCardList(),
            SliverToBoxAdapter(child: const SizedBox(height: 64)),
          ],
        ),
      ),
    );
  }

 


 
 
}
