import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chats_controller.dart';

class SearchButton extends GetView<ChatsController> {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSearchBar();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: CupertinoSearchTextField(
        controller: controller.searchController,
        placeholder: 'ค้นหา',
        backgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
