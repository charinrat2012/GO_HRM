import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/models/chat_model.dart';

class ChatDetailController extends GetxController {
  late final Chat chat;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final FocusNode focusNode = FocusNode();

  final RxBool isEmojiPickerVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    chat = Get.arguments as Chat;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isEmojiPickerVisible.value = false;
      }
    });
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
      return Future.value(false);
    }
    return Future.value(true);
  }

  void sendTextMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      _addMessage(Message(
        senderName: 'Me',
        senderImageUrl: 'assets/imgs/profile.jpg',
        text: text,
        time: _currentTime,
        isMe: true,
      ));
      messageController.clear();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);
      if (image != null) {
        _addMessage(Message(
          senderName: 'Me',
          senderImageUrl: 'assets/imgs/profile.jpg',
          imagePath: image.path,
          time: _currentTime,
          isMe: true,
        ));
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้');
    }
  }

  /// ฟังก์ชันสำหรับเลือกไฟล์จากในเครื่อง
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        _addMessage(Message(
          senderName: 'Me',
          senderImageUrl: 'assets/imgs/profile.jpg',
          filePath: file.path,
          fileName: file.name,
          time: _currentTime,
          isMe: true,
        ));
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกไฟล์ได้');
    }
  }

  /// ฟังก์ชันสำหรับจัดการปุ่มไมโครโฟน
  Future<void> handleMicrophone() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      Get.snackbar('ขออภัย', 'ฟังก์ชันบันทึกเสียงยังไม่เปิดใช้งาน');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Get.snackbar('การอนุญาต', 'จำเป็นต้องได้รับอนุญาตเพื่อใช้ไมโครโฟน');
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
            _buildBottomSheetItem(icon: Icons.description, label: 'ไฟล์', onTap: pickFile),
            _buildBottomSheetItem(icon: Icons.location_on, label: 'ตำแหน่ง', onTap: () => Get.snackbar('ขออภัย', 'ฟังก์ชันยังไม่เปิดใช้งาน')),
            _buildBottomSheetItem(icon: Icons.contact_page, label: 'รายชื่อ', onTap: () => Get.snackbar('ขออภัย', 'ฟังก์ชันยังไม่เปิดใช้งาน')),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem({required IconData icon, required String label, required VoidCallback onTap}) {
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
      chat.lastMessage.value = message.text ?? (message.imagePath != null ? '[รูปภาพ]' : '[ไฟล์]');
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

   @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
