import 'package:flutter/material.dart';

class FavoriteItemModel {
  final IconData icon;
  final String title;
  final VoidCallback onPressed; // เพิ่ม property นี้

  FavoriteItemModel({
    required this.icon,
    required this.title,
    required this.onPressed, // เพิ่ม property นี้
  });

  // อัปเดต fromMap ให้รองรับ onPressed
  factory FavoriteItemModel.fromMap(Map<String, dynamic> map) {
    return FavoriteItemModel(
      icon: map['icon'] as IconData,
      title: map['title'] as String,
      onPressed: map['onPressed'] as VoidCallback, // เพิ่ม property นี้
    );
  }
}
