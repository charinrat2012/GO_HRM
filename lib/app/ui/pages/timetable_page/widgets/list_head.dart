import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../timetable_controllers.dart';

class ListHead extends GetView<TimetableController> {
  const ListHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(context),
            const SizedBox(height: 24),
            const Text(
              'รายการ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // เมธอดสำหรับสร้างส่วนฟิลเตอร์ปีและเดือน
  Widget _buildFilterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
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
    );
  }

  // เมธอดที่ใช้ซ้ำได้สำหรับสร้าง Dropdown
  Widget _buildDropdown(
    String label, //เลือกปี เดือน
    List<String> items, //รายการตัวเลือกใน Dropdown
    RxnString selectedItem, //รายการตัวเลือกที่เลือก
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        DropdownButtonFormField<String>(
          value: selectedItem.value,//กำหนดค่าเริ่มต้นหรือค่าที่ถูกเลือกอยู่ในปัจจุบัน
          isDense: true, // Dropdownมีขนาดพอดี
          items: items.map((String value) { //แสดงรายการตัวเลือกเมื่อเราเลือกมันส่่งค่ากลับมา
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
          }).toList(),// เมื่อผู้ใช้เลือกปีมันจะส่งค่าปีมาแล้วไปอัปเดตปีที่เราเลือกขึ้นมาแสดง
          onChanged: (newValue) {
            selectedItem.value = newValue;
            controller.loadTimetableData();
          },
         icon:  const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: MyColors.blue2,
            ),
          
        ),
      ],
    );
  }
}
