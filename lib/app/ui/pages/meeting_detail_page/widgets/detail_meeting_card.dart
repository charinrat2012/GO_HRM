import 'package:flutter/material.dart';

class DetailMeetingCard extends StatelessWidget {
  const DetailMeetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    // 3. ส่วนของ "ประเภทการเข้าประชุม"
    SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ประเภทการเข้าประชุม',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: Image.asset(
                    'assets/ics/meet.png',
                    height: 20,
                    width: 20,
                  ),
                  title: const Text(
                    'เข้าร่วมโดย Google Meet',
                    style: TextStyle(color: Colors.black, ),
                  ),
                  trailing: const Icon(Icons.link, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
