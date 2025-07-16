// lib/app/ui/pages/timetable_page/timetable_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/my_colors.dart';
import '../../../data/models/timetable_model.dart';
import 'timetable_controllers.dart';
import 'widgets/timetable_head.dart';

class TimetablePage extends GetView<TimetableController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            TimetableHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterSection(context),
                    const SizedBox(height: 24),
                    const Text(
                      'รายการ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // เมธอดสำหรับสร้างรายการการ์ดตารางเวลาที่สามารถเลื่อนได้
            _buildScheduleList(),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
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
            controller.loadTimetableData();
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 20,
          ),
         
        ),
      ],
    );
  }

  // เมธอดสำหรับสร้างรายการการ์ดตารางเวลาที่สามารถเลื่อนได้
  //จะแสดงรายการตามลำดับและให้ดึงมาจาก indexและนำข้อมูลนั้นมาแสดงเป็นcardต่อไป
  Widget _buildScheduleList() {
    return Obx(
      () => SliverPadding(
        //เพื่มระยะห่างระหว่างการ์ด
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final schedule = controller.schedules[index];
            // ส่ง index ไปยัง _buildScheduleCard ด้วย
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildScheduleCard(
                schedule,
                index,
              ), // <--- แก้ไขตรงนี้: ส่ง index ไปด้วย
            );
          }, childCount: controller.schedules.length),
        ),
      ),
    );
  }

  // เมธอดสำหรับสร้างการ์ดตารางเวลาแต่ละรายการ (รับ index เข้ามาด้วย)
  Widget _buildScheduleCard(TimetableModel schedule, int index) {
    // <--- แก้ไขตรงนี้: เพิ่ม int index
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border:
              schedule
                  .isExpanded
                  .value // ตรวจสอบสถานะการขยายจากการ์ดเอง
              ? Border.all(color: MyColors.blue, width: 2.0)
              : Border.all(color: Colors.transparent),
        ),
        child: GestureDetector(
          onTap: () {
            // ถ้าการ์ดขยายอยู่ แตะมันซ้ำ มันก็จะปิด
            controller.toggleCardExpansion(index);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'วันที่: ${schedule.date}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    schedule
                            .isExpanded
                            .value // เปลี่ยน icon ตามสถานะการขยาย
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'เวลาทำงาน: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '(เข้า) ${schedule.checkInTime} - (ออก) ${schedule.checkOutTime}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              if (schedule.isExpanded.value) ...[
                // แสดงส่วนนี้เมื่อการ์ดขยายเท่านั้น
                const SizedBox(height: 16), // เว้นระยะก่อนเส้นแบ่ง
                Container(
                  height: 1.0, // ความสูงของเส้น
                  width: 230.0, // ความยาวของเส้น
                  color: Colors.grey[300], // สีของเส้น
                ),
                const SizedBox(height: 16),

                RichText(
                  text: TextSpan(
                    text: 'สถานะ: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: schedule.status,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'หมายเหตุ: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: schedule.note,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
