import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'ข่าวด่วน',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      trailing: PopupMenuButton<String>(
         position:  PopupMenuPosition.under,
        icon: const Icon(Icons.more_vert),
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
