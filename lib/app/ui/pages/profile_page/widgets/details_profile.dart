import 'package:flutter/material.dart';
import 'package:go_hrm/app/data/models/user_model.dart';

class DetailsProfile extends StatelessWidget {
  final UserModel user;
  const DetailsProfile({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // เปลี่ยนจาก hardcoded text มาใช้ข้อมูลจาก `user` object
              _buildProfileTextField(
                label: 'ชื่อผู้ใช้งาน',
                filledText: user.userName,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'รหัสพนักงาน',
                filledText: user.employeeId,
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'เลขบัตรประชาชน',
                filledTextLeft: user.idCard,
                labelRight: 'แผนก',
                filledTextRight: user.section,
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'คำนำหน้าชื่อ',
                filledTextLeft: user.nameTitle,
                labelRight: 'ชื่อเล่น',
                filledTextRight: user.nickName,
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'ชื่อจริง (ไทย)',
                filledTextLeft: user.firstNameTH,
                labelRight: 'นามสกุล (ไทย)',
                filledTextRight: user.lastNameTH,
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'ชื่อจริง (อังกฤษ)',
                filledTextLeft: user.firstNameEN,
                labelRight: 'นามสกุล (อังกฤษ)',
                filledTextRight: user.lastNameEN,
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'เพศ',
                filledTextLeft: user.sex,
                labelRight: 'วันเดือนปีเกิด',
                filledTextRight: user.birthday,
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'สถานที่เกิด',
                filledTextLeft: user.birthplace,
                labelRight: 'อายุ',
                filledTextRight: user.age,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'อีเมล',
                filledText: user.email,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'เบอร์โทรศัพท์มือถือ',
                filledText: user.phone,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'ที่อยู่ (ไทย)',
                filledText: user.addressTH,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'ที่อยู่ (อังกฤษ)',
                filledText: user.addressEN,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTextField({
    required String label,
    required String filledText,
    int? maxLines,
  }) {
    maxLines = maxLines ?? 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          readOnly: true,
          controller: TextEditingController(text: filledText),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            
            )),

        ),
      ],
    );
  }

  Widget _buildProfileTextFieldRow({
    required String labelLeft,
    required String filledTextLeft,
    required String labelRight,
    required String filledTextRight,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildProfileTextField(
            label: labelLeft,
            filledText: filledTextLeft,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildProfileTextField(
            label: labelRight,
            filledText: filledTextRight,
          ),
        ),
      ],
    );
  }
}
