import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../document_controller.dart';

class SegmentedControl extends GetView<DocumentsController> {
  const SegmentedControl({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSegmentedControl();
  }
   Widget _buildSegmentedControl() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: CupertinoSlidingSegmentedControl<int>(
            backgroundColor: Colors.white,
            thumbColor: Colors.blue[50]!,
            groupValue: controller.selectedViewIndex.value,
            onValueChanged: controller.onViewChanged,
            children: {
              0: _buildSegment('ของตัวเอง', 0),
              1: _buildSegment('ของพนักงาน', 1),
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSegment(String text, int index) {
    final isSelected = controller.selectedViewIndex.value == index;
    return Container(
      decoration: isSelected
          ? BoxDecoration(borderRadius: BorderRadius.circular(10))
          : null,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? MyColors.blue2 : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }

}