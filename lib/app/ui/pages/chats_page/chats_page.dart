import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chats_controller.dart';
import 'widgets/chats_head.dart';
import 'widgets/filter_tabs.dart';
import 'widgets/list_Item.dart';
import 'widgets/search_button.dart';

class ChatsPage extends GetView<ChatsController> {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: ChatsHead(),
          body: Column(children: [SearchButton(), FilterTabs(), ListItem()]),
        ),
      ),
    );
  }
}
