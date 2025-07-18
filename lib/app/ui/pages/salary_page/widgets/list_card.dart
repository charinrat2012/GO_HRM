import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../global_widgets/datalist.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final salaryItem = DataList.salaryData[index];
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
        childCount: DataList
            .salaryData
            .length, // มีจำนวนรายการทั้งหมดกี่รายการที่จะต้องสร้าง ใช้ข้อมูลจาก salaryData
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap:
            onTap ?? () {}, //ถ้าแตะจะลิ้งไปหน้าที่กำหนดถ้าไม่แตะก็จะไม่ลิ้งไป
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
