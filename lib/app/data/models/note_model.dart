import 'package:get/get.dart';

class NoteModel {
  final String id;
  final String senderId;
  final String senderName;
  final String senderImageUrl;
  final String title;
  final String content;
  final RxList<String> imagePaths;

  NoteModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImageUrl,
    required this.title,
    required this.content,
    required List<String> imagePaths,
  }) : imagePaths = imagePaths.obs;

  // เพิ่ม factory constructor สำหรับสร้าง Object จาก Map
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      senderImageUrl: map['senderImageUrl'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imagePaths: List<String>.from(map['imagePaths'] as List<dynamic>),
    );
  }

  // เพิ่มเมธอด toMap สำหรับแปลง Object เป็น Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderImageUrl': senderImageUrl,
      'title': title,
      'content': content,
      'imagePaths': imagePaths.toList(),
    };
  }

  NoteModel copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? senderImageUrl,
    String? title,
    String? content,
    List<String>? imagePaths,
  }) {
    return NoteModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderImageUrl: senderImageUrl ?? this.senderImageUrl,
      title: title ?? this.title,
      content: content ?? this.content,
      imagePaths: imagePaths ?? this.imagePaths.toList(),
    );
  }
}