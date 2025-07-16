import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../create_documents_request_controller.dart';

class ActionButtonRequest extends GetView<CreateDocumentRequestController> {
  const ActionButtonRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              foregroundColor: MyColors.blue2,
              side: const BorderSide(color: MyColors.blue2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'ยกเลิก',
              style: TextStyle(
                color: MyColors.blue2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Get.snackbar('ขออภัย', 'ยังไม่มีระบบบันทึกข้อมูลในขณะนี้'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('บันทึก'),
          ),
        ),
      ],
    );
  }
}