import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import 'package:go_hrm/app/data/models/chat_model.dart';
import 'package:image_picker/image_picker.dart';
import 'chat_detail_controller.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatDetailPage extends GetView<ChatDetailController> {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () => Get.back(),
          ),
          title: Text(
            controller.chat.name,
            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.chat.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.chat.messages[index];
                    final bool showHeader = index == 0 ||
                        controller.chat.messages[index - 1].senderName != message.senderName;
                    return _buildMessageBubble(message, showHeader);
                  },
                ),
              ),
            ),
            _buildMessageInputField(),
            Obx(() => Offstage(
                  offstage: !controller.isEmojiPickerVisible.value,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      textEditingController: controller.messageController,
                      config: Config(
                        height: 250,
                        checkPlatformCompatibility: true,
                        emojiViewConfig: EmojiViewConfig(
                          emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
                          columns: 8,
                          backgroundColor: const Color(0xFFF2F2F2),
                        ),
                        // swapCategoryAndBottomBar: false,
                        skinToneConfig: const SkinToneConfig(),
                        categoryViewConfig: const CategoryViewConfig(),
                        bottomActionBarConfig: const BottomActionBarConfig(),
                        searchViewConfig: const SearchViewConfig(),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool showHeader) {
    final isMe = message.isMe;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (showHeader && !isMe && controller.chat.isGroup)
            Padding(
              padding: const EdgeInsets.only(left: 48.0, bottom: 4.0),
              child: Text(
                message.senderName,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                Visibility(
                  visible: showHeader,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(message.senderImageUrl),
                  ),
                ),
              if (!isMe) const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    _buildMessageContent(message),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        message.time,
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(Message message) {
    final isMe = message.isMe;
    final color = isMe ? MyColors.blue2 : Colors.white;
    final textColor = isMe ? Colors.white : Colors.black;

    if (message.imagePath != null) {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(message.imagePath!),
            width: 200,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (message.filePath != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insert_drive_file, color: textColor, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message.fileName ?? 'ไฟล์',
                style: TextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(
        message.text ?? '',
        style: TextStyle(color: textColor),
      ),
    );
  }


  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0)))
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.add, color: MyColors.blue2), onPressed: controller.showAttachmentOptions),
            IconButton(icon: const Icon(Icons.camera_alt_outlined, color: MyColors.blue2), onPressed: () => controller.pickImage(ImageSource.camera)),
            IconButton(icon: const Icon(Icons.image_outlined, color: MyColors.blue2), onPressed: () => controller.pickImage(ImageSource.gallery)),
            IconButton(icon: const Icon(Icons.mic_none, color: MyColors.blue2), onPressed: controller.handleMicrophone),
            Expanded(
              child: TextField(
                focusNode: controller.focusNode,
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'พิมพ์',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.toggleEmojiKeyboard,
                    icon: Obx(() => Icon(
                      controller.isEmojiPickerVisible.value ? Icons.keyboard : Icons.emoji_emotions_outlined,
                      color: Colors.grey.shade600,
                    )),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: MyColors.blue2),
              onPressed: controller.sendTextMessage,
            ),
          ],
        ),
      ),
    );
  }
}
