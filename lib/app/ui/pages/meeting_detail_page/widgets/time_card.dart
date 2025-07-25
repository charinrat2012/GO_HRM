import 'package:flutter/material.dart';

import '../../../../config/my_colors.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // 4. ส่วนของ "เริ่มเวลา"
    SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'เริ่มเวลา',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color.fromRGBO(204, 218, 255, 1)),
              ),
              margin: EdgeInsets.zero,
              child: const ListTile(
                title: Text(
                  'เข้าร่วมการประชุมก่อน 10 นาที',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(Icons.notifications_none,  color: MyColors.blue,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
