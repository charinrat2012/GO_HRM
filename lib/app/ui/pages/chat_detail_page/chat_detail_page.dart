import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_detail_controller.dart';
import 'widgets/chat_detail_head.dart';
import 'widgets/chat_emoji_picker.dart';
import 'widgets/chat_message_input_field.dart';
import 'widgets/message_box.dart';

class ChatDetailPage extends GetView<ChatDetailController> {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          // ถ้า Emoji Picker กำลังแสดงอยู่ ให้ซ่อนมัน
          if (controller.isEmojiPickerVisible.value) {
            controller.isEmojiPickerVisible.value = false;
          }
          // จากนั้นให้ unfocus เพื่อซ่อนแป้นพิมพ์ปกติ (ถ้ามี)
          FocusScope.of(context).unfocus();
        },
        child: PopScope(
          canPop: true,
          child: Scaffold(
            backgroundColor: const Color(0xFFF0F4F8),
            appBar: ChatDetailHead(),
            body: Column(
              children: [
              
                 // <<< เปลี่ยนจากการเรียกเมธอดเป็น Widget
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: controller.chat.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.chat.messages[index];
                        final bool showHeader =
                            index == 0 ||
                            controller.chat.messages[index - 1].senderName !=
                                message.senderName;
                        return MessageBox(
                          message: message,
                          showHeader: showHeader,
                          isGroupChat: controller.chat.isGroup,
                        );
                      },
                    ),
                  ),
                ),
                ChatMessageInputField(),
                ChatEmojiPicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}