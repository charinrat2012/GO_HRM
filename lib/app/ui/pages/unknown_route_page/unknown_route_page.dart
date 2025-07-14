import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'unknown_route_controller.dart';

class UnknownRoutePage extends GetView<UnknownRouteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UnknownRoute')),
      body: Center(child: Text('UnknownRoute')),
    );
  }
}
