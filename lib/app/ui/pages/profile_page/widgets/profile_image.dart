import 'package:flutter/material.dart';
import 'dart:io';

import '../../../../data/models/user_model.dart';
import '../../../utils/assets.dart';

class ProfileImage extends StatelessWidget {
  final UserModel user;
  const ProfileImage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // กำหนด ImageProvider ตามประเภทของเส้นทางรูปภาพ
    ImageProvider imageProvider;
    if (user.imgProfile.startsWith('assets/')) {
      // ถ้าเส้นทางขึ้นต้นด้วย 'assets/' แสดงว่าเป็นรูปภาพที่อยู่ใน Asset Bundle ของแอป
      imageProvider = AssetImage(user.imgProfile);
    } else {
      // ถ้าไม่ใช่ 'assets/' แสดงว่าเป็นเส้นทางของไฟล์ในระบบ (เช่น จาก FilePicker)
      final File imageFile = File(user.imgProfile);
      // ตรวจสอบว่าไฟล์มีอยู่จริงหรือไม่ ก่อนที่จะพยายามโหลด
      if (imageFile.existsSync()) {
        imageProvider = FileImage(imageFile); // ใช้ FileImage สำหรับไฟล์ในระบบ
      } else {
        // หากไฟล์ที่ระบุไม่มีอยู่จริง ให้ใช้รูปภาพโปรไฟล์เริ่มต้นแทน
        imageProvider = AssetImage(Assets.assetsImgsProfile);
      }
    }

    return Container(
      width: double.infinity,
      height: 390,
      child: Image(
        image:
            imageProvider, //แหล่งที่มาของรู)ภาพว่ามาจากไหน AssetImage หรือรูปจากอุปกรณ์
        fit: BoxFit.cover,

        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            Assets.assetsImgsProfile,
            height: 390,
            width: double.infinity, // กําหนดรูปพอดีกับพื้นที่
            fit: BoxFit
                .cover, //ปรับขนาดรูปภาพให้ใหญ่ยังคงรักษาสัดส่วนของรูปภาพเดิมไว้
          );
        },
      ),
    );
  }
}
