import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../salary_detail_controller.dart';

class SalaryDetailCard extends GetView<SalaryDetailController> {
  const SalaryDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.month, // แสดงเดือนที่รับมา
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'วันที่จ่าย ${controller.datePaid}', // แสดงวันที่จ่ายที่รับมา
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.save_alt,
                  color: MyColors.blue,
                  size: 20.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
