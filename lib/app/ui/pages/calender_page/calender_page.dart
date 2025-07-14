import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calender_controller.dart';

class CalenderPage extends GetView<CalenderController> {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('calender')),
      body: Center(child: Text('calender')),
    );
  }
}
