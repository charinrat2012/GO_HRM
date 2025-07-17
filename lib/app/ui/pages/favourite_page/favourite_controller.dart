// lib/app/ui/pages/favourite_page/favourite_controller.dart

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
    final defaultFavorites = DataList.defaultFavoriteMenus
        .map((data) => MenuModel.fromMap(data))
        .toList();
    if (defaultFavorites.length > favoriteLimit) {
      favoriteItems.assignAll(defaultFavorites.take(favoriteLimit));
    } else {
      favoriteItems.assignAll(defaultFavorites);
    }
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
  }

  bool isFavorite(MenuModel item) {
    return favoriteItems.any((favItem) => favItem.title == item.title);
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

  // --- จุดที่แก้ไข ---
  void removeFromFavorites(MenuModel item) {
    // 1. ลบออกจากรายการโปรด
    favoriteItems.removeWhere((favItem) => favItem.title == item.title);

    // 2. ค้นหาเมนูตัวเต็มจาก allMenus ใน Datalist (เพื่อให้ได้ onPressed ที่ถูกต้อง)
    final originalMenuItemMap = DataList.allMenus.firstWhere(
      (map) => map['title'] == item.title,
      orElse: () => {}, // ถ้าหาไม่เจอ ให้ return map ว่าง
    );

    // 3. ถ้าหาเจอใน Datalist (หมายความว่ามันควรจะกลับไปอยู่ในหมวดหมู่อื่น)
    if (originalMenuItemMap.isNotEmpty) {
      final originalMenuItem = MenuModel.fromMap(originalMenuItemMap);
      
      // 4. หาหมวดหมู่ที่มันควรจะอยู่
      final categoryIndex = allMenuCategories.indexWhere(
        (cat) => cat.title == originalMenuItem.category
      );

      // 5. ถ้าเจอหมวดหมู่ และเมนูนั้นยังไม่มีในหมวดหมู่ (ป้องกันการเพิ่มซ้ำ)
      if (categoryIndex != -1 && 
          !allMenuCategories[categoryIndex].items.any((i) => i.title == originalMenuItem.title)) 
      {
        // เราไม่จำเป็นต้องเพิ่มกลับเข้าไปโดยตรง เพราะ UI จะวาดใหม่เอง
        // แค่การลบออกจาก favoriteItems ก็เพียงพอที่จะทำให้ UI แสดงผลถูกต้องแล้ว
      }
    }
    
    // 6. บังคับให้ UI ที่เกี่ยวข้องกับ allMenuCategories อัปเดตตัวเอง
    // โดยการ refresh list นั้นๆ (วิธีนี้จะทำให้ Obx ทำงาน)
    allMenuCategories.refresh();
  }
}