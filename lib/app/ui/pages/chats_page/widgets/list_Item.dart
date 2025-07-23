import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../data/models/chat_model.dart';
import '../chats_controller.dart';

class ListItem extends GetView<ChatsController> {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.filteredChats.length,
          itemBuilder: (context, index) {
            final chat = controller.filteredChats[index];
            return _buildChatListItem(chat);
          },
        ),
      ),
    );
  }

  Widget _buildChatListItem(Chat chat) {
    return InkWell(
      onTap: () => controller.goToChatDetail(chat),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(chat.imageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() {
                    // *** โค้ดส่วนนี้คือส่วนที่จัดการตัวหนาตาม unreadCount ***
                    String displayMessage = chat.lastMessage.value;
                    TextStyle displayTextStyle = TextStyle(
                      color: Colors.grey.shade600,
                    ); // สไตล์เริ่มต้น (ไม่หนา)

                    if (chat.unreadCount.value > 0) {
                      // ถ้ามีข้อความที่ยังไม่ได้อ่าน
                      // displayMessage = 'ใหม่! ${chat.lastMessage.value}'; // ถ้าต้องการคำนำหน้า "ใหม่! " ด้วย
                      displayTextStyle = TextStyle(
                        color: Colors.black, // สีเข้มขึ้น
                        fontWeight: FontWeight.bold, // ทำให้เป็นตัวหนา
                      );
                    }
                    // *** สิ้นสุดโค้ดการจัดการตัวหนา ***

                    return Text(
                      displayMessage, // ใช้ข้อความที่ปรับแล้ว
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: displayTextStyle, // ใช้สไตล์ที่ปรับแล้ว
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    chat.time.value,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => chat.unreadCount.value > 0
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: MyColors.blue2,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount.value.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox(height: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
