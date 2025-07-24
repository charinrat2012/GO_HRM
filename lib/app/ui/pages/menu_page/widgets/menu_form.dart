import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'dart:io';

import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../navigation_page/navigation_controller.dart';
import '../menu_controller.dart';

class MenuForm extends GetView<MenuController> {
  const MenuForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 8),
                Divider(color: Colors.grey), //เส้นแบ่ง
                SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() {
                    final currentUser = controller.currentUser;
                    if (currentUser == null) {
                      return const SizedBox.shrink();
                    } //ตรวจสอบว่ารูปภาพมาจากassets หรือไม่ //ถ้าใช่แสดงว่ารูปภาพนี้เป็น Asset ที่มาพร้อมกับแอปพลิเคชัน
                    ImageProvider avatarImage;
                    if (currentUser.imgProfile.startsWith('assets/')) {
                      avatarImage = AssetImage(currentUser.imgProfile);
                    } else {
                      //ถ้าไม่ใชแสดงว่าเป็นเส้นทางของไฟล์รูปภาพที่ผู้ใช้เลือกมาจากแกลเลอรีบนโทรศัพท์
                      final File imageFile = File(currentUser.imgProfile);
                      if (imageFile.existsSync()) {
                        //ตรวจสอบว่าได้โหลดไฟล์ได้หรือไม่ถ้าไม่ให้ใช่รูปเดิม
                        avatarImage = FileImage(imageFile);
                      } else {
                        avatarImage = AssetImage(Assets.assetsImgsProfile);
                      }
                    }
                    return _buildListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.PROFILE);
                      },
                      leading: CircleAvatar(
                        radius: 12.0,
                        backgroundImage: avatarImage, //รูปภาพ
                        onBackgroundImageError: (exception, stackTrace) {
                          print('Error loading background image: $exception');
                        }, //ตรวจสอบว่ารูปภาพโหลดสำเร็จหรือไม่
                      ),
                      title: currentUser.userName,//ชื่อผู้ใช้จะเปลี่ยนถ้าเราแก้ไข
                    );
                  }),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.SETTINGS);
                    },
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: 'การตั้งค่า',
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    title: 'เงื่อนไขการใช้บริการ',
                    trailing: true,
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.PRIVACY_POLICY);
                    },
                    leading: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    title: 'นโยบายความเป็นส่วนตัว',
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.HELP);
                    },
                    leading: const Icon(
                      Icons.help_outline,
                      color: Colors.black,
                    ),
                    title: 'ช่วยเหลือ',
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {
                      final authService = Get.find<AuthService>();
                      authService.logout();
                      final navigationController =
                          Get.find<NavigationController>();
                      3.seconds.delay().then(
                        (_) => navigationController.resetToHome(),
                      );
                    },
                    leading: const Icon(Icons.login, color: Colors.black),
                    title: 'ออกจากระบบ',
                    
                  ),
                  const SizedBox(height: 80),
                  const Text(
                    'Version. 1.0.50',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    GestureTapCallback? onTap,
    Widget? leading,
    required String title,
    bool trailing = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      width: 358,
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: leading,
        title: Text(title, style: const TextStyle(color: Colors.black)),
        trailing: trailing
            ? const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Colors.black,
              )
            : null,
      ),
    );
  }
}
