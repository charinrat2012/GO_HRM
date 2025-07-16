import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_documents_request_controller.dart';

class DetailTextfield extends GetView<CreateDocumentRequestController> {
  const DetailTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รายละเอียด',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.detailsController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'กรุณากรอกรายละเอียด',
           
          ),
        ),
      ],
    );
  }
}