import 'package:flutter/material.dart';

class ActivityBar extends StatelessWidget {
  const ActivityBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'กิจกรรม',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_horiz),
        onSelected: (String result) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'settings',
            child: Text('ตั้งค่า'),
          ),
        ],
      ),
    );
  }
}
