import 'package:flutter/material.dart';

import '../../../../config/my_colors.dart';

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
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color.fromRGBO(204, 218, 255, 1) )  
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
                  trailing: const Icon(Icons.link,   color: MyColors.blue,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
