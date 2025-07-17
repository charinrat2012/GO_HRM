import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadelogoAnimation;
  late Animation<double> scalelogoAnimation;
  late Animation<Offset> slidelogoAnimation;
  late Animation<Offset> slidecontentAnimation;
  late Animation<Offset> slideheadAnimation;
  late Animation<Offset> slideboxAnimation;
  late Animation<double> fadeboxAnimation;
  late Animation<Offset> slidehead1Animation;
  var rememberMe = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _obscureText = true.obs;
    get obscureText => _obscureText.value;
  set obscureText(value) => _obscureText.value = value;
  List<String> userid = ['1', '2', '3'];
  List<String> names = ['Admin', 'User', 'User2'];
  List<String> emails = [
    'admin@gmail.com',
    'user@gmail.com',
    'user2@gmail.com',
  ];
  List<String> passwords = ['123456', '654321', '654321'];
  @override
  void onInit() {
    super.onInit();

    // --- ตั้งค่า Animation Controller ---
    animationController = AnimationController(
      vsync: this, // 'this' ในที่นี้หมายถึง GetSingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 5000),
    );

    // --- ตั้งค่า Animation ---
    slidehead1Animation =
        Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, -0.20),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.7, 0.8, curve: Curves.linear),
          ),
        );
    fadelogoAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.1, curve: Curves.linear),
      ),
    );
    scalelogoAnimation = Tween<double>(begin: 1, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.1, 0.2, curve: Curves.linear),
      ),
    );

    fadelogoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.3, curve: Curves.linear),
      ),
    );
    scalelogoAnimation = Tween<double>(begin: 1, end: 0.61017).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.4, curve: Curves.linear),
      ),
    );

    // logoInitialScaleAnimation = TweenSequence<double>([

    //   TweenSequenceItem(
    //     tween: Tween<double>(begin: 1, end: 1)
    //         .chain(CurveTween(curve: Curves.easeOut)),
    //     weight: 50.0,
    //   ),
    //   TweenSequenceItem(
    //     tween: Tween<double>(begin: 1, end: 0.61017)
    //         .chain(CurveTween(curve: Curves.easeOut)),
    //     weight: 50.0,
    //   ),
    // ]).animate(
    //   CurvedAnimation(
    //     parent: animationController,
    //     curve: const Interval(0.0, 0.5, curve: Curves.linear),
    //   ),
    // );

    slidelogoAnimation =
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.75, 0.0),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 0.5, curve: Curves.easeOut),
          ),
        );
    // hFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: animationController,
    //     curve: const Interval(0.8, 0.8, curve: Curves.easeOut),
    //   ),
    // );

    // rFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: animationController,
    //     curve: const Interval(0.7, 0.9, curve: Curves.easeOut),
    //   ),
    // );

    // mFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: animationController,
    //     curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
    //   ),
    // );
    slidecontentAnimation =
        Tween<Offset>(
          begin: Offset(0, 0.0),
          end: const Offset(1.2, 0.0),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.5, 0.6, curve: Curves.easeOut),
          ),
        );
    // slideheadAnimation = Tween<Offset>(
    //   begin: Offset(0, 0.0),
    //   end: const Offset(0, -1.5),
    // ).animate(
    //   CurvedAnimation(
    //     parent: animationController,
    //     curve: const Interval(0.7, 0.8, curve: Curves.easeOut),
    //   ),
    // );
    slideboxAnimation =
        Tween<Offset>(
          begin: Offset(0, 0.25),
          end: const Offset(0, -1.5),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.7, 0.8, curve: Curves.easeOut),
          ),
        );
    fadeboxAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.7, 0.8, curve: Curves.linear),
      ),
    );

    // --- สั่งให้แอนิเมชันเริ่มทำงาน และตั้งเวลาเพื่อเปลี่ยนหน้า ---
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose(); // ทำลาย Controller เพื่อป้องกัน Memory Leak
    super.onClose();
  }

  // ฟังก์ชันสำหรับเปลี่ยนหน้าจอเมื่อแอนิเมชันใกล้จะจบ
  @override
  void onReady() {
    //  3.9.seconds.delay().then((_) => Get.offAllNamed(AppRoutes.LOGIN));
  }
  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  void fetchLogin() {
    final String inputEmail = emailController.text.trim();
    final String inputPassword = passwordController.text.trim();
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.closeCurrentSnackbar();
      Get.snackbar(
        'System',
        'กรุณากรอกข้อมูลให้ครบถ้วน',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black.withValues(alpha: 0.1),
        colorText: Colors.black,
        duration: const Duration(milliseconds: 900),
      );

      return;
    } else if (!emailController.text.isEmail) {
      Get.closeCurrentSnackbar();
      Get.snackbar(
        'System',
        'กรุณากรอกอีเมลให้ถูกต้อง',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black.withValues(alpha: 0.1),
        colorText: Colors.black,
        duration: const Duration(milliseconds: 900),
      );

      return;
    }
    final int userIndex = emails.indexOf(inputEmail);

    // --- 4. ตรวจสอบว่ามีผู้ใช้งานและรหัสผ่านถูกต้องหรือไม่ ---
    // เช็คว่า userIndex ไม่ใช่ -1 (เจอผู้ใช้) และรหัสผ่านตรงกัน
    if (userIndex != -1 && passwords[userIndex] == inputPassword) {
      // --- กรณี Login สำเร็จ ---
      final String userName = names[userIndex]; // ดึงชื่อผู้ใช้จากตำแหน่งที่เจอ

      emailController.clear();
      passwordController.clear();
      FocusScope.of(Get.context!).unfocus(); // ซ่อนคีย์บอร์ด

      Get.offAllNamed(AppRoutes.NAVIGATION);
    } else {
      // --- กรณี Login ไม่สำเร็จ ---
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
