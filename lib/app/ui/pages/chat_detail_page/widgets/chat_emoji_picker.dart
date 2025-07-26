import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../chat_detail_controller.dart';

class ChatEmojiPicker extends GetView<ChatDetailController> {
  const ChatEmojiPicker({super.key});
//ตัวเลือกอีโมจิ
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Offstage(
        offstage: !controller.isEmojiPickerVisible.value,
        child: SizedBox(
          height: 250,
          child: EmojiPicker(
            textEditingController: controller.messageController,
            config: Config(
              height: 200,
              checkPlatformCompatibility: true,
              emojiViewConfig: EmojiViewConfig(
                emojiSizeMax:
                    28 *
                    (foundation.defaultTargetPlatform ==
                            TargetPlatform.iOS
                        ? 1.20
                        : 1.0),
                columns: 8,
                backgroundColor: const Color(0xFFF2F2F2),
              ),
              skinToneConfig: const SkinToneConfig(),
              categoryViewConfig: const CategoryViewConfig(),
              bottomActionBarConfig: const BottomActionBarConfig(
                  showBackspaceButton: false,
                  showSearchViewButton: false,
                  enabled: false),
              searchViewConfig: const SearchViewConfig(),
            ),
          ),
        ),
      ),
    );
  }
}