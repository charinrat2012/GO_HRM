
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/data/models/menu_model.dart';

import '../../../data/services/auth_service.dart';
import '../../../data/services/user_preference_service.dart';
import '../../global_widgets/datalist.dart';

class FavouriteController extends GetxController {
  final isEditing = false.obs;
  final favoriteItems = <MenuModel>[].obs;
  final allMenuCategories = <MenuCategory>[].obs;
  final int favoriteLimit = 8;
 final AuthService _authService = Get.find<AuthService>();
  final UserPreferenceService _preferenceService = Get.find<UserPreferenceService>();
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
  } void _prepareDefaultFavorites() {
    // 2. โหลดรายการโปรดเริ่มต้นจาก Service
    if (_authService.isLoggedIn) {
      final String currentUserId = _authService.currentUser.value!.userId;
      final List<String> favoriteIds = _preferenceService.getFavoriteMenuIds(currentUserId);

      final defaultFavorites = DataList.allMenus
          .where((menu) => favoriteIds.contains(menu['iconId']))
          .map((map) => MenuModel.fromMap(map))
          .toList();

      favoriteItems.assignAll(defaultFavorites);
    }
  }

  void toggleEditMode() {
    // --- 🛠️ จุดแก้ไข: เพิ่มตรรกะการ "บันทึก" ---
    // ถ้ากำลังจะออกจากโหมดแก้ไข (isEditing กำลังจะเป็น false)
    if (isEditing.value) {
      // ให้ทำการบันทึกข้อมูล
      _saveFavorites();
    }
    isEditing.value = !isEditing.value;
  }

  // 3. สร้างฟังก์ชันสำหรับบันทึกข้อมูล
  void _saveFavorites() {
    if (_authService.isLoggedIn) {
      final String currentUserId = _authService.currentUser.value!.userId;
      // แปลง List<MenuModel> กลับไปเป็น List<String> ของ ID
      final List<String> newFavoriteIds = favoriteItems.map((item) => item.iconId).toList();
      // เรียกใช้ Service เพื่ออัปเดตข้อมูล
      _preferenceService.updateFavoriteMenus(currentUserId, newFavoriteIds);

      Get.snackbar('สำเร็จ', 'บันทึกรายการโปรดเรียบร้อยแล้ว');
    }
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
