import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../leave_controller.dart';
import '../../../../config/my_colors.dart';

class RequestButton extends GetView<LeavePageController> {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedViewIndex.value == 0) {
        return _buildRequestButton();
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildRequestButton() {
    return SizedBox(
      width: double.infinity,
      height: 66,
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed(AppRoutes.CREATE_LEAVE_REQUEST),
        icon: const Icon(Icons.add_circle_outline, color: Colors.white),
        label: const Text('ขอลางาน'),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.blue2,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
