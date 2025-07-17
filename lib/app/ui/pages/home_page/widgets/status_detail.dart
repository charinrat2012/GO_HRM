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
    final now = DateTime.now();
    // 2. จัดรูปแบบวันที่ให้เป็นภาษาไทยตามที่ต้องการ
    final formattedDate = DateFormat(
      'EEEEที่ d MMMM yyyy',
      'th_TH',
    ).format(now);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: MyColors.blue2,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$formattedDate',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const CircularProgressIndicator(
                      value: 0.9,
                      strokeWidth: 8,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(251, 188, 5, 1),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            text: TextSpan(
                              text: '8 ชม.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '\n32 นาที',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text('8', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          //     Text('ชม.', style: TextStyle(color: Colors.white, fontSize: 12)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //    Text('32', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          //     Text('นาที', style: TextStyle(color: Colors.white, fontSize: 12)),
                          // ])
                        ],
                      ),
                    ),
                  ],
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
                    RichText(
                      text: const TextSpan(
                        text: '08:32:52',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '         คงเหลือ 24:58',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: const [
                    //     Text('08:32:52', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    //     SizedBox(width: 20),
                    //     Text('คงเหลือ 24:58', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    //   ],
                    // ),
                    const SizedBox(height: 16),

                    // --- ส่วนล่าง: ลงเวลาเข้า/ออก ---
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'ลงเวลาเข้า',
                              style: TextStyle(color: Colors.white70),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '08:54:18',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'ลงเวลาออก',
                              style: TextStyle(color: Colors.white70),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '17:30:36',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
