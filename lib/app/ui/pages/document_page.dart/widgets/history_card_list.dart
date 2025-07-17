import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/data/models/document_status_model.dart';
import 'package:intl/intl.dart';

import '../../../../config/my_colors.dart';
// ตรวจสอบ Path ของ Model และ Controller ให้ถูกต้อง

import '../document_controller.dart';

class HistoryCardList extends GetView<DocumentsController> {
  const HistoryCardList({super.key});

  @override
  Widget build(BuildContext context) {
    // ส่วนนี้ถูกต้องแล้ว ไม่ต้องแก้ไข
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = controller.leaveHistory[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              // เรียกใช้ Widget ที่แก้ไขใหม่แล้ว
              child: _buildHistoryCard(
                item,
                index,
                isManagerView: controller.selectedViewIndex.value == 1,
              ),
            );
          }, childCount: controller.leaveHistory.length),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    DocumentHistoryModel item,
    int index, {
    required bool isManagerView,
  }) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(item.requestDateTime);
    final formattedTime = DateFormat('HH:mm น.').format(item.requestDateTime);

    return Obx(() {
      final bool isExpanded = controller.expandedCardIndex.value == index;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded ? MyColors.blue2 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MyColors.blue2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: '${item.employeeName} '),
                            const TextSpan(
                              text: 'ยื่นขอ ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '"${item.leaveCategory}"',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ขอวันที่ $formattedDate เวลา $formattedTime',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'หมายเหตุ: ${item.note ?? '-'}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
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
                    style: TextStyle(
                      color: item.statusTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 8),
            ExpansionTile(
              key: GlobalKey(),
              tilePadding: EdgeInsets.only(right: 130),

              // **ควบคุมสถานะการเปิด-ปิดจาก Controller**
              initiallyExpanded: controller.expandedCardIndex.value == index,

              // **เมื่อมีการกด ให้ไปอัปเดตสถานะใน Controller**
              onExpansionChanged: (isExpanding) {
                if (isExpanding) {
                  // ถ้ากดเปิด ให้ตั้งค่า index ปัจจุบัน
                  controller.expandedCardIndex.value = index;
                } else {
                  // ถ้ากดปิด ให้เคลียร์ค่า (ไม่มีการ์ดไหนถูกเปิด)
                  controller.expandedCardIndex.value = null;
                }
              },
              //  shape: LinearBorder.none,
              // collapsedShape: LinearBorder.none,
              dense: true,

              // tilePadding: EdgeInsets.zero,
              // ทำให้ไม่มี padding ด้านในเมื่อยังไม่ขยาย
              // childrenPadding: const EdgeInsets.only(top: 8),
              title: Text(
                'ดูรูปภาพและไฟล์เพิ่มเติม',
                style: TextStyle(
                  color: MyColors.blue2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                if (item.attachedFiles != null &&
                    item.attachedFiles!.isNotEmpty)
                  // ถ้ามี ให้วนลูปแสดงรายการไฟล์
                  ...item.attachedFiles!
                      .map((file) => _buildAttachmentItem(file))
                      .toList()
                else
                  // ถ้าไม่มี ให้แสดงข้อความ
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'ไม่มีไฟล์แนบ',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),

            if (isManagerView) ...[
              const SizedBox(height: 8),
              _buildManagerActionButtons(),
            ],
          ],
        ),
      );
    });
  }

  // Helper สำหรับสร้างปุ่มของ Manager (โค้ดเดิม)
  Widget _buildManagerActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: MyColors.blue2,
              side: BorderSide(color: MyColors.blue2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'ยกเลิก',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.blue2,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('อนุมัติ'),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentItem(File file) {
    final fileName = file.path.split('/').last;
    final fileExtension = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : '';
    IconData getIconForFile(String extension) {
      if (['jpg', 'jpeg', 'png'].contains(extension))
        return Icons.image_outlined;
      if (extension == 'pdf') return Icons.picture_as_pdf_outlined;
      if (['doc', 'docx'].contains(extension))
        return Icons.description_outlined;
      return Icons.insert_drive_file_outlined;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Color.fromRGBO(204, 218, 255, 1)),
        ),
        leading: Icon(getIconForFile(fileExtension), color: Colors.grey[700]),
        title: Text(fileName, style: const TextStyle(fontSize: 14)),
        dense: true,
      ),
    );
  }
}
