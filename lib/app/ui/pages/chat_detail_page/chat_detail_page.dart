// ในไฟล์ lib/app/ui/pages/chat_detail_page/chat_detail_page.dart

import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart'; // เพิ่ม import นี้

import '../../../config/my_colors.dart';
import '../../../data/models/chat_model.dart';
import 'chat_detail_controller.dart';
import 'package:flutter/foundation.dart' as foundation;

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
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
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
                        final bool showHeader =
                            index == 0 ||
                            controller.chat.messages[index - 1].senderName !=
                                message.senderName;
                        return _buildMessageBubble(message, showHeader);
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

  Widget _buildMessageBubble(Message message, bool showHeader) {
    final isMe = message.isMe;
    // กำหนดว่าเวลาควรอยู่ด้านขวาของข้อความหรือไม่
    // isTimeOnRight จะเป็นจริงก็ต่อเมื่อไม่ใช่ข้อความของเรา (ขาเข้า)
    final bool isTimeOnRight = !isMe;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // *** ส่วนของชื่อผู้ส่ง (ถ้าไม่ใช่ข้อความของเรา และเป็นข้อความใหม่)
          // ชื่อจะอยู่เหนือกรอบข้อความและมี padding จากด้านซ้าย
          if (showHeader && !isMe && controller.chat.isGroup)
            Padding(
              padding: const EdgeInsets.only(left: 48.0, bottom: 4.0), // Padding เดิม
              child: Text(
                message.senderName, // ชื่อผู้ส่ง
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600, //สีหัวหน้า
                  fontWeight: FontWeight.bold, // เพิ่มให้ชื่อเด่นขึ้น
                ),
              ),
            ),
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.end, // จัดเรียงด้านล่างสุดของ Row นี้
            children: [
              // รูปโปรไฟล์ (ถ้าไม่ใช่ข้อความของเรา)
              if (!isMe)
                Visibility(
                  visible: showHeader,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: CircleAvatar(
                    // รูปโปรไฟล์
                    radius: 20,
                    backgroundImage: AssetImage(message.senderImageUrl),
                  ),
                ),
              // ระยะห่างระหว่างรูปโปรไฟล์กับเนื้อหาข้อความ
              if (!isMe) const SizedBox(width: 8),

              // เนื้อหาข้อความและเวลา (จัดเรียงใน Column)
              Flexible(
                child: Column(
                  crossAxisAlignment: isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    // Row สำหรับกรอบข้อความ + เวลา
                    Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment
                                .start, // จัดกรอบข้อความ+เวลาไปซ้าย/ขวา
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // จัดเรียงเวลาให้อยู่ด้านล่าง
                      mainAxisSize:
                          MainAxisSize.min, // ทำให้ Row นี้หดตามเนื้อหา
                      children: [
                        if (!isTimeOnRight) // ถ้าเวลาอยู่ซ้าย (ข้อความขาออก)
                          Text(
                            message.time, // แสดงเวลา
                            style: TextStyle(
                              color: Colors.grey.shade500, // สีเวลา
                              fontSize: 12,
                            ),
                          ),
                        if (!isTimeOnRight) // ระยะห่างถ้าเวลาอยู่ซ้าย
                          const SizedBox(width: 8),

                        _buildMessageContent(message), // กรอบข้อความ

                        if (isTimeOnRight) // ระยะห่างถ้าเวลาอยู่ขวา
                          const SizedBox(width: 8),
                        if (isTimeOnRight) // ถ้าเป็นข้อความขาเข้า (เวลาอยู่ขวา)
                          Text(
                            message.time, // แสดงเวลา
                            style: TextStyle(
                              color: Colors.grey.shade500, // สีเวลา
                              fontSize: 12,
                            ),
                          ),
                      ],
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

  // ตัวจัดการหลักที่ทำหน้าที่เลือก Widget ย่อยตามประเภทข้อความ
  Widget _buildMessageContent(Message message) {
    final isMe = message.isMe;
    final color = isMe
        ? MyColors.blue
        : Color.fromRGBO(
            213,
            243,
            246,
            0.573,
          ); //สีพื้นหลังเจ้าของแชต //สีพื้นหลังไฟล์เสียง
    final textColor = isMe
        ? Colors.white
        : Colors.black; //สีข้อความเจ้าของแชต //สีข้อความผู้ใช้

    // กำหนดความกว้างสูงสุดสำหรับแต่ละประเภทข้อความ (เป็น % ของหน้าจอ)
    final double imageMaxWidthFraction = 0.50; // สำหรับไฟล์รูปภาพ
    final double textMessageMaxWidthFraction = 0.7; // สำหรับไฟล์ข้อความ
    final double documentFileMaxWidthFraction = 0.8; // สำหรับไฟล์เอกสารทั่วไป
    final double audioFileFixedWidth = 160.0; //สำหรับกำหนดความกว้างไฟล์เสียง
    final double videoMessageFixedWidth = 250.0; // *** เพิ่มความกว้างตายตัวสำหรับวิดีโอ ***

    if (message.imagePath != null) {
      return _buildImageMessageContent(
        message,
        color,
        textColor,
        imageMaxWidthFraction,
      );
    } else if (message.filePath != null) {
      final bool isAudio =
          message.filePath!.toLowerCase().endsWith('.mp4') ||
          message.filePath!.toLowerCase().endsWith('.mp3');
      // *** ตรวจสอบว่าเป็นวิดีโอหรือไม่ (สมมติว่าเป็น .mp4 หรือ .mov) ***
      final bool isVideo = message.filePath!.toLowerCase().endsWith('.mp4') ||
                           message.filePath!.toLowerCase().endsWith('.mov');


      if (isAudio && !isVideo) { // เป็นเสียงแต่ไม่ใช่ "วิดีโอ"
        return _buildAudioMessageContent(
          message,
          color,
          textColor,
          audioFileFixedWidth,
        );
      } else if (isVideo) { // *** ถ้าเป็นวิดีโอ ***
        return _buildVideoMessageContent(
          message,
          color,
          textColor,
          videoMessageFixedWidth,
        );
      } else { // เป็นไฟล์เอกสารทั่วไป
        return _buildDocumentMessageContent(
          message,
          color,
          textColor,
          documentFileMaxWidthFraction,
        );
      }
    } else {
      return _buildTextMessageContent(
        message,
        color,
        textColor,
        textMessageMaxWidthFraction,
      );
    }
  }

  // Widget ย่อยสำหรับข้อความรูปภาพ
  Widget _buildImageMessageContent(
    Message message,
    Color color,
    Color textColor,
    double maxWidthFraction,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color.fromRGBO(204, 213, 246, 0.573), // แก้ไขสีให้เป็นสีเดียวกับด้านล่าง
        borderRadius: BorderRadius.circular(20), //ความมนกรอบ
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), //ความนนรูปภาพ
        child: message.imagePath!.startsWith('assets/')
            ? Image.asset(message.imagePath!, fit: BoxFit.cover)
            : Image.file(File(message.imagePath!), fit: BoxFit.cover),
      ),
    );
  }

  // Widget ย่อยสำหรับข้อความไฟล์เสียง
  Widget _buildAudioMessageContent(
    Message message,
    Color color,
    Color textColor,
    double fixedWidth,
  ) {
    return Container(
      width: fixedWidth, // ใช้ width ตายตัว
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.audiotrack, color: textColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message.fileName ?? 'ข้อความเสียง',
              style: TextStyle(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                message.isPlaying.value ? Icons.pause : Icons.play_arrow,
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

  // *** เปลี่ยน _buildVideoMessageContent เป็น StatefulWidget ***
  Widget _buildVideoMessageContent(
    Message message,
    Color color,
    Color textColor,
    double fixedWidth,
  ) {
    return _VideoMessageContentWidget( // ใช้ Widget ที่สร้างใหม่
      message: message,
      bubbleColor: color,
      textColor: textColor,
      fixedWidth: fixedWidth,
    );
  }

  // Widget ย่อยสำหรับข้อความไฟล์เอกสารทั่วไป (ที่ไม่ใช่เสียง)
  Widget _buildDocumentMessageContent(
    Message message,
    Color color,
    Color textColor,
    double maxWidthFraction,
  ) {
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

  // Widget ย่อยสำหรับข้อความปกติ
  Widget _buildTextMessageContent(
    Message message,
    Color color,
    Color textColor,
    double maxWidthFraction,
  ) {
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

// *** Widget ย่อยที่จัดการการแสดงผลและควบคุมวิดีโอ (StatefulWidget) ***
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
  State<_VideoMessageContentWidget> createState() => _VideoMessageContentWidgetState();
}

class _VideoMessageContentWidgetState extends State<_VideoMessageContentWidget> {
  late VideoPlayerController _videoController;
  bool _isPlaying = false; // สถานะการเล่นภายใน Widget นี้

  @override
  void initState() {
    super.initState();
    // ตรวจสอบว่า filePath เป็น assets หรือ file
    if (widget.message.filePath!.startsWith('assets/')) {
      _videoController = VideoPlayerController.asset(widget.message.filePath!);
    } else {
      _videoController = VideoPlayerController.file(File(widget.message.filePath!));
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
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, // ใช้ _isPlaying
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