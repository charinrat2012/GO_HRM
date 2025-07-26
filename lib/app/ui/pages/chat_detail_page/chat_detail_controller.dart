// lib/app/ui/pages/chat_detail_page/chat_detail_controller.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../data/models/album_model.dart' as album_model show Album;
import '../../../data/models/chat_model.dart';


import '../chats_page/chats_controller.dart';
import 'package:intl/intl.dart'; // เพิ่ม import นี้
import '../../../data/services/auth_service.dart'; // เพิ่ม import นี้
import '../../../ui/utils/assets.dart'; // เพิ่ม import นี้

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

  final ChatsController _chatsController = Get.find<ChatsController>();

  // [เพิ่ม] RegExp สำหรับตรวจจับ URL
  final RegExp _linkRegex = RegExp(
    r'http[s]?:\/\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+',
    caseSensitive: false,
    multiLine: true,
  );

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
        final File videoFile = File(video.path);
        final int fileSizeInBytes = await videoFile.length();
        final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        const double maxAllowedSizeMB = 20.0;

        if (fileSizeInMB > maxAllowedSizeMB) {
          Get.snackbar(
            'วิดีโอมีขนาดใหญ่เกินไป',
            'ไม่สามารถส่งวิดีโอที่มีขนาดเกิน ${maxAllowedSizeMB.toStringAsFixed(0)} MB ได้',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

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
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'pdf',
          'doc',
          'docx',
          'xlsx',
          'pptx',
          'mp4',
          'mov',
          'webm',
        ],
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
      SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildListTileItem(
                icon: Icons.description,
                label: 'ไฟล์',
                onTap: () {
                  Get.back();
                  pickFile();
                },
              ),
              _buildListTileItem(
                icon: Icons.videocam,
                label: 'วิดีโอ',
                onTap: () {
                  Get.back();
                  pickVideo(ImageSource.gallery);
                },
              ),
              _buildListTileItem(
                icon: Icons.photo_album,
                label: 'สร้างอัลบั้ม',
                onTap: () {
                  Get.back();
                  showCreateAlbumDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCameraOptions() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildListTileItem(
                icon: Icons.camera_alt,
                label: 'ถ่ายรูป',
                onTap: () {
                  Get.back();
                  pickImage(ImageSource.camera);
                },
              ),
              _buildListTileItem(
                icon: Icons.videocam,
                label: 'ถ่ายวิดีโอ',
                onTap: () {
                  Get.back();
                  pickVideo(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New helper method for ListTile style
  Widget _buildListTileItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24, color: Colors.grey.shade700),
      title: Text(label),
      onTap: onTap, // onTap already includes Get.back() and action
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

  // แก้ไข _addMessage ให้รองรับ Album และเพิ่มรูปภาพ/วิดีโอ/ไฟล์ใน chat.imagePaths/videoPaths/fileMessages
  void _addMessage(Message message, {album_model.Album? album}) { // Correctly reference Album
    chat.messages.add(message);

    // [New Logic] Add image/video paths to chat's dedicated lists
    if (message.imagePath != null && !chat.imagePaths.contains(message.imagePath)) { // Avoid duplicates
      chat.imagePaths.add(message.imagePath!);
    } else if (message.filePath != null) {
      final bool isAudio = message.filePath!.toLowerCase().endsWith('.mp3');
      final bool isVideo = message.filePath!.toLowerCase().endsWith('.mp4') ||
                           message.filePath!.toLowerCase().endsWith('.mov') ||
                           message.filePath!.toLowerCase().endsWith('.webm');

      if (isVideo && !chat.videoPaths.contains(message.filePath)) { // Avoid duplicates
        chat.videoPaths.add(message.filePath!);
      } else {
        // [แก้ไข] สำหรับไฟล์ทั่วไปและไฟล์เสียงที่ไม่ได้เป็นวิดีโอ ให้เพิ่ม Message object ลงใน fileMessages
        // ตรวจสอบเพื่อหลีกเลี่ยงการเพิ่มซ้ำ
        if (!chat.fileMessages.any((msg) => msg.filePath == message.filePath)) {
          chat.fileMessages.add(message);
        }
      }
    }
    // [เพิ่ม] ตรวจสอบ Link ในข้อความที่เป็น text และเพิ่มลงใน chat.links
    if (message.text != null && message.text!.isNotEmpty) {
      _linkRegex.allMatches(message.text!).forEach((match) {
        final link = match.group(0)!;
        if (!chat.links.contains(link)) {
          chat.links.add(link);
        }
      });
    }

    // อัปเดต lastMessage ตามประเภทของข้อความ
    if (album != null) {
      chat.lastMessage.value = '[อัลบั้ม: ${album.name}]';
    } else if (message.text != null && message.text!.isNotEmpty) {
      chat.lastMessage.value = message.text!;
    } else if (message.imagePath != null) {
      chat.lastMessage.value = '[รูปภาพ]';
    } else if (message.filePath != null) {
      final String extension = message.fileName?.split('.').last.toLowerCase() ?? '';
      if (extension == 'mp4' || extension == 'mov' || extension == 'webm') {
         chat.lastMessage.value = '[วิดีโอ]';
      } else if (extension == 'mp3') {
         chat.lastMessage.value = '[ไฟล์เสียง]';
      } else if (extension == 'pdf') {
         chat.lastMessage.value = '[PDF]';
      } else if (extension == 'doc' || extension == 'docx') {
         chat.lastMessage.value = '[เอกสาร]';
      } else {
         chat.lastMessage.value = '[ไฟล์]';
      }
    }
    chat.time.value = DateFormat('HH:mm').format(DateTime.now()); // อัปเดตเวลาล่าสุด

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

  // เมธอดสำหรับแสดง Dialog เพื่อตั้งชื่ออัลบั้มใหม่
  void showCreateAlbumDialog() {
    final albumNameController = TextEditingController();
    // สร้าง FocusNode สำหรับ TextField
    final FocusNode albumNameFocusNode = FocusNode();

    Get.dialog(
      AlertDialog(
        title: const Text('สร้างอัลบั้มใหม่'),
        content: TextField(
          controller: albumNameController,
          focusNode: albumNameFocusNode, // กำหนด FocusNode ให้ TextField
          decoration: const InputDecoration(hintText: 'ชื่ออัลบั้ม'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('ยกเลิก')),
          ElevatedButton(
            onPressed: () {
              final albumName = albumNameController.text.trim();
              if (albumName.isNotEmpty) {
                Get.back(); // ปิด dialog ตั้งชื่อ
                pickImagesAndCreateAlbum(albumName); // เรียกฟังก์ชันเลือกรูปภาพ
              } else {
                Get.snackbar('ข้อผิดพลาด', 'กรุณาใส่ชื่ออัลบั้ม');
              }
            },
            child: const Text('สร้าง'),
          ),
        ],
      ),
    ).then((_) {
      // หลังจาก Dialog ปิดแล้ว ให้ dispose FocusNode เพื่อป้องกัน memory leak
      albumNameFocusNode.dispose();
    });

    // เพิ่มคำสั่งให้โฟกัสที่ TextField หลังจาก Dialog แสดงผล
    // ใช้ Future.delayed เพื่อให้แน่ใจว่า Dialog ได้ render ขึ้นมาก่อน
    Future.delayed(const Duration(milliseconds: 50), () {
      albumNameFocusNode.requestFocus();
    });
  }

  // เมธอดสำหรับเลือกรูปภาพจากแกลเลอรีและสร้างอัลบั้ม
  Future<void> pickImagesAndCreateAlbum(String albumName) async {
    try {
      final List<XFile> selectedImages = await _picker.pickMultiImage(
        imageQuality: 80, // คุณภาพรูปภาพ
      );

      if (selectedImages.isNotEmpty) {
        final List<String> imagePaths = selectedImages
            .map((xFile) => xFile.path)
            .toList();

        // สร้างอัลบั้มใหม่และเพิ่มเข้าไปใน chat.albums
        final newAlbum = album_model.Album(name: albumName, imagePaths: imagePaths); // Use aliased Album
        chat.albums.add(newAlbum);

        // เพิ่มข้อความอัลบั้มลงในแชท
        _addMessage(
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/profile.jpg',
            // ใช้รูปแรกของอัลบั้มเป็นภาพพรีวิว
            imagePath: imagePaths.isNotEmpty ? imagePaths.first : null,
            text: 'อัลบั้ม: $albumName', // แสดงชื่ออัลบั้มเป็นข้อความ
            time: _currentTime,
            isMe: true,
            album: newAlbum, // *** ส่ง object อัลบั้มไปด้วย ***
          ),
          album: newAlbum, // ส่ง object อัลบั้มไปด้วย
        );

        // Get.snackbar('สำเร็จ', 'สร้างอัลบั้ม "$albumName" และเพิ่มรูปภาพแล้ว!');
      } else {
        Get.snackbar('ข้อมูล', 'ไม่ได้เลือกรูปภาพใดๆ สำหรับอัลบั้ม');
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้: $e');
    }
  }
}