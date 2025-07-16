import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../data/models/timetable_model.dart';
import '../timetable_controllers.dart';

class TimetableForm extends GetView<TimetableController> {
  const TimetableForm({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // เมธอดสำหรับสร้างรายการการ์ดตารางเวลาที่สามารถเลื่อนได้
    _buildScheduleList();
  }

  // เมธอดสำหรับสร้างรายการการ์ดตารางเวลาที่สามารถเลื่อนได้โดยอัตโนมัติ
  //จะแสดงรายการตามลำดับและให้ดึงมาและนำข้อมูลนั้นมาแสดงเป็นcard
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
              child: _buildScheduleCard(schedule, index),
            );
          }, childCount: controller.schedules.length),
        ),
      ),
    );
  }

  // เมธอดสำหรับสร้างการ์ดตารางเวลาแต่ละรายการ
  Widget _buildScheduleCard(TimetableModel schedule, int index) {
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
