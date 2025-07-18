// lib/app/data/models/menu_model.dart

import 'package:flutter/widgets.dart';

class MenuModel {
  final String iconId;
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final String category;

  MenuModel({
    required this.iconId,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.category, // เพิ่ม property นี้
  });

  // Factory constructor สำหรับแปลง Map เป็น MenuModel
  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      iconId: map['iconId'] as String,
      icon: map['icon'] as IconData,
      title: map['title'] as String,
      onPressed: map['onPressed'] as VoidCallback,
      category: map['category'] as String,
    );
  }
}

// Model สำหรับจัดกลุ่มเมนู
class MenuCategory {
  final String title;
  final List<MenuModel> items;

  MenuCategory({required this.title, required this.items});
}