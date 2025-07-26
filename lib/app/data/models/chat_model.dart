// lib/app/data/models/chat_model.dart
import 'package:get/get.dart';

import 'album_model.dart';
import 'note_model.dart';

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
  final RxBool isPlaying; // RxBool ถูกประกาศตรงนี้
  final Album? album;
  final NoteModel? note;

  Message({
    required this.senderName,
    required this.senderImageUrl,
    this.text,
    this.imagePath,
    this.filePath,
    this.fileName,
    required this.time,
    this.isMe = false,
    bool isPlaying = false, // พารามิเตอร์ constructor รับ bool ธรรมดา
    this.album,
    this.note,
  }) : assert(
         text != null ||
             imagePath != null ||
             filePath != null ||
             album != null ||
             note != null,
         'Message must have either text, an image, a file, an album, or a note.',
       ),
       isPlaying = isPlaying.obs; // แล้วค่อยแปลงเป็น RxBool ที่นี่

  // เพิ่ม factory constructor สำหรับสร้าง Object จาก Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderName: map['senderName'] as String,
      senderImageUrl: map['senderImageUrl'] as String,
      text: map['text'] as String?,
      imagePath: map['imagePath'] as String?,
      filePath: map['filePath'] as String?,
      fileName: map['fileName'] as String?,
      time: map['time'] as String,
      isMe: map['isMe'] as bool,
      isPlaying: map['isPlaying'] as bool, // แก้ไข: ส่ง bool ธรรมดา
      // สร้าง Album และ NoteModel จาก Map ถ้ามีข้อมูล
      album: map['album'] != null ? Album.fromMap(map['album'] as Map<String, dynamic>) : null,
      note: map['note'] != null ? NoteModel.fromMap(map['note'] as Map<String, dynamic>) : null,
    );
  }

  // เพิ่มเมธอด toMap สำหรับแปลง Object เป็น Map
  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'senderImageUrl': senderImageUrl,
      'text': text,
      'imagePath': imagePath,
      'filePath': filePath,
      'fileName': fileName,
      'time': time,
      'isMe': isMe,
      'isPlaying': isPlaying.value,
      // แปลง Album และ NoteModel เป็น Map ถ้ามี
      'album': album?.toMap(),
      'note': note?.toMap(),
    };
  }

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
    Album? album,
    NoteModel? note,
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
      album: album ?? this.album,
      note: note ?? this.note,
    );
  }
}

// Model สำหรับเก็บข้อมูลแชทแต่ละห้อง
class Chat {
  final String id;
  final String name;
  final String imageUrl;
  final bool isGroup;
  final RxString lastMessage; // RxString ถูกประกาศตรงนี้
  final RxString time; // RxString ถูกประกาศตรงนี้
  final RxInt unreadCount; // RxInt ถูกประกาศตรงนี้
  final RxList<Message> messages;
  final RxList<Album> albums;
  final RxList<NoteModel> notes;
  final RxList<String> imagePaths; // [เพิ่ม] List สำหรับเก็บ path รูปภาพ
  final RxList<String> videoPaths; // [เพิ่ม] List สำหรับเก็บ path วิดีโอ
  final RxList<Message> fileMessages; // [แก้ไข] เปลี่ยนจาก filePaths เป็น fileMessages
  final RxList<String> links; // [เพิ่ม] List สำหรับเก็บ Links


  Chat({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isGroup = false,
    required String lastMessage, // พารามิเตอร์ constructor รับ String ธรรมดา
    required String time, // พารามิเตอร์ constructor รับ String ธรรมดา
    int unreadCount = 0, // พารามิเตอร์ constructor รับ int ธรรมดา
    required List<Message> messages,
    List<Album>? albums,
    List<NoteModel>? notes,
    List<String>? imagePaths, // [เพิ่ม] พารามิเตอร์ constructor
    List<String>? videoPaths, // [เพิ่ม] พารามิเตอร์ constructor
    List<Message>? fileMessages, // [แก้ไข] พารามิเตอร์ constructor
    List<String>? links, // [เพิ่ม] พารามิเตอร์ constructor
  }) : lastMessage = lastMessage.obs, // แล้วค่อยแปลงเป็น RxString ที่นี่
       time = time.obs, // แล้วค่อยแปลงเป็น RxString ที่นี่
       unreadCount = unreadCount.obs, // แล้วค่อยแปลงเป็น RxInt ที่นี่
       messages = messages.obs,
       albums = (albums ?? []).obs,
       notes = (notes ?? []).obs,
       imagePaths = (imagePaths ?? []).obs, // [เพิ่ม] การเริ่มต้น
       videoPaths = (videoPaths ?? []).obs, // [เพิ่ม] การเริ่มต้น
       fileMessages = (fileMessages ?? []).obs, // [แก้ไข] การเริ่มต้น
       links = (links ?? []).obs; // [เพิ่ม] การเริ่มต้น


  // เพิ่ม factory constructor สำหรับสร้าง Object จาก Map
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      isGroup: map['isGroup'] as bool,
      lastMessage: map['lastMessage'] as String, // แก้ไข: ส่ง String ธรรมดา
      time: map['time'] as String, // แก้ไข: ส่ง String ธรรมดา
      unreadCount: map['unreadCount'] as int, // แก้ไข: ส่ง int ธรรมดา
      // แปลง List ของ Map เป็น List ของ Message objects
      messages: (map['messages'] as List<dynamic>)
          .map((msgMap) => Message.fromMap(msgMap as Map<String, dynamic>))
          .toList().obs,
      // แปลง List ของ Map เป็น List ของ Album objects
      albums: (map['albums'] as List<dynamic>?) // ใช้ ? เพื่อให้เป็น nullable
          ?.map((albumMap) => Album.fromMap(albumMap as Map<String, dynamic>))
          .toList().obs ?? <Album>[].obs, // จัดการกรณีที่เป็น null

      // แปลง List ของ Map เป็น List ของ NoteModel objects
      notes: (map['notes'] as List<dynamic>?) // ใช้ ? เพื่อให้เป็น nullable
          ?.map((noteMap) => NoteModel.fromMap(noteMap as Map<String, dynamic>))
          .toList().obs ?? <NoteModel>[].obs, // จัดการกรณีที่เป็น null

      imagePaths: (map['imagePaths'] as List<dynamic>?) // [เพิ่ม] การแปลงและจัดการ null
          ?.map((path) => path.toString())
          .toList().obs ?? <String>[].obs,

      videoPaths: (map['videoPaths'] as List<dynamic>?) // [เพิ่ม] การแปลงและจัดการ null
          ?.map((path) => path.toString())
          .toList().obs ?? <String>[].obs,
      fileMessages: (map['fileMessages'] as List<dynamic>?) // [แก้ไข] การแปลงและจัดการ null
          ?.map((msgMap) => Message.fromMap(msgMap as Map<String, dynamic>))
          .toList().obs ?? <Message>[].obs,
      links: (map['links'] as List<dynamic>?) // [เพิ่ม] การแปลงและจัดการ null
          ?.map((link) => link.toString())
          .toList().obs ?? <String>[].obs,
    );
  }

  // เพิ่มเมธอด toMap สำหรับแปลง Object เป็น Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'isGroup': isGroup,
      'lastMessage': lastMessage.value,
      'time': time.value,
      'unreadCount': unreadCount.value,
      // แปลง List ของ Message objects เป็น List ของ Map
      'messages': messages.map((msg) => msg.toMap()).toList(),
      // แปลง List ของ Album objects เป็น List ของ Map
      'albums': albums.map((album) => album.toMap()).toList(),
      // แปลง List ของ NoteModel objects เป็น List ของ Map
      'notes': notes.map((note) => note.toMap()).toList(),
      'imagePaths': imagePaths.toList(), // [เพิ่ม]
      'videoPaths': videoPaths.toList(), // [เพิ่ม]
      'fileMessages': fileMessages.map((msg) => msg.toMap()).toList(), // [แก้ไข]
      'links': links.toList(), // [เพิ่ม]
    };
  }
}