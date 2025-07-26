
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/chat_model.dart';
import '../chat_detail_controller.dart';
import 'chat_message_content.dart'; 
//กล่องข้อความ (Bubble) เดียวๆ ในหน้าจอแชท มันจะแสดงข้อความพร้อมข้อมูลผู้ส่งและเวลา 
//และมันจะแสดงโดยปรับรูปแบบตามว่าข้อความนั้นเป็นข้อความของคุณเอง หรือข้อความจากผู้อื่น
class MessageBox extends GetView<ChatDetailController> { 
  final Message message;
  final bool showHeader;
  final bool isGroupChat;

  const MessageBox({ 
    super.key,
    required this.message,
    required this.showHeader,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final bool isTimeOnRight = !isMe;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (showHeader && !isMe && isGroupChat)
            Padding(
              padding: const EdgeInsets.only(left: 48.0, bottom: 4.0),
              child: Text(
                message.senderName,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMe)
                Visibility(
                  visible: showHeader,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(message.senderImageUrl),
                  ),
                ),
              if (!isMe) const SizedBox(width: 8),
              Flexible(
                child: Row(
                  mainAxisAlignment: isMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isTimeOnRight) ...[
                      Text(
                        message.time,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    ChatMessageContent(message: message),
                    if (isTimeOnRight) ...[
                      const SizedBox(width: 8),
                      Text(
                        message.time,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}