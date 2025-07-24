import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../news_controller.dart';

class ActivityBar extends GetView<NewsController> {
  const ActivityBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isSwitchedOn.value == true

    ?ListTile(
      title: const Text(
        'ฟีดข่าว',
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
    )
    :ListTile(
      title: const Text(
        'กิจกรรม',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      trailing: PopupMenuButton<String>(
         position:  PopupMenuPosition.under,
        icon: const Icon(Icons.more_horiz),
        onSelected: (String result) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'settings',
            child: Text('ตั้งค่า'),
          ),
        ],
      ),
    )
    );
  }
}