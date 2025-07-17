import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../quota_controller.dart';

class FilterQuota extends GetView<QuotaController> {
  const FilterQuota({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildFilterSection()); 
  }
   Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

         
            const SizedBox(height: 16),

            _buildDropdown(
              'เลือกปี',
              controller.years,
              controller.selectedYear,

            ),
          const SizedBox(height: 16),
          _buildDropdown(
            'รายละเอียด',
            controller.other,
            controller.selectedOther,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    RxnString selectedItem,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        DropdownButtonFormField<String>(
          icon:  const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: MyColors.blue2,
            ),
          dropdownColor: Colors.white,
          value: selectedItem.value,
          isDense: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedItem.value = newValue;
          },
        ),
      ],
    );
  }
}