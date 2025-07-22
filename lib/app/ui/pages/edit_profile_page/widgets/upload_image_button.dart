import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../edit_profile_controller.dart';

class UploadImageButton extends GetView<EditprofileController> {
  const UploadImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OutlinedButton.icon(
        onPressed: controller.pickProfileImage, // เรียกใช้เมธอดเลือกรูปภาพ
        icon: const Icon(Icons.photo_camera_outlined),
        label: const Text('เปลี่ยนรูปภาพโปรไฟล์'),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: MyColors.blue2,
          side: const BorderSide(color: MyColors.blue2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
