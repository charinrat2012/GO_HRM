import 'package:flutter/material.dart';

class ListHead extends StatelessWidget {
  const ListHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'ทั้งหมด',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
