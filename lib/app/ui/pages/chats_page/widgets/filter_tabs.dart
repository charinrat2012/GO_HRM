import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../chats_controller.dart';

class FilterTabs extends GetView<ChatsController> {
  const FilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildFilterTabs();
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Obx(
        () => Row(
          children: [
            _buildTabItem(text: 'ทั้งหมด', index: 0),
            _buildTabItem(text: 'ยังไม่อ่าน', index: 1),
            _buildTabItem(text: 'กลุ่ม', index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({required String text, required int index}) {
    final isSelected = controller.selectedTabIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? MyColors.blue2 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? MyColors.blue2 : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
