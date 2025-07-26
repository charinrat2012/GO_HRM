// Path: lib/app/ui/pages/chat_detail_page/widgets/chat_message_content.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../data/models/chat_model.dart';
import '../../../../routes/app_routes.dart';
import '../chat_detail_controller.dart';
import 'chat_video_message_content.dart';
import 'package:go_hrm/app/data/models/note_model.dart'; // Import NoteModel
import 'package:go_hrm/app/data/models/album_model.dart'; // Import AlbumModel (ถ้ายังไม่มี)

class ChatMessageContent extends GetView<ChatDetailController> {
  final Message message;

  const ChatMessageContent({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final Color bubbleColor = isMe
        ? MyColors.blue // สีกรอบอัลบั้ม แชตของตัวเอง
        : const Color.fromRGBO(213, 243, 246, 0.573);
    final Color textColor = isMe ? Colors.white : Colors.black;

    final double imageMaxWidthFraction = 0.50;
    final double textMessageMaxWidthFraction = 0.7;
    final double documentFileMaxWidthFraction = 0.8;
    final double audioFileFixedWidth = 70.0;
    final double videoMessageFixedWidth = 250.0;

    // ตรวจสอบ Note ก่อนประเภทอื่นๆ
    if (message.note != null) {
      return _buildNoteMessageContent(
        message.note!, // ส่ง NoteModel ไป
        bubbleColor,
        textColor,
        imageMaxWidthFraction,
      );
    }
    // ตรวจสอบ Album
    else if (message.album != null) {
      return _buildAlbumMessageContent(
        message, // ส่ง Message object ไป
        bubbleColor,
        imageMaxWidthFraction,
      );
    } else if (message.imagePath != null) {
      return _buildImageMessageContent(
        message,
        bubbleColor,
        imageMaxWidthFraction,
      );
    } else if (message.filePath != null) {
      final bool isAudio = message.filePath!.toLowerCase().endsWith('.mp3');
      final bool isVideo = message.filePath!.toLowerCase().endsWith('.mp4') ||
          message.filePath!.toLowerCase().endsWith('.mov') ||
          message.filePath!.toLowerCase().endsWith('.webm');

      if (isAudio && !isVideo) {
        return _buildAudioMessageContent(
          message,
          bubbleColor,
          textColor,
          audioFileFixedWidth,
        );
      } else if (isVideo) {
        return ChatVideoMessageContent(
          message: message,
          bubbleColor: bubbleColor,
          textColor: textColor,
          fixedWidth: videoMessageFixedWidth,
        );
      } else {
        return _buildDocumentMessageContent(
          message,
          bubbleColor,
          textColor,
          documentFileMaxWidthFraction,
        );
      }
    } else if (message.text != null) {
      return _buildTextMessageContent(
        message,
        bubbleColor,
        textColor,
        textMessageMaxWidthFraction,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // เมธอดสำหรับแสดงผลข้อความ Note (คล้าย Album)
  Widget _buildNoteMessageContent(
    NoteModel note, // รับ NoteModel โดยตรง
    Color bubbleColor,
    Color textColor,
    double maxWidthFraction,
  ) {
    final Color cardBorderColor = Color.fromRGBO(204, 218, 255, 1); // สีขอบการ์ด
    final Color cardBackgroundColor =
        bubbleColor.withOpacity(0.7); // สีพื้นหลังการ์ด

    return GestureDetector(
      onTap: () {
        // เมื่อแตะ จะนำทางไป NoteDetailPage
        Get.toNamed(AppRoutes.NOTE_DETAIL, arguments: {'note': note});
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cardBorderColor, width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // แก้ไข: เพิ่มบรรทัดนี้
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงรูปภาพแรกของโน้ตเป็น thumbnail (ถ้ามี)
            if (note.imagePaths.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: note.imagePaths.first.startsWith('assets/')
                      ? Image.asset(
                          note.imagePaths.first,
                          fit: BoxFit.cover,
                          width: double.infinity, // ใช้ double.infinity เพื่อให้รูปภาพกว้างเต็มพื้นที่ภายใน Container
                          height: Get.width * (maxWidthFraction - 0.1) * 0.75, // อัตราส่วน
                        )
                      : Image.file(
                          File(note.imagePaths.first),
                          fit: BoxFit.cover,
                          width: double.infinity, // ใช้ double.infinity
                          height: Get.width * (maxWidthFraction - 0.1) * 0.75,
                        ),
                ),
              ),
            // ชื่อโน้ต
            // ใช้ Expanded เพื่อให้ข้อความตัด ... ถ้าชื่อยาวเกิน
            Text( // แก้ไข: ลบ Expanded ออก
              'โน้ต: ${note.title}', // เพิ่ม 'โน้ต: '
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // เนื้อหาโน้ต (ย่อ)
            if (note.content.isNotEmpty)
              Text( // แก้ไข: ลบ Expanded ออก
                note.content,
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                ),
                maxLines: 1, // แสดงเนื้อหาเพียงบรรทัดเดียว
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  // เมธอดสำหรับแสดงผลข้อความ Album
  Widget _buildAlbumMessageContent(
    Message message,
    Color color,
    double maxWidthFraction,
  ) {
    final Color borderColor =
        message.isMe ? Color.fromRGBO(204, 218, 255, 1): Colors.grey.shade400; // สีขอบ
    final Color albumTextColor = message.isMe ? Colors.white : Colors.black; // สีข้อความ

    return GestureDetector(
      onTap: () {
        // เมื่อแตะอัลบั้ม ให้ไปหน้า AllAlbumsPage และส่ง Album object ของ Message นั้นไป
        Get.toNamed(AppRoutes.ALL_ALBUMS, arguments: message.album); // <<< ส่ง message.album ที่นี่
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.7), // เพิ่มความโปร่งแสงเล็กน้อย
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // แก้ไข: เพิ่มบรรทัดนี้
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: message.imagePath!.startsWith('assets/')
                    ? Image.asset(
                        message.imagePath!,
                        fit: BoxFit.cover,
                        width: double.infinity, // ใช้ double.infinity เพื่อให้รูปภาพกว้างเต็มพื้นที่ภายใน Container
                        height: Get.width * (maxWidthFraction - 0.1) * 0.75, // อัตราส่วน
                      )
                    : Image.file(
                        File(message.imagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity, // ใช้ double.infinity
                        height: Get.width * (maxWidthFraction - 0.1) * 0.75,
                      ),
              ),
            if (message.imagePath != null) const SizedBox(height: 8),
            Text( // แก้ไข: ลบ Expanded ออก
              message.text ?? 'อัลบั้ม', // ชื่ออัลบั้มหรือข้อความเริ่มต้น
              style: TextStyle(
                color: albumTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (message.album != null && message.album!.imagePaths.length > 1)
              Text(
                '${message.album!.imagePaths.length} รูปภาพ', // จำนวนรูปภาพในอัลบั้ม
                style: TextStyle(
                  color: albumTextColor.withOpacity(0.7), // สีข้อความจางลง
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // เมธอดสำหรับแสดงผลข้อความรูปภาพ
  Widget _buildImageMessageContent(
      Message message, Color color, double maxWidthFraction) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: message.imagePath!.startsWith('assets/')
            ? Image.asset(
                message.imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image));
                },
              )
            : Image.file(
                File(message.imagePath!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image));
                },
              ),
      ),
    );
  }

  // เมธอดสำหรับแสดงผลข้อความไฟล์เอกสาร
  Widget _buildDocumentMessageContent(
      Message message, Color color, Color textColor, double maxWidthFraction) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.description, color: textColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message.fileName ?? 'เอกสาร',
              style: TextStyle(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // เมธอดสำหรับแสดงผลข้อความไฟล์เสียง
  Widget _buildAudioMessageContent(
      Message message, Color color, Color textColor, double fixedWidth) {
    return Container(
      width: fixedWidth,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              // controller.toggleAudioPlay(message); // Uncomment if audio playback is implemented
            },
            child: Icon(
              message.isPlaying.value
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: textColor,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message.fileName ?? 'ไฟล์เสียง',
              style: TextStyle(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // เมธอดสำหรับแสดงผลข้อความ Text ธรรมดา
  Widget _buildTextMessageContent(
      Message message, Color color, Color textColor, double maxWidthFraction) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * maxWidthFraction),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message.text!,
        style: TextStyle(color: textColor),
      ),
    );
  }
}