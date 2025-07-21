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
        tempFilteredList = chats.where((chat) => chat.unreadCount.value > 0).toList();
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
          Message(senderName: 'หัวหน้าที่รัก', senderImageUrl: 'assets/imgs/pic2.jpg', text: 'ทำไมวันนี้มีแต่คนมาสาย???', time: '12:04', isMe: false),
          Message(senderName: 'หัวหน้าที่รัก', senderImageUrl: 'assets/imgs/pic2.jpg', text: 'อยากจะโดนไล่ออกทั้งแผนกกันใช่ไหม', time: '12:04', isMe: false),
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
          Message(senderName: 'Absolute Management.co.th', senderImageUrl: 'assets/imgs/logo_absolute.png', text: 'พรุ่งนี้วันเงินเดือนออกแล้วนะ', time: '12:04', isMe: false),
        ]
      ),
       Chat(
        id: '3',
        name: 'บุญนิสา',
        imageUrl: 'assets/imgs/pic3.jpg',
        lastMessage: 'หัวหน้าลองมาติดบ้างมั้ยคะ?',
        time: '12:04',
        unreadCount: 2,
         messages: [
           Message(senderName: 'บุญนิสา', senderImageUrl: 'assets/imgs/pic3.jpg', text: 'รถติดมากเลยค่ะ', time: '12:04', isMe: false),
           Message(senderName: 'บุญนิสา', senderImageUrl: 'assets/imgs/pic3.jpg', text: 'ตอนนี้อยู่แถวสุขุมวิท 14', time: '12:04', isMe: false),
           Message(senderName: 'บุญนิสา', senderImageUrl: 'assets/imgs/pic3.jpg', text: 'หัวหน้าลองมาติดบ้างมั้ยคะ?', time: '12:04', isMe: false),
        ]
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
