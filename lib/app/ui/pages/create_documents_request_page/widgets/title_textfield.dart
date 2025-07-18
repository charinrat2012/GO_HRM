import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_documents_request_controller.dart';

class TitleTextfield extends GetView<CreateDocumentRequestController> {
  const TitleTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ชื่อเรื่องเอกสาร',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.detailsController,
          maxLines: 1,
          decoration: InputDecoration(hintText: 'กรุณากรอกรายละเอียด'),
        ),
      ],
    );
  }
}
