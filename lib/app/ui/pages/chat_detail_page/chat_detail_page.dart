import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../config/my_colors.dart';
import '../../../data/models/chat_model.dart';
import 'chat_detail_controller.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'widgets/chat_detail_head.dart';

class ChatDetailPage extends GetView<ChatDetailController> {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: PopScope(
          // onWillPop: controller.onWillPop,
          // onWillPop: () => controller.onWillPop(),
          child: Scaffold(
            backgroundColor: const Color(0xFFF0F4F8),
            appBar: ChatDetailHead(),
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
                        final bool showHeader =
                            index == 0 ||
                            controller.chat.messages[index - 1].senderName !=
                                message.senderName;
                        return _MessageBubble(
                            message: message,
                            showHeader: showHeader,
                            isGroupChat: controller.chat.isGroup);
                      },
                    ),
                  ),
                ), 
                _buildMessageInputField(),
                Obx(
                  () => Offstage(
                    offstage: !controller.isEmojiPickerVisible.value,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        textEditingController: controller.messageController,
                        config: Config(
                          height: 250,
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

                          // swapCategoryAndBottomBar: false,
                          skinToneConfig: const SkinToneConfig(),
                          categoryViewConfig: const CategoryViewConfig(),
                          bottomActionBarConfig: const BottomActionBarConfig(),
                          searchViewConfig: const SearchViewConfig(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ส่วนของแถบส่งข้อความ
  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: MyColors.blue2, size: 22),
              onPressed: controller.showAttachmentOptions,
              style: ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: MyColors.blue2,
                size: 22,
              ),
              onPressed: () => controller.pickImage(ImageSource.camera),
              style: ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            IconButton(
              icon: const Icon(
                Icons.image_outlined,
                color: MyColors.blue2,
                size: 22,
              ),
              onPressed: () => controller.pickImage(ImageSource.gallery),
              style: ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.isRecording.value
                      ? Icons.stop_circle
                      : Icons.mic_none,
                  color: controller.isRecording.value
                      ? Colors.red
                      : MyColors.blue2,
                  size: 22,
                ),
                onPressed: controller.handleMicrophone,
                style: ButtonStyle(visualDensity: VisualDensity.compact),
              ),
            ),
            Expanded(
              child: TextField(
                // style: const TextStyle(fontSize: 14),
                focusNode: controller.focusNode,
                controller: controller.messageController,

                decoration: InputDecoration(
                  hintText: 'พิมพ์',

                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(204, 218, 255, 1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(204, 218, 255, 1),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(204, 218, 255, 1),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.toggleEmojiKeyboard,
                    icon: Obx(
                      () => Icon(
                        controller.isEmojiPickerVisible.value
                            ? Icons.keyboard
                            : Icons.emoji_emotions_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: MyColors.blue2, size: 22),
              onPressed: controller.sendTextMessage,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget ใหม่สำหรับ Message Bubble
class _MessageBubble extends GetView<ChatDetailController> {
  final Message message;
  final bool showHeader;
  final bool isGroupChat;

  const _MessageBubble({
    required this.message,
    required this.showHeader,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final bool isTimeOnRight = !isMe; // เวลาจะอยู่ด้านขวาของข้อความขาเข้า

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (showHeader && !isMe && isGroupChat)
            Padding(
              padding: const EdgeInsets.only(left: 48.0, bottom: 4.0),
              child: Text(
                message.senderName,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isTimeOnRight) ...[
                      Text(
                        message.time,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    _MessageContent(message: message), // ใช้ Widget ใหม่
                    if (isTimeOnRight) ...[
                      const SizedBox(width: 8),
                      Text(
                        message.time,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget ใหม่สำหรับแสดงเนื้อหาข้อความประเภทต่างๆ
class _MessageContent extends GetView<ChatDetailController> {
  final Message message;

  const _MessageContent({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final Color bubbleColor = isMe
        ? MyColors.blue
        : Color.fromRGBO(213, 243, 246, 0.573);
    final Color textColor = isMe ? Colors.white : Colors.black;

    // กำหนดความกว้างสูงสุดสำหรับแต่ละประเภทข้อความ (เป็น % ของหน้าจอ)
    final double imageMaxWidthFraction = 0.50;
    final double textMessageMaxWidthFraction = 0.7;
    final double documentFileMaxWidthFraction = 0.8;
    final double audioFileFixedWidth =180.0; // Adjusted fixed width
    final double videoMessageFixedWidth = 250.0;

    if (message.imagePath != null) {
      return _buildImageMessageContent(
          message, bubbleColor, imageMaxWidthFraction);
    } else if (message.filePath != null) {
      final bool isAudio = message.filePath!.toLowerCase().endsWith('.mp4') || 
          message.filePath!.toLowerCase().endsWith('.mp3');
      final bool isVideo = message.filePath!.toLowerCase().endsWith('.mp4') ||
          message.filePath!.toLowerCase().endsWith('.mov'); // เพิ่ม .mov

      if (isAudio && !isVideo) {
        // โค้ดสำหรับไฟล์เสียง
        return Container(
          width: audioFileFixedWidth, // Using the new fixed width
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.audiotrack, color: textColor, size: 16),
              const SizedBox(width: 8),
              Flexible( // Changed from Expanded to Flexible
                child: Text(
                  message.fileName ?? 'ข้อความเสียง',
                  style: TextStyle(color: textColor, fontSize: 10), // ลดขนาด font
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Obx(
                () => IconButton(
                  icon: Icon(
                    message.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    size: 16, // ลดขนาด icon ปุ่มเล่น
                    color: textColor,
                  ),
                  onPressed: () {
                    controller.playAudio(message);
                  },
                ),
              ),
            ],
          ),
        );
      } else if (isVideo) {
        // โค้ดสำหรับวิดีโอ (ยังคงเป็น Widget แยก)
        return _VideoMessageContentWidget(
            message: message,
            bubbleColor: bubbleColor,
            textColor: textColor,
            fixedWidth: videoMessageFixedWidth);
      } else {
        // โค้ดสำหรับไฟล์เอกสารทั่วไป
        return Container(
          constraints: BoxConstraints(maxWidth: Get.width * documentFileMaxWidthFraction),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.insert_drive_file, color: textColor, size: 20),
              const SizedBox(width: 8),
              Flexible( // Also make this Flexible for consistency
                child: Text(
                  message.fileName ?? 'ไฟล์เอกสาร',
                  style: TextStyle(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }
    } else if (message.text != null) {
      // โค้ดสำหรับข้อความธรรมดา
      return Container(
        constraints: BoxConstraints(maxWidth: Get.width * textMessageMaxWidthFraction),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(message.text ?? '', style: TextStyle(color: textColor)),
      );
    } else {
      return const SizedBox.shrink(); // กรณีไม่มี content
    }
  }

  Widget _buildImageMessageContent(
      Message message, Color color, double maxWidthFraction) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color.fromRGBO(204, 213, 246, 0.573),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: message.imagePath!.startsWith('assets/')
            ? Image.asset(message.imagePath!, fit: BoxFit.cover)
            : Image.file(File(message.imagePath!), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildAudioMessageContent(
      Message message, Color color, Color textColor, double fixedWidth) {
    return Container(
      width: fixedWidth,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.audiotrack, color: textColor, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message.fileName ?? 'ข้อความเสียง',
              style: TextStyle(color: textColor, fontSize: 10), // ลดขนาด font
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                message.isPlaying.value ? Icons.pause : Icons.play_arrow,
                size: 16, // ลดขนาด icon ปุ่มเล่น
                color: textColor,
              ),
              onPressed: () {
                controller.playAudio(message);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentMessageContent(
      Message message, Color color, Color textColor, double maxWidthFraction) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.insert_drive_file, color: textColor, size: 20),
          const SizedBox(width: 8),
          Flexible(
                child: Text(
                  message.fileName ?? 'ไฟล์เอกสาร',
                  style: TextStyle(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
  }

  Widget _buildTextMessageContent(
      Message message, Color color, Color textColor, double maxWidthFraction) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(message.text ?? '', style: TextStyle(color: textColor)),
    );
  }
}

// Widget ย่อยที่จัดการการแสดงผลและควบคุมวิดีโอ (StatefulWidget)
class _VideoMessageContentWidget extends StatefulWidget {
  final Message message;
  final Color bubbleColor;
  final Color textColor;
  final double fixedWidth;

  const _VideoMessageContentWidget({
    required this.message,
    required this.bubbleColor,
    required this.textColor,
    required this.fixedWidth,
  });

  @override
  State<_VideoMessageContentWidget> createState() =>
      _VideoMessageContentWidgetState();
}

class _VideoMessageContentWidgetState
    extends State<_VideoMessageContentWidget> {
  late VideoPlayerController _videoController;
  bool _isPlaying = false; // สถานะการเล่นภายใน Widget นี้

  @override
  void initState() {
    super.initState();
    // ตรวจสอบว่า filePath เป็น assets หรือ file
    if (widget.message.filePath!.startsWith('assets/')) {
      _videoController = VideoPlayerController.asset(widget.message.filePath!);
    } else {
      _videoController = VideoPlayerController.file(
        File(widget.message.filePath!),
      );
    }

    _videoController.initialize().then((_) {
      setState(() {}); // เมื่อ initialize เสร็จสิ้น ให้ rebuild UI
    });

    // Listener สำหรับอัปเดตสถานะปุ่ม Play/Pause
    _videoController.addListener(() {
      if (_isPlaying != _videoController.value.isPlaying) {
        setState(() {
          _isPlaying = _videoController.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose(); // สำคัญมาก: ต้อง dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fixedWidth, // ความกว้างตายตัวสำหรับวิดีโอ
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: widget.bubbleColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_videoController.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            )
          else
            Container(
              height: widget.fixedWidth * (9 / 16), // สัดส่วน 16:9 เป็นมาตรฐาน
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(color: widget.textColor),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.message.fileName ?? 'วิดีโอ',
                  style: TextStyle(color: widget.textColor, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill, // ใช้ _isPlaying
                    color: widget.textColor,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    } else {
                      _videoController.play();
                    }
                    // ไม่ต้อง setState ตรงนี้ เพราะ listener จะเรียก setState เอง
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}