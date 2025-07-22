import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../salary_controller.dart'; 

class ListCard extends GetView<SalaryController> { 
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    // --- ใช้ Obx เพื่อ re-build รายการเมื่อข้อมูลใน controller เปลี่ยน ---
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // --- ดึงข้อมูลจาก salaryHistory ใน controller ---
            final salaryItem = controller.salaryHistory[index]; 
            return _buildSalaryCardItem(
              month: salaryItem['month']!,
              payDate: salaryItem['datePaid']!,
              onTap: () {
                Get.toNamed(
                  AppRoutes.SALARYDETAIL,
                  arguments: {
                    'month': salaryItem['month'],
                    'datePaid': salaryItem['datePaid'],
                  },
                );
              },
            );
          },
          // --- [แก้ไข] ใช้ความยาวของ salaryHistory ---
          childCount: controller.salaryHistory.length, 
        ),
      ),
    );
  }

  Widget _buildSalaryCardItem({
    required String month,
    required String payDate,
    IconData icon = Icons.arrow_forward_ios,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      month,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      payDate,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                Icon(icon, size: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}