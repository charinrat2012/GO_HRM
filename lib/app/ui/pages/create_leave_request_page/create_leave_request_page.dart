import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_documents_request_page/widgets/body_request.dart';
import 'create_leave_request_controller.dart';
import 'widgets/head_leave_request.dart';

class CreateLeaveRequestPage extends GetView<CreateLeaveRequestController> {
  const CreateLeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(slivers: [HeadLeaveRequest(), BodyRequest()]),
      ),
    );
  }
}
