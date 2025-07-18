import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';


class ListCard extends StatelessWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
      
        _buildSalaryCardItem(
          month: 'ฟฤษภาคม',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          onTap: () {
            Get.toNamed(AppRoutes.SALARYDETAIL);
          },
        ),
        _buildSalaryCardItem(
          month: 'มิถุนายน',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          onTap: () {
            // ใส่การทำงานตอนกด
          },
        ),
        _buildSalaryCardItem(
          month: 'มิถุนายน',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          onTap: () {
            // ใส่การทำงานตอนกด
          },
        ),
        _buildSalaryCardItem(
          month: 'มิถุนายน',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          onTap: () {
            // ใส่การทำงานตอนกด
          },
        ),
        _buildSalaryCardItem(
          month: 'มิถุนายน',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          onTap: () {
            // ใส่การทำงานตอนกด
          },
        ),
        _buildSalaryCardItem(
          month: 'มิถุนายน',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          onTap: () {
            // ใส่การทำงานตอนกด
          },
        ),
      ]),
    );
  }

  // เมธอดนี้สร้างรายการการ์ดแต่ละรายการ ซึ่งจะถูกห่อหุ้มด้วย Padding
  Widget _buildSalaryCardItem({
    required String month,
    required String payDate,
    IconData icon = Icons.arrow_forward_ios,
    VoidCallback? onTap,
  }) {
    return Padding(
      // ใช้ Padding ตรงนี้แทน SliverPadding เมื่ออยู่ภายใน SliverList
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
