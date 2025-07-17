import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../data/models/quota_model.dart';
import '../create_leave_request_controller.dart';

class TypeDropdownRequest extends GetView<CreateLeaveRequestController> {
  const TypeDropdownRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ประเภทการลา',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField<QuotaModel>(
            isDense: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: MyColors.blue2,
            ),

            dropdownColor: Colors.white,
            iconEnabledColor: MyColors.blue2,
            iconDisabledColor: MyColors.blue2,
            // value คืออ็อบเจกต์ QuotaModel ที่ถูกเลือกอยู่
            value: controller.selectedQuota.value,
            // items สร้างจาก List ของ Model ใน Controller
            items: controller.quotaItems.map((QuotaModel model) {
              return DropdownMenuItem<QuotaModel>(
                value: model,
                child: Text(model.type),
              );
            }).toList(),
            // เมื่อมีการเลือกค่าใหม่ ให้อัปเดต State ใน Controller
            onChanged: (newValue) {
              if (newValue != null) {
                controller.selectedQuota.value = newValue;
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        // --- หุ้มด้วย Obx เพื่อให้ข้อความอัปเดตตาม Dropdown ---
        Obx(() {
          // ดึงข้อมูลจาก Model ที่ถูกเลือกอยู่มาแสดง
          final selected = controller.selectedQuota.value;
          // ถ้ายังไม่มีการเลือก (หรือกำลังโหลด) ให้แสดงเป็นค่าว่าง
          if (selected == null) {
            return const SizedBox.shrink();
          }
          // แสดงผลจำนวนวันที่เหลือและวันทั้งหมด
          return Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                text: '${selected.remaining} วัน',
                style: const TextStyle(fontSize: 12, color: MyColors.blue),
                children: [
                  TextSpan(
                    text: ' / ${selected.total} วัน',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Text(
            //   '${selected.remaining} วัน / ${selected.total} วัน',
            //   style: TextStyle(fontSize: 12, color: MyColors.blue),
            // ),
          );
        }),
      ],
    );
  }
}
