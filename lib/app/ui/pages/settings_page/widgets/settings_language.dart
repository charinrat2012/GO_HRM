import 'package:flutter/material.dart';

class SettingsLanguage extends StatelessWidget {
  const SettingsLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildSettingsCard(context, 'ภาษา', 'ไทย'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับสร้างการ์ดตั้งค่าแต่ละรายการ
  Widget _buildSettingsCard(
    BuildContext context,
    String title,
    String rightText,
  ) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          trailing: Text(
            rightText,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
