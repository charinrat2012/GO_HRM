import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../../utils/assets.dart';

class EditprofileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>(); //ดึงข้อมูลผู้ใช้ปัจจุบัน หรือการอัปเดตข้อมูลผู้ใช้หลังการแก้ไข
  final userNameController = TextEditingController();
  final employeeIdController = TextEditingController();
  final idCardController = TextEditingController();
  final sectionController = TextEditingController();
  final nameTitleController = TextEditingController();
  final nickNameController = TextEditingController();
  final firstNameTHController = TextEditingController();
  final lastNameTHController = TextEditingController();
  final firstNameENController = TextEditingController();
  final lastNameENController = TextEditingController();
  final sexController = TextEditingController();
  final birthdayController = TextEditingController();
  final birthplaceController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressTHController = TextEditingController();
  final addressENController = TextEditingController();
  final pickedProfileImagePath = ''.obs; // เส้นทางของรูปภาพโปรไฟล์ใหม่ ที่ผู้ใช้เลือกจากอุปกรณ์

  @override
  void onInit() {
    super.onInit();
    final currentUser = _authService.currentUser.value;
    if (currentUser != null) {
      userNameController.text = currentUser.userName;
      employeeIdController.text = currentUser.employeeId;
      idCardController.text = currentUser.idCard;
      sectionController.text = currentUser.section;
      nameTitleController.text = currentUser.nameTitle;
      nickNameController.text = currentUser.nickName;
      firstNameTHController.text = currentUser.firstNameTH;
      lastNameTHController.text = currentUser.lastNameTH;
      firstNameENController.text = currentUser.firstNameEN;
      lastNameENController.text = currentUser.lastNameEN;
      sexController.text = currentUser.sex;
      birthdayController.text = currentUser.birthday;
      birthplaceController.text = currentUser.birthplace;
      ageController.text = currentUser.age;
      emailController.text = currentUser.email;
      phoneController.text = currentUser.phone;
      addressTHController.text = currentUser.addressTH;
      addressENController.text = currentUser.addressEN;
      pickedProfileImagePath.value = currentUser.imgProfile; //รูปปักำหนดค่าเริ่มต้นเป็นจจุบันให้รูปภาพโปรไฟล์ปัจจุบันแสดงขึ้นมาในหน้าแก้ไขทันทีที่โหลดหน้าจอ
    }
  }

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  // เมธอดสำหรับเลือกรูปภาพโปรไฟล์
  Future<void> pickProfileImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // เลือกเฉพาะไฟล์รูปภาพ
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        pickedProfileImagePath.value =
            result.files.single.path!; // อัปเดตเส้นทางรูปภาพที่เลือก
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกรูปภาพได้: $e');
    }
  }

  void saveProfile() {
    if (_authService.currentUser.value == null) {
      Get.snackbar('ข้อผิดพลาด', 'ไม่พบข้อมูลผู้ใช้');
      return;
    }

    final updatedUser = _authService.currentUser.value!.copyWith(
      userName: userNameController.text,
      employeeId: employeeIdController.text,
      idCard: idCardController.text,
      section: sectionController.text,
      nameTitle: nameTitleController.text,
      nickName: nickNameController.text,
      firstNameTH: firstNameTHController.text,
      lastNameTH: lastNameTHController.text,
      firstNameEN: firstNameENController.text,
      lastNameEN: lastNameENController.text,
      sex: sexController.text,
      birthday: birthdayController.text,
      birthplace: birthplaceController.text,
      age: ageController.text,
      email: emailController.text,
      phone: phoneController.text,
      addressTH: addressTHController.text,
      addressEN: addressENController.text,
      imgProfile:
          pickedProfileImagePath
              .value
              .isEmpty // ใช้รูปภาพที่เลือก หากมี
          ? (_authService
                    .currentUser
                    .value!
                    .imgProfile
                    .isEmpty // ถ้าไม่มีรูปภาพที่เลือก
                ? Assets
                      .assetsImgsProfile // และรูปภาพเดิมก็ไม่มี ให้ใช้ default
                : _authService.currentUser.value!.imgProfile) // ใช้รูปภาพเดิม
          : pickedProfileImagePath.value, // ใช้รูปภาพที่เลือกใหม่
    );

    _authService.updateUserProfile(updatedUser);
    Get.snackbar('สำเร็จ', 'บันทึกข้อมูลโปรไฟล์เรียบร้อยแล้ว');
    // Get.offNamedUntil(AppRoutes.PROFILE, (predicate) => false);
    Get.offNamed(AppRoutes.PROFILE); // กลับไปยังหน้า ProfilePage
    // Get.back(); // กลับไปยังหน้า ProfilePage(AppRoutes.PROFILE); // กลับไปยังหน้า ProfilePage
  }

  @override
  void onClose() {
    userNameController.dispose();
    employeeIdController.dispose();
    idCardController.dispose();
    sectionController.dispose();
    nameTitleController.dispose();
    nickNameController.dispose();
    firstNameTHController.dispose();
    lastNameTHController.dispose();
    firstNameENController.dispose();
    lastNameENController.dispose();
    sexController.dispose();
    birthdayController.dispose();
    birthplaceController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressTHController.dispose();
    addressENController.dispose();
    super.onClose();
  }
}
