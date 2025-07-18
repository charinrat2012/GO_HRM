import 'package:get/get.dart';

import '../../ui/global_widgets/datalist.dart';

class UserPreferenceService extends GetxService {
  // ทำให้ List ของเมนูโปรดเป็น Observable (`.obs`)
  // เพื่อให้ส่วนอื่นๆ ของแอปสามารถ "เฝ้าฟัง" การเปลี่ยนแปลงได้
  final RxList<Map<String, dynamic>> favoriteMenu = DataList.favoriteMenu.obs;

  // เมธอดสำหรับดึงรายการ ID เมนูโปรดของผู้ใช้คนใดคนหนึ่ง
  List<String> getFavoriteMenuIds(String userId) {
    // ค้นหาข้อมูลของผู้ใช้ใน List
    final userData = favoriteMenu.firstWhere(
      (fav) => fav['userId'] == userId,
      orElse: () => {'iconId': <String>[]}, // ถ้าไม่เจอ ให้คืนค่า List ว่าง
    );
    // คืนค่าเป็น List ของ String ID
    return List<String>.from(userData['iconId']);
  }

  // เมธอดสำหรับอัปเดต (บันทึก) รายการโปรดของผู้ใช้
  void updateFavoriteMenus(String userId, List<String> newFavoriteIds) {
    // หา index ของข้อมูลผู้ใช้ใน List
    final userIndex = favoriteMenu.indexWhere((fav) => fav['userId'] == userId);

    if (userIndex != -1) {
      // ถ้าเจอผู้ใช้, ให้อัปเดตรายการ 'iconId' ด้วยข้อมูลใหม่
      favoriteMenu[userIndex]['iconId'] = newFavoriteIds;
      // การใช้ .refresh() จะบังคับให้ Widget ที่ "ฟัง" `favoriteMenu` อยู่เกิดการ re-build
      favoriteMenu.refresh();
    } else {
      // ถ้าไม่เจอ (อาจจะเป็น user ใหม่), ให้เพิ่มข้อมูลใหม่เข้าไป
      favoriteMenu.add({'userId': userId, 'iconId': newFavoriteIds});
    }
  }
}
