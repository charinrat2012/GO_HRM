import 'package:get/get.dart';

class Album {
  String name;
  RxList<String> imagePaths;

  Album({required this.name, required List<String> imagePaths})
    : imagePaths = imagePaths.obs;

  // เพิ่ม factory constructor สำหรับสร้าง Object จาก Map
  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      name: map['name'] as String,
      imagePaths: List<String>.from(map['imagePaths'] as List<dynamic>),
    );
  }

  // เพิ่มเมธอด toMap สำหรับแปลง Object เป็น Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePaths': imagePaths.toList(), // แปลง RxList เป็น List ธรรมดา
    };
  }
}