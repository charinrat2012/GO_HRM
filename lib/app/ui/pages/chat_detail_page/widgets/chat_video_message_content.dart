import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/models/chat_model.dart';


class ChatVideoMessageContent extends StatefulWidget {
  final Message message;
  final Color bubbleColor;
  final Color textColor;
  final double fixedWidth;

  const ChatVideoMessageContent({
    super.key,
    required this.message,
    required this.bubbleColor,
    required this.textColor,
    required this.fixedWidth,
  });

  @override
  State<ChatVideoMessageContent> createState() => _ChatVideoMessageContentWidgetState();
}
// จัดให้ข้อความของคุณอยู่ชิดขวา และข้อความของผู้อื่นอยู่ชิดซ้าย
//แสดงชื่อและรูปโปรไฟล์ของผู้ส่งสำหรับข้อความที่ไม่ใช่ของคุณ (โดยเฉพาะในแชทกลุ่ม) และซ่อนอัตโนมัติเมื่อเป็นข้อความที่ส่งติดกันจากผู้ส่งคนเดิม
//จัดตำแหน่งเวลาให้เหมาะสมกับฝั่งของข้อความและแสดงเนื้อหาที่หลากหลาย ไม่ว่าจะเป็นข้อความธรรมดา, รูปภาพ, วิดีโอ หรือไฟล์.
class _ChatVideoMessageContentWidgetState extends State<ChatVideoMessageContent> {
  VideoPlayerController? _videoController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.message.filePath!.startsWith('assets/')) {
      _videoController = VideoPlayerController.asset(widget.message.filePath!);
    } else {
      _videoController = VideoPlayerController.file(
        File(widget.message.filePath!),
      );
    }

    _videoController?.initialize().then((_) {
      if (mounted) {
        setState(() {});
      }
    });

    _videoController?.addListener(() {
      if (_isPlaying != _videoController!.value.isPlaying) {
        if (mounted) {
          setState(() {
            _isPlaying = _videoController!.value.isPlaying;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fixedWidth,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: widget.bubbleColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_videoController != null && _videoController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            )
          else
            Container(
              height: widget.fixedWidth * (9 / 16),
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(color: widget.textColor),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.message.fileName ?? 'วิดีโอ',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    color: widget.textColor,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_videoController != null) {
                      if (_videoController!.value.isPlaying) {
                        _videoController!.pause();
                      } else {
                        _videoController!.play();
                      }
                    }
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