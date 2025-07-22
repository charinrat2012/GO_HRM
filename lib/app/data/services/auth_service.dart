// GetxService จะถูกสร้างขึ้นครั้งเดียวและคงอยู่ตลอดการใช้งานแอป
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  // สร้างตัวแปร Observable `currentUser` เพื่อเก็บข้อมูลผู้ใช้ที่ล็อกอินอยู่
  // เริ่มต้นเป็น null คือยังไม่มีใครล็อกอิน
  final Rx<UserModel?> currentUser = Rx(null);

  // Getter สำหรับเช็คสถานะการล็อกอินได้อย่างง่ายๆ
  bool get isLoggedIn => currentUser.value != null;

  // เมธอดสำหรับรับข้อมูลผู้ใช้มาเก็บไว้เมื่อล็อกอินสำเร็จ
  void login(UserModel user) {
    currentUser.value = user;
  }

  // เมธอดสำหรับเคลียร์ข้อมูลผู้ใช้เมื่อล็อกเอาท์
  void logout() {
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.SPLASH);
  }

  // เมธอดใหม่สำหรับอัปเดตข้อมูลผู้ใช้
  void updateUserProfile(UserModel updatedUser) {
    currentUser.value = updatedUser;
  }
}
