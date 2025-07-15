import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import 'package:go_hrm/app/ui/pages/leave_page.dart/leave_controller.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/leave_status_model.dart';

class HistoryCardList extends GetView<LeavePageController> {
  const HistoryCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildHistoryList(); 
}
Widget _buildHistoryList() {
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = controller.leaveHistory[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHistoryCard(
                item,
                isManagerView: controller.selectedViewIndex.value == 1,
              ),
            );
          }, childCount: controller.leaveHistory.length),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    LeaveHistoryModel item, {
    required bool isManagerView,
  }) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(item.requestDateTime);
    final formattedTime = DateFormat('HH:mm น.').format(item.requestDateTime);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.blue2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: '${item.employeeName} ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),

                        children: [
                          TextSpan(
                            text: 'ยื่นขอ ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '"${item.leaveCategory}"',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text.rich(
                    //   TextSpan(
                    //     text: '${item.employeeName} ',
                    //     style: const TextStyle(color: Colors.black,

                    //     ),
                    //     children: [

                    //       TextSpan(
                    //         text: '"${item.leaveCategory}"',
                    //         style: const TextStyle( color: Colors.black),
                    //       ),
                    //     ],

                    //   ),
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      'ขอวันที่ $formattedDate เวลา $formattedTime',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'หมายเหตุ: ${item.note ?? '-'}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: item.statusBadgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.statusText,
                  style: TextStyle(color: item.statusTextColor, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // แสดงปุ่มเฉพาะเมื่อเป็นมุมมอง "ของพนักงาน"
          if (isManagerView) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('ยกเลิก',style: TextStyle(color: MyColors.blue2,fontWeight: FontWeight.bold),),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MyColors.blue2,
                      side: const BorderSide(color: MyColors.blue2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {}, // ปิดปุ่มถ้าไม่ใชสถานะ "รออนุมัติ"
                    child: Text('อนุมัติ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.blue2,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}