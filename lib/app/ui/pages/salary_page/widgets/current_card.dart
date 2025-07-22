import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../salary_controller.dart'; 

class CurrentCard extends GetView<SalaryController> { 
  const CurrentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverToBoxAdapter(
        // --- ใช้ Obx เพื่อ re-build เมื่อข้อมูลใน controller เปลี่ยน ---
        child: Obx(() {
          // --- ดึงข้อมูลเงินเดือนล่าสุดจาก controller ---
          final currentSalary = controller.currentSalary.value;

          // --- หากไม่มีข้อมูลสำหรับปีที่เลือก ให้แสดงข้อความ ---
          if (currentSalary == null) {
            return const Center(child: Text('ไม่มีข้อมูลสำหรับปีที่เลือก'));
          }
          
          // --- หากมีข้อมูล ให้สร้างการ์ด ---
          return _buildSalaryCard(
            month: currentSalary['month']!,
            payDate: currentSalary['datePaid']!,
            icon: Icons.arrow_forward_ios,
            onTap: () {
              Get.toNamed(
                AppRoutes.SALARYDETAIL,
                arguments: {
                  'month': currentSalary['month'],
                  'datePaid': currentSalary['datePaid'],
                },
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildSalaryCard({
    required String month,
    required String payDate,
    IconData icon = Icons.arrow_forward_ios,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    );
  }
}