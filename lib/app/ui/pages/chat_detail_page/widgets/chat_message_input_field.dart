import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/my_colors.dart';

import '../chat_detail_controller.dart';

class ChatMessageInputField extends GetView<ChatDetailController> {
  const ChatMessageInputField({super.key});
// แถบสำหรับพิมพ์ข้อความและปุ่มสำหรับส่งไฟล์แนบต่างๆ ในหน้าจอแชทของแอปพลิเคชัน
//ช่องสำหรับพิมพ์ข้อความ (Text Field): ผู้ใช้สามารถพิมพ์ข้อความที่ต้องการส่งได้
//ปุ่มสำหรับแนบไฟล์และสื่อต่างๆ: เช่น ปุ่มเพิ่ม (สำหรับไฟล์ทั่วไป), ปุ่มกล้อง (สำหรับถ่ายรูป/วิดีโอ), ปุ่มรูปภาพ (สำหรับเลือกจากแกลเลอรี)
//ปุ่มไมโครโฟน: สามารถใช้เพื่อเริ่มหรือหยุดการบันทึกเสียงได้ และไอคอนจะเปลี่ยนไปตามสถานะการอัดเสียง
//ปุ่มอีโมจิ/คีย์บอร์ด: ผู้ใช้สามารถสลับระหว่างการใช้แป้นพิมพ์ปกติกับการแสดงตัวเลือกอีโมจิได้
//ปุ่มส่ง: สำหรับส่งข้อความที่พิมพ์หรือไฟล์ที่แนบมา
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: MyColors.blue2, size: 22),
              onPressed: controller.showAttachmentOptions,
              style: ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: MyColors.blue2,
                size: 22,
              ),
              onPressed: controller.showCameraOptions,
              style: ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            IconButton(
              icon: const Icon(
                Icons.image_outlined,
                color: MyColors.blue2,
                size: 22,
              ),
              onPressed: () => controller.pickImage(ImageSource.gallery),
              style: ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.isRecording.value
                      ? Icons.stop_circle
                      : Icons.mic_none,
                  color: controller.isRecording.value
                      ? Colors.red
                      : MyColors.blue2,
                  size: 22,
                ),
                onPressed: controller.handleMicrophone,
                style: ButtonStyle(visualDensity: VisualDensity.compact),
              ),
            ),
            Expanded(
              child: TextField(
                focusNode: controller.focusNode,
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'พิมพ์',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(204, 218, 255, 1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(204, 218, 255, 1),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(204, 218, 255, 1),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.toggleEmojiKeyboard,
                    icon: Obx(
                      () => Icon(
                        controller.isEmojiPickerVisible.value
                            ? Icons.keyboard
                            : Icons.emoji_emotions_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: MyColors.blue2, size: 22),
              onPressed: controller.sendTextMessage,
            ),
          ],
        ),
      ),
    );
  }
}