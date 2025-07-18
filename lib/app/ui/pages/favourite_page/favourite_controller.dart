
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/data/models/menu_model.dart';

import '../../global_widgets/datalist.dart';

class FavouriteController extends GetxController {
  final isEditing = false.obs;
  final favoriteItems = <MenuModel>[].obs;
  final allMenuCategories = <MenuCategory>[].obs;
  final int favoriteLimit = 8;

  @override
  void onInit() {
    super.onInit();
    _prepareMenuData();
    _prepareDefaultFavorites();
  }

  void _prepareMenuData() {
    final allMenus =
        DataList.allMenus.map((map) => MenuModel.fromMap(map)).toList();

    final Map<String, List<MenuModel>> groupedMenus = {};
    for (var menu in allMenus) {
      if (groupedMenus[menu.category] == null) {
        groupedMenus[menu.category] = [];
      }
      groupedMenus[menu.category]!.add(menu);
    }

    final categories = groupedMenus.entries.map((entry) {
      return MenuCategory(title: entry.key, items: entry.value);
    }).toList();

    allMenuCategories.assignAll(categories);
  }

  void _prepareDefaultFavorites() {
    // --- 🛠️ จุดแก้ไขที่ 2: เปลี่ยนตรรกะการดึงข้อมูลโปรดเริ่มต้น ---
    // ในระบบจริง เราจะใช้ ID ของผู้ใช้ที่ล็อกอินอยู่มาค้นหา
    // แต่ในตัวอย่างนี้ เราจะใช้ userid: 1 เป็นค่าเริ่มต้น
    const String currentUserId = '1';

    // 1. ค้นหาข้อมูลเมนูโปรดของผู้ใช้ปัจจุบันจาก `favoriteMenu`
    final userFavoritesData = DataList.favoriteMenu.firstWhere(
      (fav) => fav['userid'] == currentUserId,
      orElse: () => <String, dynamic>{}, // คืนค่า Map ว่างถ้าไม่เจอ
    );

    // 2. ตรวจสอบว่าเจอข้อมูลและมีรายการ `iconId` หรือไม่
    if (userFavoritesData.isNotEmpty && userFavoritesData['iconId'] is List) {
      // 3. ดึง List ของ ID ออกมา
      final List<String> favoriteIds = List<String>.from(userFavoritesData['iconId']);

      // 4. กรองเมนูจาก `allMenus` ที่มี 'iconId' ตรงกับ ID ที่ดึงมา
      final defaultFavorites = DataList.allMenus
          .where((menu) => favoriteIds.contains(menu['iconId']))
          .map((map) => MenuModel.fromMap(map))
          .toList();

      // 5. จำกัดจำนวนและกำหนดค่าให้ `favoriteItems` (เหมือนเดิม)
      if (defaultFavorites.length > favoriteLimit) {
        favoriteItems.assignAll(defaultFavorites.take(favoriteLimit));
      } else {
        favoriteItems.assignAll(defaultFavorites);
      }
    } else {
      // กรณีไม่เจอข้อมูลของผู้ใช้ ให้เคลียร์รายการโปรดเป็นค่าว่าง
      favoriteItems.clear();
    }
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
  }

  // เปลี่ยนการเปรียบเทียบจาก `title` เป็น `id`
  bool isFavorite(MenuModel item) {
    return favoriteItems.any((favItem) => favItem.iconId == item.iconId);
  }

  void addToFavorites(MenuModel item) {
    if (favoriteItems.length >= favoriteLimit) {
      Get.snackbar(
        'เพิ่มรายการโปรดไม่ได้',
        'คุณสามารถเพิ่มรายการโปรดได้สูงสุด $favoriteLimit รายการ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    if (!isFavorite(item)) {
      favoriteItems.add(item);
    }
  }

  // เปลี่ยนการเปรียบเทียบจาก `title` เป็น `id`
  void removeFromFavorites(MenuModel item) {
    favoriteItems.removeWhere((favItem) => favItem.iconId == item.iconId);
  }
}
