import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../news_controller.dart';

class SwitchLayout extends GetView<NewsController> {
  const SwitchLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('switch new layout =>', style: TextStyle(color: Colors.black)),
        SizedBox(width: 8.0),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 4.0, bottom: 4.0),
            child: FlutterSwitch(
              width: 45.0,
              height: 20.0,
              toggleSize: 20.0,
              value: controller.isSwitchedOn.value,
              borderRadius: 30.0,
              padding: 2.0,
              activeColor: Colors.green,
              inactiveColor: Colors.grey.shade400,
              onToggle: (val) {
                controller.toggleSwitch(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}