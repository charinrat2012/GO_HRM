import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/datalist.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadelogoAnimation;
  late Animation<double> scalelogoAnimation;
  late Animation<Offset> slidelogoAnimation;
  late Animation<Offset> slidecontentAnimation;
  late Animation<Offset> slidehead1Animation;
  late Animation<double> fadeboxAnimation;

  var rememberMe = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _obscureText = true.obs;
  get obscureText => _obscureText.value;
  set obscureText(value) => _obscureText.value = value;
final isAutoLoginView = false.obs;
  final box = GetStorage();
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();

    setAnimations();

  }
  
  @override
  void onReady() {
    super.onReady();
    // _autoLogin();
  }


  void setAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

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
    fadeboxAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.7, 0.8, curve: Curves.linear),
      ),
    );
    animationController.forward();
  }

  // void _autoLogin() {
  //   final rememberedEmail = box.read<String>('email');

  //   if (rememberedEmail != null) {
  //     final userMap = DataList.userData.firstWhere(
  //       (user) => user['email'] == rememberedEmail,
  //       orElse: () => <String, dynamic>{},
  //     );

  //     if (userMap.isNotEmpty) {
  //       isAutoLoginView.value = true;

  //       final userToLogin = UserModel.fromMap(userMap);
  //       _authService.login(userToLogin);

  //       // เมื่อล็อกอินสำเร็จ ให้ไปหน้าหลักเลย
  //     7.seconds.delay().then((_) => Get.offAllNamed(AppRoutes.NAVIGATION));
  //     //  Get.offAllNamed(AppRoutes.NAVIGATION);
  //     } else {
  //       // ถ้าไม่เจอข้อมูลผู้ใช้ ให้แสดงหน้าล็อกอินตามปกติ
  //       _loadRememberedEmail();
  //     }
  //   } else {
  //     // ถ้าไม่มีอีเมลที่บันทึกไว้ ให้แสดงหน้าล็อกอินตามปกติ
  //     _loadRememberedEmail();
  //   }
  //   animationController.forward();
  // }

  // void _loadRememberedEmail() {
  //   final rememberedEmail = box.read<String>('email');
  //   if (rememberedEmail != null) {
  //     emailController.text = rememberedEmail;
  //     rememberMe.value = true;
  //   }
  // }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  void fetchLogin() {
    final String inputEmail = emailController.text.trim();
    final String inputPassword = passwordController.text.trim();

    if (inputEmail.isEmpty || inputPassword.isEmpty) {
      Get.snackbar('System', 'กรุณากรอกข้อมูลให้ครบถ้วน');
      return;
    } else if (!GetUtils.isEmail(inputEmail)) {
      Get.snackbar('System', 'กรุณากรอกอีเมลให้ถูกต้อง');
      return;
    }

    final userMap = DataList.userData.firstWhere(
      (user) =>
          user['email'] == inputEmail && user['password'] == inputPassword,
      orElse: () => <String, dynamic>{},
    );

    if (userMap.isNotEmpty) {
      if (rememberMe.value) {
        box.write('email', inputEmail);
      } else {
        box.remove('email');
      }

      final loggedInUser = UserModel.fromMap(userMap);
      _authService.login(loggedInUser);

      if (!rememberMe.value) {
        emailController.clear();
      }
      passwordController.clear();
      FocusScope.of(Get.context!).unfocus();

      Get.offAllNamed(AppRoutes.NAVIGATION);
    } else {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
  }
}