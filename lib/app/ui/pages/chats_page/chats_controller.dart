// ในไฟล์ lib/app/ui/pages/chats_page/chats_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../routes/app_routes.dart';

class ChatsController extends GetxController {
  final RxList<Chat> chats = <Chat>[].obs;
  final RxList<Chat> filteredChats = <Chat>[].obs;
  final RxInt selectedTabIndex = 0.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadChatsData();
    searchController.addListener(() {
      filterChats(selectedTabIndex.value);
    });
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
    filterChats(index);
  }

  void filterChats(int index) {
    List<Chat> tempFilteredList;
    switch (index) {
      case 1:
        tempFilteredList = chats
            .where((chat) => chat.unreadCount.value > 0)
            .toList();
        break;
      case 2:
        tempFilteredList = chats.where((chat) => chat.isGroup).toList();
        break;
      default:
        tempFilteredList = List<Chat>.from(chats);
        break;
    }

    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      tempFilteredList = tempFilteredList.where((chat) {
        return chat.name.toLowerCase().contains(query);
      }).toList();
    }

    filteredChats.assignAll(tempFilteredList);
  }

  void goToChatDetail(Chat chat) {
    Get.toNamed(AppRoutes.CHAT_DETAIL, arguments: chat);
    chat.unreadCount.value = 0;
  }

  // เพิ่มเมธอดนี้เพื่ออัปเดตข้อความใน Chat list หลัก
  void updateChatMessages(Chat updatedChat) {
    final index = chats.indexWhere((chat) => chat.id == updatedChat.id);
    if (index != -1) {
      // อัปเดตทั้ง chat object เพื่อให้ GetX ตรวจจับการเปลี่ยนแปลงได้
      // เนื่องจาก messages เป็น RxList<Message> อยู่แล้ว การเพิ่มข้อความเข้าไปใน RxList จะ trigger update เอง
      // แต่เพื่อความมั่นใจ หากมีการเปลี่ยนแปลง property อื่นๆ ของ chat object ด้วย
      // การ re-assign object ก็เป็นวิธีหนึ่ง (ถ้า updatedChat เป็น instance ใหม่)
      // แต่ในกรณีนี้ updatedChat คือ reference เดิมที่ถูกเพิ่ม messages เข้าไปแล้ว
      // ดังนั้นแค่เรียก .refresh() บน RxList ของ messages ก็เพียงพอ (ซึ่ง _addMessage ทำแล้ว)
      // หรือถ้าต้องการ update lastMessage/time ใน ChatsController.chats ด้วย
      chats[index].lastMessage.value = updatedChat.lastMessage.value;
      chats[index].time.value = updatedChat.time.value;
      chats[index].messages.assignAll(updatedChat.messages); // อัปเดต messages ทั้งหมด
      chats.refresh(); // บังคับให้ ListView ใน ChatsPage อัปเดต (ถ้าจำเป็น)
    }
  }


  void _loadChatsData() {
    chats.assignAll([
      Chat(
        id: '1',
        name: 'หัวหน้าที่รัก',
        isGroup: true,
        imageUrl: 'assets/imgs/pic2.jpg',
        lastMessage: 'อยากจะโดนไล่ออกทั้งแผนกกันใช่ไหม',
        time: '12:04',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'หัวหน้าที่รัก',
            senderImageUrl: 'assets/imgs/pic2.jpg',
            text: 'ทำไมวันนี้มีแต่คนมาสาย???',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'หัวหน้าที่รัก',
            senderImageUrl: 'assets/imgs/pic2.jpg',
            text: 'อยากจะโดนไล่ออกทั้งแผนกกันใช่ไหม',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '2',
        name: 'Absolute Management.co.th',
        imageUrl: 'assets/imgs/logo_absolute.png',
        lastMessage: 'พรุ่งนี้วันเงินเดือนออกแล้วนะ',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'Absolute Management.co.th',
            senderImageUrl: 'assets/imgs/logo_absolute.png',
            text: 'พรุ่งนี้วันเงินเดือนออกแล้วนะ',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '3',
        name: 'บุญนิสา',
        imageUrl: 'assets/imgs/pic3.jpg',
        lastMessage: 'หัวหน้าลองมาติดบ้างมั้ยคะ?',
        time: '12:04',
        unreadCount: 2,
        messages: [
          Message(
            senderName: 'บุญนิสา',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'รถติดมากเลยค่ะ',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'บุญนิสา',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'ตอนนี้อยู่แถวสุขุมวิท 14',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'บุญนิสา',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'หัวหน้าลองมาติดบ้างมั้ยคะ?',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
    ]);
    filterChats(selectedTabIndex.value);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}