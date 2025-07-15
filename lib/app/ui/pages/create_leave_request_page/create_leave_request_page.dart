import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/create_leave_request_page/widgets/body_request.dart';



import '../../../config/my_colors.dart';
import '../../../data/models/quota_model.dart';
import 'create_leave_request_controller.dart';
import 'widgets/action_button_request.dart';
import 'widgets/datetime_picker.dart';
import 'widgets/detail_textfield.dart';
import 'widgets/file_picker_request.dart';
import 'widgets/head_leave_request.dart';
import 'widgets/type_dropdown_request.dart';

class CreateLeaveRequestPage extends GetView<CreateLeaveRequestController> {
  const CreateLeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            HeadLeaveRequest(),
            BodyRequest(),
          ],
        ),
      ),
    );
  }




}
