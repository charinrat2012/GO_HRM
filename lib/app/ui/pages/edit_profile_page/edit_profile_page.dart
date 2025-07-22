import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../profile_page/widgets/head_details.dart';
import '../profile_page/widgets/profile_image.dart';
import 'edit_profile_controller.dart';
import 'widgets/edit_details_profile.dart';
import 'widgets/edit_profile_head.dart';
import 'widgets/save_button.dart';
import 'widgets/upload_image_button.dart';

class EditprofilePage extends GetView<EditprofileController> {
  const EditprofilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: CustomScrollView(
            slivers: [
              const EditProfileHead(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      final currentUser =
                          Get.find<AuthService>().currentUser.value;
                      if (currentUser == null) {
                        return const SizedBox.shrink();
                      }
                      return ProfileImage(
                        user: currentUser.copyWith(
                          imgProfile:
                              controller.pickedProfileImagePath.value.isEmpty
                              ? currentUser.imgProfile
                              : controller.pickedProfileImagePath.value,
                        ),
                      );
                    }),

                    const SizedBox(height: 16),
                    // *** ปุ่ม "เปลี่ยนรูปภาพโปรไฟล์" ***
                    UploadImageButton(),
                    const SizedBox(height: 24),
                    const HeadDetails(),
                    EditDetailsProfile(),
                    const SizedBox(height: 24),
                    SaveButton(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
