import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/user_model.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_routes.dart';
import '../../navigation_page/navigation_controller.dart';

class MenuForm extends StatelessWidget {
  final UserModel user;
  const MenuForm({super.key, required this.user});

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
                Divider(color: Colors.grey),
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
                  _buildListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.PROFILE);
                    },
                    leading: CircleAvatar(
                      radius: 12.0,
                      backgroundImage: AssetImage(user.imgProfile),
                    ),
                    title: user.userName,
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {},
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
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {Get.toNamed(AppRoutes.PRIVACY_POLICY);},
                    leading: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    title: 'นโยบายความเป็นส่วนตัว',
                  ),
                  const SizedBox(height: 12),
                  _buildListTile(
                    onTap: () {},
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

                      // 2. เรียกใช้ฟังก์ชัน logout()
                      authService.logout();
                      final navigationController =
                          Get.find<NavigationController>();
                      3.seconds.delay().then((_) => navigationController.resetToHome());
                    },
                    leading: const Icon(Icons.login, color: Colors.black),
                    title: 'ออกจากระบบ',
                    trailing: false,
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
    bool trailing = true,
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
