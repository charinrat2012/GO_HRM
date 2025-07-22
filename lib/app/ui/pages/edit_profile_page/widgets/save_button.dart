import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../edit_profile_controller.dart';

class SaveButton extends GetView<EditprofileController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: controller.saveProfile,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: MyColors.blue2,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('บันทึก', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
