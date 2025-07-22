import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/my_colors.dart';
import '../../../data/models/chat_model.dart';
import 'chats_controller.dart';

class ChatsPage extends GetView<ChatsController> {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: const Text(
              'แชท',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildSearchBar(),
              _buildFilterTabs(),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = controller.filteredChats[index];
                      return _buildChatListItem(chat);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Obx(
        () => Row(
          children: [
            _buildTabItem(text: 'ทั้งหมด', index: 0),
            _buildTabItem(text: 'ยังไม่อ่าน', index: 1),
            _buildTabItem(text: 'กลุ่ม', index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({required String text, required int index}) {
    final isSelected = controller.selectedTabIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? MyColors.blue2 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? MyColors.blue2 : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildChatListItem(Chat chat) {
    return InkWell(
      onTap: () => controller.goToChatDetail(chat),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(chat.imageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      chat.lastMessage.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    chat.time.value,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => chat.unreadCount.value > 0
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: MyColors.blue2,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount.value.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox(height: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
