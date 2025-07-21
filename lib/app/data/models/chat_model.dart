import 'package:get/get.dart';

// Model สำหรับเก็บข้อมูลข้อความแต่ละข้อความ
class Message {
  final String senderName;
  final String senderImageUrl;
  final String? text;
  final String? imagePath;
  final String? filePath; // <-- เพิ่ม filePath สำหรับไฟล์ทั่วไป
  final String? fileName; // <-- เพิ่ม fileName สำหรับแสดงชื่อไฟล์
  final String time;
  final bool isMe;

  Message({
    required this.senderName,
    required this.senderImageUrl,
    this.text,
    this.imagePath,
    this.filePath,
    this.fileName,
    required this.time,
    this.isMe = false,
  }) : assert(text != null || imagePath != null || filePath != null, 
        'Message must have either text, an image, or a file.');
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
