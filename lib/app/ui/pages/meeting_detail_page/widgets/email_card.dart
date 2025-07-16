import 'package:flutter/material.dart';

class EmailCard extends StatelessWidget {
  const EmailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    // 2. ส่วนของ "อีเมล"
    SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'อีเมล',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: Image.asset(
                  'assets/ics/email.png',
                  height: 20,
                  width: 20,
                ),
                title: const Text(
                  'Natthatoddrill@gmail.com',
                  style: TextStyle(color: Colors.black, ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
