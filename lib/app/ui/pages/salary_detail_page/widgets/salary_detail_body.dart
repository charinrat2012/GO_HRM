import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/user_model.dart';
import '../salary_detail_controller.dart';

class SalaryDetailBody extends GetView<SalaryDetailController> {
  final UserModel? user;
  const SalaryDetailBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return  SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [],
                  ),

                  child: user == null
                      ? const Center(child: Text('ไม่พบข้อมูลพนักงาน'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ข้อมูลพนักงาน',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // --- ใช้ข้อมูลจาก currentUser มาแสดงผล ---
                            _buildInfoRow(
                              'รหัสพนักงาน',
                              user!.employeeId,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'ชื่อ - นามสกุล',
                              user!.userName,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'สำนักงาน',
                              'Absolute Management',
                            ), // อาจจะเพิ่ม field นี้ใน UserModel
                            const SizedBox(height: 8),
                            _buildInfoRow('ตำแหน่ง', user!.section),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'วันที่เริ่มงาน',
                              '25/06/2025',
                            ), // อาจจะเพิ่ม field นี้ใน UserModel
                            const SizedBox(height: 8),
                            _buildInfoRow('ประเภทการชำระเงิน', 'ไม่มี'),
                            const SizedBox(height: 8),
                            _buildInfoRow('สัญญาเงินเดือน', 'ไม่มี'),
                            const SizedBox(height: 8),
                            _buildInfoRow('งวดการจ่ายเงิน', 'ไม่มี'),
                            const SizedBox(height: 8),
                            _buildInfoRow('วันทำงาน', '-'),
                            const SizedBox(height: 8),
                            _buildInfoRow('วันที่ชำระเงิน', 'ไม่มี'),
                          ],
                        ),
                ),
              ),
            );
  }
    Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}