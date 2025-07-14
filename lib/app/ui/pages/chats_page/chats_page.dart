import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chats_controller.dart';

class ChatsPage extends GetView<ChatsController> {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: Center(child: Text('Chats')),
    );
  }
}
