import 'package:flutter/material.dart';

class CurrentCard extends StatelessWidget {
  const CurrentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: _buildSalaryCard(
          month: 'มิถุนายน',
          payDate: 'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
          icon: Icons.arrow_forward_ios,
          onTap: () {
            // ใส่การทำงานตอนกด
          },
        ),
      ),
    );
  }

  Widget _buildSalaryCard({
    required String month,
    required String payDate,
    IconData icon = Icons.arrow_forward_ios,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          // height: 80,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    month,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    payDate,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
              Icon(icon, size: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
