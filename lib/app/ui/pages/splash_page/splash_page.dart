import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import '../../utils/assets.dart';
import 'splash_controllers.dart';
import 'widgets/box_login.dart';
import 'widgets/head_login.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // --- ใช้ Obx เพื่อสลับ UI ตามสถานะ ---
      body: Obx(() {
        // --- ถ้า isAutoLoginView เป็น true ให้แสดง Splash Screen แบบเรียบง่าย ---
        return controller.isAutoLoginView.value
            ? _splashLogin()
            // --- มิฉะนั้น ให้แสดง Splash Screen แบบมี Animation สำหรับล็อกอิน ---
            // ? _splashNomal()
            : _splashNomal();
      }),
    );
  }

  Widget _splashNomal() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(Get.context!).unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          child: SlideTransition(
            position: controller.slidehead1Animation,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 100),
                    Center(
                      child: SvgPicture.asset(
                        Assets.assetsImgsHrmLogo,
                        height: 82,
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.center,
                  child: SlideTransition(
                    position: controller.slidecontentAnimation,
                    child: Container(
                      width: 220,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        color: Theme.of(Get.context!).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                HeadLogin(),
                FadeTransition(
                  opacity: controller.fadeboxAnimation,
                  child: Column(
                    children: [
                      SizedBox(height: 470),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: BoxLogin(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _splashLogin() {
    return FadeTransition(
      opacity: controller.fadeboxAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),

        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              SvgPicture.asset(Assets.assetsImgsGoHrmLogo, height: 82),

              const Spacer(),

              CircularProgressIndicator(color: MyColors.blue2),
              const SizedBox(height: 16),
              const Text("กำลังเข้าสู่ระบบ..."),
            ],
          ),
        ),
      ),
    );
  }
}