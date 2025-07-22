import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_appeal_request_controller.dart';
import 'widgets/body_request.dart';
import 'widgets/head_leave_request.dart';

class CreateAppealRequestPage extends GetView<CreateAppealRequestController> {
  const CreateAppealRequestPage({super.key});

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
