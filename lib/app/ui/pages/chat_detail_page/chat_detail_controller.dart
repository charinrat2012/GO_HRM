import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../data/models/chat_model.dart';
import '../chats_page/chats_controller.dart';
import 'dart:io'; // Import for File class

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
      return Future.value(true);
    }
    _chatsController.updateChatMessages(chat);
    return Future.value(true);
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
      if (source == ImageSource.gallery) {
        // Allow multiple image selection from gallery
        final List<XFile> images = await _picker.pickMultiImage(
          imageQuality: 70,
        );
        if (images.isNotEmpty) {
          for (final image in images) {
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
        }
      } else if (source == ImageSource.camera) {
        // For camera, still pick a single image
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
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้');
    }
  }

  Future<void> pickVideo(ImageSource source) async {
    try {
      final XFile? video = await _picker.pickVideo(source: source);
      if (video != null) {
        // --- ส่วนที่เพิ่มเข้ามา: ตรวจสอบขนาดไฟล์วิดีโอ ---
        final File videoFile = File(video.path);
        final int fileSizeInBytes = await videoFile.length();
        final double fileSizeInMB = fileSizeInBytes / (1024 * 1024); // แปลงเป็น MB
        const double maxAllowedSizeMB = 20.0; // กำหนดขนาดสูงสุดที่อนุญาต (เช่น 50 MB)

        if (fileSizeInMB > maxAllowedSizeMB) {
          Get.snackbar(
            'วิดีโอมีขนาดใหญ่เกินไป',
            'ไม่สามารถส่งวิดีโอที่มีขนาดเกิน ${maxAllowedSizeMB.toStringAsFixed(0)} MB ได้',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return; // หยุดการทำงานถ้าไฟล์ใหญ่เกิน
        }
        // --- สิ้นสุดส่วนที่เพิ่มเข้ามา ---

        _addMessage(
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/profile.jpg',
            filePath: video.path,
            fileName: video.name,
            time: _currentTime,
            isMe: true,
          ),
        );
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกวิดีโอได้: $e');
    }
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xlsx', 'pptx', 'mp4', 'mov', 'webm'],
      );
      if (result != null && result.files.isNotEmpty) {
        for (final filePlatform in result.files) {
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
              fileName: 'Sound_5896559.mp3',
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
              icon: Icons.videocam, // นี่คือบรรทัดที่เพิ่มเข้ามาสำหรับปุ่มวิดีโอ
              label: 'วิดีโอ', // นี่คือบรรทัดที่เพิ่มเข้ามาสำหรับปุ่มวิดีโอ
              onTap: () => pickVideo(ImageSource.gallery), // นี่คือบรรทัดที่เพิ่มเข้ามาสำหรับปุ่มวิดีโอ
            ),
          
          ],
        ),
      ),
    );
  }

  void showCameraOptions() {
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
              icon: Icons.camera_alt,
              label: 'ถ่ายรูป',
              onTap: () => pickImage(ImageSource.camera),
            ),
            _buildBottomSheetItem(
              icon: Icons.videocam,
              label: 'ถ่ายวิดีโอ',
              onTap: () => pickVideo(ImageSource.camera),
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
    chat.messages.add(message);
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