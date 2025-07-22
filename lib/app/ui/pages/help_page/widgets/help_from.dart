import 'package:flutter/material.dart';

class HelpFrom extends StatelessWidget {
  const HelpFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
            const SizedBox(height: 8),
            _buildHelpCard(context, 'พบปัญหาเกี่ยวกับการแจ้งเตือน'),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับสร้างการ์ดช่วยเหลือแต่ละรายการ
  Widget _buildHelpCard(BuildContext context, String title) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: GestureDetector(
        onTap: () {},

        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black)),
          trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
        ),
      ),
    );
  }
}
