import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../splash_controllers.dart';

class Checkbotandforgot extends GetView<SplashController> {
  const Checkbotandforgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Row(
          children: [
            Obx(
              //เมื่อตัวแปร rememberMe เปลี่ยนค่า Checkbox จะอัปเดตตามอัตโนมัติ
              () => Checkbox(
                value: controller
                    .rememberMe
                    .value, //ใช้ค่าจากตัวแปร  rememberMe เพื่อกำหนดสถานะ Checkbox ว่าถูกเลือกอยู่หรือไม่
                onChanged: (_) {
                  controller.rememberMe
                      .toggle(); //มีการแตะจะสลับค่าระหว่าง true กับ false
                },
                activeColor: MyColors.blue,
                checkColor: Colors.white,
                side: BorderSide(color: Colors.grey[400]!),
                visualDensity: VisualDensity(
                  horizontal: -4, //ลดขนาดพื้นที่รอบๆให้น้อยลง
                  // vertical: -4, //ลดความสูง (ขนาดในแนวตั้ง) ให้น้อยลง
                ),
                materialTapTargetSize: MaterialTapTargetSize
                    .shrinkWrap, // ลดขนาดของพื้นที่ที่ตอบสนองต่อการสัมผัส
              ),
            ),
            const Text("  จำฉันไว้เลย"),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: ลืมรหัสผ่าน
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: const Text(
            "ลืมรหัสผ่าน?",
            style: TextStyle(color: MyColors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
