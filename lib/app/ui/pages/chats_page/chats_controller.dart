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
      chats[index].messages.assignAll(
        updatedChat.messages,
      ); // อัปเดต messages ทั้งหมด
      chats.refresh(); // บังคับให้ ListView ใน ChatsPage อัปเดต (ถ้าจำเป็น)
    }
  }

  void _loadChatsData() {
    chats.assignAll([
      Chat(
        id: '1',
        name: 'หัวหน้าที่รัก',
        isGroup: false,
        imageUrl: 'assets/imgs/pic2.jpg',
        lastMessage: 'อยากจะโดนไล่ออกทั้งแผนกกันใช่ไหม',
        time: '12:04',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'หัวหน้าที่รัก',
            senderImageUrl: 'assets/imgs/pic2.jpg',
            text: 'ทำไมวันนี้มีแต่คนมาสาย???',
            time: '',
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
        isGroup: true,
        lastMessage: 'หัวหน้า: ทำไมวันนี้มีเเต่คนมาสาย!!!',
        time: '7 ม.ค. 2566',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'หัวหน้าที่รัก',
            senderImageUrl: 'assets/imgs/logo_absolute.png',
            text: 'ทำไมวันนี้มีเเต่คนมาสาย!!!',
            time: '',
            isMe: false,
          ),
          Message(
            senderName: 'หัวหน้าที่รัก',
            senderImageUrl: 'assets/imgs/logo_absolute.png',
            text: 'อยากจะโดนไล่ออกทั้งเเผนกกันใช่มั้ย',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'บุญนิสา',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'รถติดมากเลยค่ะ',
            time: '',
            isMe: false,
          ),
          Message(
            senderName: 'บุญนิสา',
            senderImageUrl: 'assets/imgs/pic2.jpg',
            text: 'ตอนนี้อยู่เเถวสุขุมวิท 14 ',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'ผมรู้สึกป่วย กินไม่ได้นอนไม่หลับ',
            time: '',
            isMe: true,
          ),
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'ไม่มีใบรับรองเเพทย์นะครับนอนอยู่บ้านเฉยๆ',
            time: '12:04',
            isMe: true,
          ),
          Message(
            senderName: 'วิวัฒนาศักดิ์',
            senderImageUrl: 'assets/imgs/pic5.jpg',
            text: 'หัวหน้าคะ วันนี้ขอลา เดี๋ยวเอกสารตามไป',
            time: '',
            isMe: false,
          ),
          Message(
            senderName: 'วิวัฒนาศักดิ์',
            senderImageUrl: 'assets/imgs/pic5.jpg',
            text: 'พอดีตอนนี้ยังไม่ว่างส่งค่ะ รอก่อน ',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'จีรารัตน์',
            senderImageUrl: 'assets/imgs/pic4.jpg',
            text: 'ลาเเบบนี้อย่าลา มาเซ็นใบลาออกก่อนค่ะ ',
            time: '12:04',
            isMe: false,
          ),
          Message(
            senderName: 'Me',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'จริงด้วยครับ สนับสนุน ',
            time: '12:04',
            isMe: true,
          ),
          Message(
            senderName: 'อภิลดา',
            senderImageUrl: 'assets/imgs/pic6.jpg',
            text: 'งั้นขอลาออกด้วยคน +1 อิอิ ',
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
            time: '',
            isMe: false,
          ),
          Message(
            senderName: 'บุญนิสา',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'ตอนนี้อยู่แถวสุขุมวิท 14',
            time: '',
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
      Chat(
        id: '4',
        name: 'ชนิตรา ปิติโอภาสพงศ์',
        imageUrl: 'assets/imgs/pic4.jpg',
        lastMessage: 'ทำไมวันนี้ไม่เจอกันที่ห้องทำงาน??',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'ชนิตรา ปิติโอภาสพงศ์',
            senderImageUrl: 'assets/imgs/pic4.jpg',
            text: 'ทำไมวันนี้ไม่เจอกันที่ห้องทำงาน??',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '5',
        name: 'แก้วกาล เจริญทิพย์',
        imageUrl: 'assets/imgs/pic5.jpg',
        lastMessage: 'แก้วกาล ส่งข้อความเเบบเข้ารหัส',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'แก้วกาล เจริญทิพย์',
            senderImageUrl: 'assets/imgs/pic5.jpg',
            text: 'แก้วกาล ส่งข้อความเเบบเข้ารหัส',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '6',
        name: 'กาญจน์ นิธิวรสกุล',
        imageUrl: 'assets/imgs/pic6.jpg',
        lastMessage: 'กาญจน์ ส่งรูปภาพ', // *** เปลี่ยนตรงนี้ ***
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'กาญจน์ นิธิวรสกุล',
            senderImageUrl: 'assets/imgs/pic6.jpg',
            text: null, // *** เปลี่ยนตรงนี้เป็น null ***
            imagePath: 'assets/imgs/pic6.jpg',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '7',
        name: 'พรพิมล สรพินิจ',

        imageUrl: 'assets/imgs/pic7.jpg',
        lastMessage: 'คุณ: เจอกันพรุ่งนี้นะครับ',
        time: '12:04',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'พรพิมล สรพินิจ',
            senderImageUrl: 'assets/imgs/pic7.jpg',
            text: 'คุณ: เจอกันพรุ่งนี้นะครับ???',
            time: '12:04',
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '8',
        name: 'กาญญา พาณิชวัฒนากูล',
        imageUrl: 'assets/imgs/pic8.jpg',
        lastMessage: '[ข้อความเสียง]',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'กาญญา พาณิชวัฒนากูล',
            senderImageUrl: 'assets/imgs/pic8.jpg',
            text: null,
            filePath:
                'assets/audios/audio.mp4',
            fileName: 'audio.mp4', 
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '9',
        name: 'นิชาภรณ์ ศิลาดี',
        imageUrl: 'assets/imgs/pic9.jpg',
        lastMessage: 'นิชาภรณี ส่งรูปภาพ',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'นิชาภรณ์ ศิลาดี',
            senderImageUrl: 'assets/imgs/pic9.jpg',
            text: null,
            imagePath: 'assets/imgs/pic1.jpg',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '10',
        name: 'ชลธิมา ฐิติรัตนาวงศ์',

        imageUrl: 'assets/imgs/pic10.jpg',
        lastMessage: 'คุณ: สวัสดีครับ ทักครับ',
        time: '12:04',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'ชลธิมา ฐิติรัตนาวงศ์',
            senderImageUrl: 'assets/imgs/pic10.jpg',
            text: 'สวัสดีครับ ทักครับ',
            time: '12:04',
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '11',
        name: 'วลัยพร ขจรเกียรติสกุล',
        imageUrl: 'assets/imgs/pic11.png',
        lastMessage: 'วลัยพร ส่งวิดีโอ',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'วลัยพร ขจรเกียรติสกุล',
            senderImageUrl: 'assets/imgs/pic11.png',
            text: null,
            filePath: 'assets/vids/video1.mp4',
            fileName: 'video.mp4',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '12',
        name: 'ไลลา บำรุงกาญจน์',
        imageUrl: 'assets/imgs/pic1.jpg',
        lastMessage: 'ทำอะไรอยู่???',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'ไลลา บำรุงกาญจน์',
            senderImageUrl: 'assets/imgs/pic1.jpg',
            text: 'ทำอะไรอยู่???',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '13',
        name: 'ชนวรรณ พินิจนันท์',
        imageUrl: 'assets/imgs/pic2.jpg',
        lastMessage: 'พรุ่งนี้นัดกันเจอเวลา 10.30 ที่บริษัท นะคะ',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'ชนวรรณ พินิจนันท์',
            senderImageUrl: 'assets/imgs/pic2.jpg',
            text: 'พรุ่งนี้นัดกันเจอเวลา 10.30 ที่บริษัท นะคะ',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '14',
        name: 'พรรณวร จันทรทรัพย์',
        imageUrl: 'assets/imgs/pic3.jpg',
        lastMessage: 'คุณ: สวัสดีครับ เเผนกไอทีครับ',
        time: '12:04',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'พรรณวร จันทรทรัพย์',
            senderImageUrl: 'assets/imgs/pic3.jpg',
            text: 'สวัสดีครับ เเผนกไอทีครับ',
            time: '12:04',
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '15',
        name: 'GO HR GO GO',
        isGroup: true,
        imageUrl: 'assets/imgs/profile1.png',
        lastMessage: 'เมริสา: ทุกอันที่ไม่ใช่ซื้อผ่านเเอพ',
        time: '26 เม.ย. ',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'เมริสา',
            senderImageUrl: 'assets/imgs/profile1.png',
            text: 'ทุกอันที่ไม่ใช่ซื้อผ่านเเอพ',
            time: '12:04',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '16',
        name: 'FREIND FORM THAILAND.co.th',
        isGroup: true,
        imageUrl: 'assets/imgs/profile2.jpg',
        lastMessage: 'คุณผิง: คุณนุ๊ค!เเก้หน้า Article ...',
        time: '26 เม.ย. ',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'คุณผิง',
            senderImageUrl: 'assets/imgs/profile2.jpg',
            text: 'คุณนุ๊ค!เเก้หน้า Article',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '17',
        name: 'Intern เเผนก บัญชี',
        isGroup: true,
        imageUrl: 'assets/imgs/profile3.png',
        lastMessage: 'แก้วกาล: ทำ excel ไม่เป็นค่ะ',
        time: '26 เม.ย. ',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'แก้วกาล',
            senderImageUrl: 'assets/imgs/profile3.png',
            text: 'ทำ excel ไม่เป็นค่ะ',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '18',
        name: 'VIETJET AIR',
        isGroup: true,
        imageUrl: 'assets/imgs/profile4.png',
        lastMessage: 'นักบิน1: วันนี้งดการบิน เนื่องจาก...',
        time: '26 เม.ย. ',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'นักบิน',
            senderImageUrl: 'assets/imgs/profile4.png',
            text: 'วันนี้งดการบิน เนื่องจากพายุเข้า',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '19',
        name: 'กาญญา, แก้วกาล, ชนิตรา',
        isGroup: true,
        imageUrl: 'assets/imgs/profile5.jpg',
        lastMessage: 'คุณ: หัวหน้าบ่นเยอะหว่ะ เซ็งมาก',
        time: '26 เม.ย. ',
        unreadCount: 0,
        messages: [
          Message(
            senderName: 'คุณ',
            senderImageUrl: 'assets/imgs/profile5.jpg',
            text: 'หัวหน้าบ่นเยอะหว่ะ เซ็งมาก',
            time: '26 เม.ย. 2568',
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '20',
        name: 'Intern AGODA.com',
        isGroup: true,
        imageUrl: 'assets/imgs/profile6.png',
        lastMessage: 'ไม่สามารถดูข้อความได้',
        time: '26 เม.ย.2568',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'Intern AGODA',
            senderImageUrl: 'assets/imgs/profile6.png',
            text: 'ไม่สามารถดูข้อความได้',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '21',
        name: 'Intern ORBITZ.ac.th',
        isGroup: true,
        imageUrl: 'assets/imgs/profile7.png',
        lastMessage: 'ไม่สามารถดูข้อความได้',
        time: '26 เม.ย.2568',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'Intern ORBITZ',
            senderImageUrl: 'assets/imgs/profile7.png',
            text: 'ไม่สามารถดูข้อความได้',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '22',
        name: 'เเผนก ผู้สูงวัยเเละพร้อมเกษียณ',
        isGroup: true,
        imageUrl: 'assets/imgs/profile8.jpg',
        lastMessage: 'วลัยพร: รู้สึกปวดหลังมากเลยค่ะ',
        time: '26 เม.ย.2568',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'วลัยพร',
            senderImageUrl: 'assets/imgs/profile8.jpg',
            text: 'รู้สึกปวดหลังมากเลยค่ะ',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '23',
        name: 'Intern TRIP.com',
        isGroup: true,
        imageUrl: 'assets/imgs/profile9.png',
        lastMessage: 'ไม่สามารถดูข้อความได้',
        time: '2 ,b.p. 2568',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'Intern TRIP',
            senderImageUrl: 'assets/imgs/profile9.png',
            text: 'ไม่สามารถดูข้อความได้',
            time: '2 ,b.p. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '24',
        name: 'EATIGO',
        isGroup: true,
        imageUrl: 'assets/imgs/profile10.png',
        lastMessage: 'นิชาภรณี: ข้อมูลมั่วมากเลยค่ะ',
        time: '23 d.8. 2568',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'นิชาภรณี',
            senderImageUrl: 'assets/imgs/profile10.png',
            text: 'ข้อมูลมั่วมากเลยค่ะ',
            time: '23 d.8. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '25',
        name: 'Intern AirBNB',
        isGroup: true,
        imageUrl: 'assets/imgs/profile11.jpg',
        lastMessage: 'ไม่สามารถดูข้อความได้',
        time: '27 ก.พ. 2568 ',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'Intern AirBNB',
            senderImageUrl: 'assets/imgs/profile11.jpg',
            text: 'ไม่สามารถดูข้อความได้',
            time: '27 ก.พ. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '26',
        name: 'Intern CHOPE.co.th',
        isGroup: true,
        imageUrl: 'assets/imgs/profile12.png',
        lastMessage: 'ไม่สามารถดูข้อความได้',
        time: '26 เม.ย. 2568 ',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'Intern CHOPE',
            senderImageUrl: 'assets/imgs/profile12.png',
            text: 'ไม่สามารถดูข้อความได้',
            time: '26 เม.ย. 2568',
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '27',
        name: 'เมริสา วีระพงศ์ศาล',
        imageUrl: 'assets/imgs/profile5.jpg',
        lastMessage: '[ข้อความเสียง]',
        time: '7 ม.ค. 2566',
        unreadCount: 1,
        messages: [
          Message(
            senderName: 'เมริสา วีระพงศ์ศาล',
            senderImageUrl: 'assets/imgs/profile5.jpg',
            text: null,
            filePath: 'assets/audios/audio.mp3',
            fileName: 'audio.mp3',
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
