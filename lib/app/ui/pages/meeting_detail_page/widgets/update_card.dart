import 'package:flutter/material.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // 5. ส่วนของ "อัปเดต"
    SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'อัปเดต',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUpdateItem(
                    '1.สร้างหน้าโปรไฟล์ใหม่ (มีการค้นหาที่มากขึ้น) และแสดงการตอบกลับตั้งค่าหน้าใหม่ อีกครั้ง \n(เพิ่มเติมของเดิม)',
                  ),
                  _buildUpdateItem('2.ปรับแบบฟอร์มการเข้าและการเวลา งานใหม่'),
                  _buildUpdateItem(
                    '3.รื้อหน้าบัญชีและการโอนเงิน (สลิปโอนเงิน)',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String text) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle( color: Colors.grey[700]),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        // vertical: 0,
      ), // ปรับ padding
      dense: true, // ทำให้ ListTile กระชับขึ้น
    );
  }
}
