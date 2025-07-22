import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_appeal_request_controller.dart';

class DatetimePicker extends GetView<CreateAppealRequestController> {
  final String label;
  final TextEditingController textController;
  const DatetimePicker({
    super.key,
    required this.label,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: textController,
          readOnly: true,
          onTap: () => controller.selectDateTime(Get.context!, textController),
          decoration: InputDecoration(
            hintText: 'เลือกวันที่/เวลา',

            // contentPadding: const EdgeInsets.all(12),
            suffixIcon: Icon(Icons.calendar_today_outlined),
          ),
        ),
      ],
    );
  }
}
