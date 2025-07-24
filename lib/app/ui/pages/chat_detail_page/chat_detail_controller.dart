import 'package:file_picker/file_picker.dart'; // ตรวจสอบว่ามี import นี้แล้ว
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../data/models/chat_model.dart';
import '../chats_page/chats_controller.dart';

class ChatDetailController extends GetxController {
  late final Chat chat;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final FocusNode focusNode = FocusNode();
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Message? _currentPlayingMessage;

  String? _audioPath;

  final RxBool isEmojiPickerVisible = false.obs;
  final RxBool isRecording = false.obs;

  // เพิ่มตัวแปรสำหรับ ChatsController
  final ChatsController _chatsController = Get.find<ChatsController>();

  @override
  void onInit() {
    super.onInit();
    // รับ chat object จาก arguments
    chat = Get.arguments as Chat;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isEmojiPickerVisible.value = false;
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed ||
          state == PlayerState.stopped ||
          state == PlayerState.paused) {
        if (_currentPlayingMessage != null) {
          _currentPlayingMessage!.isPlaying.value = false;
          _currentPlayingMessage = null;
        }
      }
    });
  }

  @override
  void onClose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    messageController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void toggleEmojiKeyboard() {
    if (isEmojiPickerVisible.value) {
      isEmojiPickerVisible.value = false;
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      isEmojiPickerVisible.value = true;
    }
  }

  Future<bool> onWillPop() {
    if (isEmojiPickerVisible.value) {
      isEmojiPickerVisible.value = false;
      return Future.value(true); // อนุญาตให้ย้อนกลับ
    }
    // เมื่อกดปุ่มย้อนกลับ ให้บันทึกการเปลี่ยนแปลงของ chat object กลับไปยัง ChatsController
    _chatsController.updateChatMessages(chat);
    return Future.value(true); // อนุญาตให้ย้อนกลับ
  }

  void sendTextMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      _addMessage(
        Message(
          senderName: 'Me',
          senderImageUrl: 'assets/imgs/profile.jpg',
          text: text,
          time: _currentTime,
          isMe: true,
        ),
      );
      messageController.clear();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (image != null) {
        _addMessage(
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/profile.jpg',
            imagePath: image.path,
            time: _currentTime,
            isMe: true,
          ),
        );
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้');
    }
  }

  // *** เมธอดใหม่สำหรับเลือก/บันทึกวิดีโอ ***
  Future<void> pickVideo(ImageSource source) async {
    try {
      final XFile? video = await _picker.pickVideo(source: source);
      if (video != null) {
        _addMessage(
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/profile.jpg',
            filePath: video.path, // ใช้ filePath สำหรับวิดีโอ
            fileName: video.name, // ชื่อไฟล์วิดีโอ
            time: _currentTime,
            isMe: true,
          ),
        );
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกวิดีโอได้: $e');
    }
  }

  // **** แก้ไขเมธอด pickFile() ที่นี่ ****
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true, // เพิ่มบรรทัดนี้เพื่ออนุญาตให้เลือกหลายไฟล์
        type: FileType.custom, // กำหนดประเภทไฟล์ (ถ้าต้องการ)
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xlsx', 'pptx'], // เพิ่มนามสกุลที่ต้องการ
      );
      if (result != null && result.files.isNotEmpty) { // ตรวจสอบว่ามีไฟล์ถูกเลือกหรือไม่
        for (final filePlatform in result.files) { // วนลูปเพื่อเพิ่มไฟล์แต่ละไฟล์
          if (filePlatform.path != null) {
            _addMessage(
              Message(
                senderName: 'Me',
                senderImageUrl: 'assets/imgs/profile.jpg',
                filePath: filePlatform.path,
                fileName: filePlatform.name,
                time: _currentTime,
                isMe: true,
              ),
            );
          }
        }
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกไฟล์ได้: $e');
    }
  }

  Future<void> handleMicrophone() async {
    if (await _audioRecorder.hasPermission()) {
      if (isRecording.value) {
        final path = await _audioRecorder.stop();
        isRecording.value = false;
        if (path != null) {
          _addMessage(
            Message(
              senderName: 'Me',
              senderImageUrl: 'assets/imgs/profile.jpg',
              filePath: path,
              fileName: 'voice_5896559.mp3',
              time: _currentTime,
              isMe: true,
            ),
          );
          _audioPath = null;
        } else {
          // Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถหยุดบันทึกเสียงได้');
        }
      } else {
        try {
          final directory = await getApplicationDocumentsDirectory();
          final path =
              '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.mp4';
          await _audioRecorder.start(
            RecordConfig(encoder: AudioEncoder.aacLc),
            path: path,
          );
          isRecording.value = true;
          _audioPath = path;
          // Get.snackbar('บันทึกเสียง', 'เริ่มบันทึกเสียงแล้ว...');
        } catch (e) {
          Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเริ่มบันทึกเสียงได้: $e');
        }
      }
    } else {
      Get.snackbar('การอนุญาต', 'จำเป็นต้องได้รับอนุญาตเพื่อใช้ไมโครโฟน');
      openAppSettings();
    }
  }

  Future<void> playAudio(Message message) async {
    if (_currentPlayingMessage != null && _currentPlayingMessage != message) {
      _currentPlayingMessage!.isPlaying.value = false;
      await _audioPlayer.stop();
    }

    if (message.isPlaying.value) {
      await _audioPlayer.pause();
      message.isPlaying.value = false;
      _currentPlayingMessage = null;
    } else {
      try {
        await _audioPlayer.play(DeviceFileSource(message.filePath!));
        message.isPlaying.value = true;
        _currentPlayingMessage = message;
      } catch (e) {
        Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถเล่นไฟล์เสียงได้: $e');
        message.isPlaying.value = false;
        _currentPlayingMessage = null;
      }
    }
  }

  void showAttachmentOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildBottomSheetItem(
              icon: Icons.description,
              label: 'ไฟล์',
              onTap: pickFile,
            ),
            _buildBottomSheetItem(
              icon: Icons.location_on,
              label: 'ตำแหน่ง',
              onTap: () => Get.snackbar('ขออภัย', 'ฟังก์ชันยังไม่เปิดใช้งาน'),
            ),
            _buildBottomSheetItem(
              icon: Icons.contact_page,
              label: 'รายชื่อ',
              onTap: () => Get.snackbar('ขออภัย', 'ฟังก์ชันยังไม่เปิดใช้งาน'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Get.back();
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, size: 28, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  void _addMessage(Message message) {
    // เพิ่มข้อความลงใน List ใน Chat object ปัจจุบัน
    chat.messages.add(message);

    // อัปเดต lastMessage และ time ใน Chat object
    chat.lastMessage.value =
        message.text ?? (message.imagePath != null ? '[รูปภาพ]' : '[ไฟล์]');
    chat.time.value = message.time;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String get _currentTime {
    final now = TimeOfDay.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }
}