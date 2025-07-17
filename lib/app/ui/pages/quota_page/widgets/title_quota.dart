import 'package:flutter/material.dart';

class TitleQuota extends StatelessWidget {
  const TitleQuota({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Text(
        'โควต้าการลา',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
