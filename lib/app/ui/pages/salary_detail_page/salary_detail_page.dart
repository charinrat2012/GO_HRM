import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/my_colors.dart';
import 'salary_detail_controller.dart';
import 'widgets/salary_detail_head.dart';

class SalaryDetailPage extends GetView<SalaryDetailController> {
  const SalaryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // พยายามดึงค่า เดือน วันที่จ่าย จากหน้าจอก่อนหน้า ถ้าหาไม่เจอหรือไม่ได้รับค่ามา จะแสดง "ไม่ระบุเดือน" หรือ "ไม่ระบุวันที่จ่าย" 
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String month = args['month'] ?? 'ไม่ระบุเดือน';
    final String datePaid = args['datePaid'] ?? 'ไม่ระบุวันที่จ่าย';

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //หัวappbar
            SalaryDetailHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),

            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 25.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                month, // แสดงเดือนที่รับมา
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                'วันที่จ่าย $datePaid', // แสดงวันที่จ่ายที่รับมา
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
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
                    ],
                  ),
                ),
              ),
            ),

            SliverPadding(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'ข้อมูลพนักงงาน',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'รหัสพนักงาน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            '1123321456205',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ชื่อ - นามสกุล ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'ณัฐดนย์ ธวัชผ่องศรี',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'สำนักงาน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'Absolute Management',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ตำเเหน่ง ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'ดีไซเนอร์',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'วันที่เริ่มงาน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            '25/06/2025',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ประเภทการชำระเงิน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'ไม่มี',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'สัญญาเงินเดือน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'ไม่มี',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'งวดการจ่ายเงิน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'ไม่มี',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'วันทำงาน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            '215 วัน',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'วันที่ชำระเงิน ',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            'ไม่มี',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
