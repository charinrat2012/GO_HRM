import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../edit_profile_controller.dart';

class EditDetailsProfile extends GetView<EditprofileController> {
  const EditDetailsProfile({super.key});

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
              _buildEditableTextField(
                label: 'ชื่อผู้ใช้งาน',
                textController: controller.userNameController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextField(
                label: 'รหัสพนักงาน',
                textController: controller.employeeIdController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextFieldRow(
                labelLeft: 'เลขบัตรประชาชน',
                textControllerLeft: controller.idCardController,
                labelRight: 'แผนก',
                textControllerRight: controller.sectionController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextFieldRow(
                labelLeft: 'คำนำหน้าชื่อ',
                textControllerLeft: controller.nameTitleController,
                labelRight: 'ชื่อเล่น',
                textControllerRight: controller.nickNameController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextFieldRow(
                labelLeft: 'ชื่อจริง (ไทย)',
                textControllerLeft: controller.firstNameTHController,
                labelRight: 'นามสกุล (ไทย)',
                textControllerRight: controller.lastNameTHController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextFieldRow(
                labelLeft: 'ชื่อจริง (อังกฤษ)',
                textControllerLeft: controller.firstNameENController,
                labelRight: 'นามสกุล (อังกฤษ)',
                textControllerRight: controller.lastNameENController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextFieldRow(
                labelLeft: 'เพศ',
                textControllerLeft: controller.sexController,
                labelRight: 'วันเดือนปีเกิด',
                textControllerRight: controller.birthdayController,
                isDatePicker: true, // กรอกข้อความสำหรับเลือกวันเดือนปี
              ),
              const SizedBox(height: 16),
              _buildEditableTextFieldRow(
                labelLeft: 'สถานที่เกิด',
                textControllerLeft: controller.birthplaceController,
                labelRight: 'อายุ',
                textControllerRight: controller.ageController,
              ),
              const SizedBox(height: 16),
              _buildEditableTextField(
                label: 'อีเมล',
                textController: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildEditableTextField(
                label: 'เบอร์โทรศัพท์มือถือ',
                textController: controller.phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildEditableTextField(
                label: 'ที่อยู่ (ไทย)',
                textController: controller.addressTHController,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              _buildEditableTextField(
                label: 'ที่อยู่ (อังกฤษ)',
                textController: controller.addressENController,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableTextField({
    required String label,
    required TextEditingController textController,
    int? maxLines,
    TextInputType?
    keyboardType, //ประเภทของแป้นพิมพ์ที่จะแสดงขึ้นมาเมื่อผู้ใช้แตะที่ช่องกรอกข้อมูล
    bool isDatePicker =
        false, // true คือ  แสดง ช่องเลือกวันที่ และเมื่อแตะจะแสดง ปฏิทิน ขึ้นมา false ช่องกรอกข้อความปกติไม่เสดงปฎิทิน
  }) {
    maxLines =
        maxLines ??
        1; //คือกำหนดเริ่มต้นไว้ 1 บรรทัดถ้าเกินจะไม่ขยายช่องแต่จะไปต่อบรรทัดใหม่แทน
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //หัวข้อ
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: textController,
          readOnly:
              isDatePicker, // true (คือช่องเลือกวันที่) ผู้ใช้จะไม่สามารถพิมพ์ข้อความลงไปได้ อ่านได้อย่างเดียว //false ช่องนี้จะสามารถแก้ไขไดh
          onTap: isDatePicker
              ? () => controller.selectDate(Get.context!, textController)
              : null,
          keyboardType: keyboardType, //แป้นพิมพ์เป็นตัวเลข
          maxLines: maxLines, // ถ้าข้อความทเกินจะขึ้นบรรทัดใหม่
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            //แสดงปฏิทินในช่องกรอก
            suffixIcon: isDatePicker
                ? const Icon(Icons.calendar_today_outlined)
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildEditableTextFieldRow({
    required String labelLeft,
    required TextEditingController textControllerLeft,
    required String labelRight,
    required TextEditingController textControllerRight,
    bool isDatePicker = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildEditableTextField(
            label:
                labelLeft, //ช่องกรอกข้อมูลทางซ้าย เช่น เพศ //ตรวจสอบว่า ป้ายกำกับทาซ้าย วันเดือนปีเกิด อยู่หรือไม่
            textController: textControllerLeft,
            isDatePicker: isDatePicker && labelLeft.contains('วันเดือนปีเกิด'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildEditableTextField(
            label:
                labelRight, //ช่องกรอกข้อมูลทางขวาเช่น วันเดือนปีเกิดตรวจสอบทางขวามีคำว่า วันเดือนปีเกิด อยู่หรือไม่
            textController: textControllerRight,
            isDatePicker: isDatePicker && labelRight.contains('วันเดือนปีเกิด'),
          ),
        ),
      ],
    );
  }
}
