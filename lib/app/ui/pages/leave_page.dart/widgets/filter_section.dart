
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../leave_controller.dart';


class FilterSection extends GetView<LeavePageController> {
  const FilterSection({super.key});

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
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  'เลือกปี',
                  controller.years,
                  controller.selectedYear,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown(
                  'เลือกเดือน',
                  controller.months,
                  controller.selectedMonth,
                ),
              ),
            ],
          ),
          if (controller.selectedViewIndex.value == 0) ...[
            const SizedBox(height: 16),

            _buildDropdown(
              'สถานะ',
              controller.leaveTypes,
              controller.selectedLeaveType,
            ),
          ],

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

          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,

            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
           isDense: true,
          ),
        ),
      ],
    );
  }
}