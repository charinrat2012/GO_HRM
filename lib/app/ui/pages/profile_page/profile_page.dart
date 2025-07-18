import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';
import 'widgets/details_profile.dart';
import 'widgets/head_details.dart';
import 'widgets/profile_head.dart';
import 'widgets/profile_image.dart';

class ProfilePage extends GetView<ProfileController>{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          // ใช้ Obx เพื่อ re-build UI เมื่อข้อมูล `currentUser` พร้อมใช้งาน
          child: Obx(() {
            // ตรวจสอบว่ามีข้อมูลผู้ใช้แล้วหรือยัง
            if (controller.currentUser == null) {
              // ถ้ายังไม่มี ให้แสดง Loading...
              return const Center(child: CircularProgressIndicator());
            } else {
              // ถ้ามีข้อมูลแล้ว ให้สร้าง CustomScrollView
              return CustomScrollView(
                slivers: [
                  ProfileHead(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileImage(user: controller.currentUser!,),
                        HeadDetails(),
                        // ส่งข้อมูลผู้ใช้ (UserModel object) ไปให้ DetailsProfile widget
                        DetailsProfile(user: controller.currentUser!),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}

