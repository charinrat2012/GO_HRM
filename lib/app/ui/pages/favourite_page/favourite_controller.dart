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
    // แปลง List<Map> จาก Datalist เป็น List<MenuModel>
    final allMenus =
        DataList.allMenus.map((map) => MenuModel.fromMap(map)).toList();

    // จัดกลุ่มเมนูตาม category
    final Map<String, List<MenuModel>> groupedMenus = {};
    for (var menu in allMenus) {
      if (groupedMenus[menu.category] == null) {
        groupedMenus[menu.category] = [];
      }
      groupedMenus[menu.category]!.add(menu);
    }

    // สร้าง List<MenuCategory> จากข้อมูลที่จัดกลุ่มแล้ว
    final categories = groupedMenus.entries.map((entry) {
      return MenuCategory(title: entry.key, items: entry.value);
    }).toList();

    allMenuCategories.assignAll(categories);
  }

  void _prepareDefaultFavorites() {
    // ดึงข้อมูลจาก allMenus ที่มี title ตรงกับใน defaultFavoriteTitles
    final defaultFavorites = DataList.allMenus
        .where((menu) => DataList.defaultFavoriteTitles.contains(menu['title']))
        .map((map) => MenuModel.fromMap(map))
        .toList();

    // จำกัดจำนวนโปรดเริ่มต้นไม่ให้เกิน limit
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
    // ตรวจสอบว่ารายการโปรดเต็มแล้วหรือยัง
    if (favoriteItems.length >= favoriteLimit) {
      Get.snackbar(
        'เพิ่มรายการโปรดไม่ได้',
        'คุณสามารถเพิ่มรายการโปรดได้สูงสุด $favoriteLimit รายการ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
      return; // ออกจากฟังก์ชัน ไม่ต้องทำอะไรต่อ
    }

    // ถ้ายังไม่เต็ม ก็เพิ่มรายการตามปกติ
    if (!isFavorite(item)) {
      favoriteItems.add(item);
    }
  }

  void removeFromFavorites(MenuModel item) {
    // แค่ลบออกจาก list โปรดก็เพียงพอแล้ว
    // เพราะ UI จะวาดใหม่และไปหาเมนูตัวนี้เจอใน allMenuCategories เอง
    favoriteItems.removeWhere((favItem) => favItem.title == item.title);
  }
}