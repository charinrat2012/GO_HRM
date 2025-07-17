import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// --- Widget หลักสำหรับแสดง Dialog ---
class ClockInSuccessDialog extends StatelessWidget {
  const ClockInSuccessDialog({
    super.key,
    required this.dateTime,
    required this.location,
  });

  final DateTime dateTime;
  final String location;

  @override
  Widget build(BuildContext context) {
    // จัดรูปแบบวันที่และเวลา
    final String formattedDate = DateFormat(
      'EEE, d MMM yyyy',
      'th_TH',
    ).format(dateTime);
    final String formattedTime = DateFormat(
      'HH.mm น.',
      'th_TH',
    ).format(dateTime);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, formattedDate, formattedTime),
    );
  }

  // --- ส่วนเนื้อหาของ Dialog ---
  Widget contentBox(BuildContext context, String date, String time) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ทำให้ขนาดของ Column พอดีกับเนื้อหา
        children: <Widget>[
          const Text(
            'ลงเวลาเข้า/ออกงานสำเร็จ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // --- ไอคอนเครื่องหมายถูก ---
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.green,
            child: Icon(Icons.check, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 24),

          // --- รายละเอียด วันที่, เวลา, สถานที่ ---
          _buildInfoRow('วันที่:', date),
          const SizedBox(height: 12),
          _buildInfoRow('เวลา:', time),
          const SizedBox(height: 12),
          _buildInfoRow('Location:', location),
          const SizedBox(height: 32),

          // --- ปุ่มยืนยัน ---
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Get.back(); // ปิด Dialog
              },
              child: const Text(
                'ยืนยัน',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget สำหรับสร้างแถวข้อมูล ---
  Widget _buildInfoRow(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// --- วิธีการเรียกใช้งาน ---
// คุณสามารถนำฟังก์ชันนี้ไปวางใน Controller ของคุณ
// แล้วเรียกใช้หลังจากที่การลงเวลาสำเร็จ
void showSuccessDialog() {
  Get.dialog(
    ClockInSuccessDialog(
      dateTime: DateTime.now(), // ส่งเวลาปัจจุบันเข้าไป
      location: 'Absolute HQ Tower', // ส่งชื่อสถานที่เข้าไป
    ),
    // ทำให้ไม่สามารถกดปิด Dialog จากพื้นที่ด้านนอกได้
    barrierDismissible: false,
  );
}
