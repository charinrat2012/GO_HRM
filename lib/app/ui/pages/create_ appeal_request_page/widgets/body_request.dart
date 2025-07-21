import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_appeal_request_controller.dart';
import 'action_button_request.dart';
import 'datetime_picker.dart';
import 'detail_textfield.dart';
import 'file_picker_request.dart';
import 'title_textfield.dart';
import 'type_dropdown_request.dart';

class BodyRequest extends GetView<CreateAppealRequestController> {
  const BodyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TypeDropdownRequest(),
              const SizedBox(height: 24),
              TitleTextfield(),
              const SizedBox(height: 24),
              DatetimePicker(
                label: 'วันที่/เวลา',
                textController: controller.DateController,
              ),

              const SizedBox(height: 24),
              FilePickerRequest(),
              const SizedBox(height: 24),
              DetailTextfield(),
              const SizedBox(height: 24),
              ActionButtonRequest(),
            ],
          ),
        ),
      ),
    );
  }
}
