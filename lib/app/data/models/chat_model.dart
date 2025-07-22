import 'package:get/get.dart';

// Model สำหรับเก็บข้อมูลข้อความแต่ละข้อความ
class Message {
  final String senderName;
  final String senderImageUrl;
  final String? text;
  final String? imagePath;
  final String? filePath;
  final String? fileName;
  final String time;
  final bool isMe;
  final RxBool isPlaying; // เพิ่มบรรทัดนี้: สถานะการเล่นสำหรับข้อความเสียงแต่ละรายการ

  Message({
    required this.senderName,
    required this.senderImageUrl,
    this.text,
    this.imagePath,
    this.filePath,
    this.fileName,
    required this.time,
    this.isMe = false,
    bool isPlaying = false, // กำหนดค่าเริ่มต้นเป็น false
  }) : assert(text != null || imagePath != null || filePath != null,
        'Message must have either text, an image, or a file.'),
       isPlaying = isPlaying.obs; // ทำให้เป็น Observable

  // เพิ่ม copyWith สำหรับ Message (ถ้าคุณต้องการใช้ในอนาคตเพื่ออัปเดตสถานะ)
  Message copyWith({
    String? senderName,
    String? senderImageUrl,
    String? text,
    String? imagePath,
    String? filePath,
    String? fileName,
    String? time,
    bool? isMe,
    bool? isPlaying,
  }) {
    return Message(
      senderName: senderName ?? this.senderName,
      senderImageUrl: senderImageUrl ?? this.senderImageUrl,
      text: text ?? this.text,
      imagePath: imagePath ?? this.imagePath,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      time: time ?? this.time,
      isMe: isMe ?? this.isMe,
      isPlaying: isPlaying ?? this.isPlaying.value,
    );
  }
}

// Model สำหรับเก็บข้อมูลแชทแต่ละห้อง
class Chat {
  final String id;
  final String name;
  final String imageUrl;
  final bool isGroup;
  final RxString lastMessage;
  final RxString time;
  final RxInt unreadCount;
  final RxList<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isGroup = false,
    required String lastMessage,
    required String time,
    int unreadCount = 0,
    required List<Message> messages,
  })  : lastMessage = lastMessage.obs,
        time = time.obs,
        unreadCount = unreadCount.obs,
        messages = messages.obs;
}