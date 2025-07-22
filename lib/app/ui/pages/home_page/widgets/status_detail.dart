import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import '../../../../config/my_colors.dart';
import '../home_controller.dart';
import 'dia_test.dart';

class StatusDetail extends GetView<HomeController> {
  const StatusDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: MyColors.blue2,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              controller.currentDateFormatted.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // --- ส่วนของสถานที่ (เหมือนเดิม) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'สถานที่ลงเวลาเข้างาน (เช้า)',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Absolute HQ Tower',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 38,
                child: VerticalDivider(
                  color: Colors.white54,
                  thickness: 1,
                  width: 20,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'สถานที่ลงเวลาเข้างาน (บ่าย)',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Absolute HQ Tower',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- ส่วนของเวลา (โค้ดที่แก้ไขใหม่ตามรูป) ---
          Row(
            children: [
              SizedBox(
                width: 108,
                height: 108,
                child: Obx( // เพิ่ม Obx เพื่อให้ CircularProgressIndicator อัปเดต
                  () => Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: controller.workProgressPercentage.value, // ใช้ค่าจาก Controller
                        strokeWidth: 8,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(251, 188, 5, 1),
                        ),
                      ),
                      Center(
                        child: Obx(
                          () => RichText(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            text: TextSpan(
                              text: controller.elapsedHoursMinutes.value.split(' ')[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' ชม.\n${controller.elapsedHoursMinutes.value.split(' ')[2]} นาที',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- ส่วนบน: ชั่วโมงการทำงาน ---
                    const Text(
                      'ชั่วโมงเวลาการทำงาน',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          text: controller.currentWorkTimeFormatted.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '         คงเหลือ ${controller.remainingWorkTimeFormatted.value}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- ส่วนล่าง: ลงเวลาเข้า/ออก ---
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ลงเวลาเข้า',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            Obx(
                              () => Text(
                                controller.workInTimeFormatted.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ลงเวลาออก',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            Obx(
                              () => Text(
                                controller.workOutTimeFormatted.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.dialog(
                ClockInSuccessDialog(
                  dateTime: DateTime.now(),
                  location: 'Absolute HQ Tower',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'ลงเวลาเข้า/ออกงาน',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}