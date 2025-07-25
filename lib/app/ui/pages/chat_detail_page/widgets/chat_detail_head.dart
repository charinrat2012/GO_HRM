// Path: lib/app/ui/pages/chat_detail_page/widgets/chat_detail_head.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../chat_detail_controller.dart';

class ChatDetailHead extends GetView<ChatDetailController>
    implements PreferredSizeWidget {
  const ChatDetailHead({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text(
        controller.chat.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {Get.toNamed(AppRoutes.MENU_CHAT, arguments: controller.chat);}, // ส่งอ็อบเจกต์ chat ไปยัง MenuChatPage
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}