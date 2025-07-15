import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../create_leave_request_controller.dart';

// หมายเหตุ: ถึงแม้ชื่อไฟล์จะเป็น FilePickerRequest แต่โค้ดนี้ทำงานกับ image_picker
// ตามที่ได้แก้ไขใน Controller ไปแล้ว

class FilePickerRequest extends GetView<CreateLeaveRequestController> {
  const FilePickerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text(
          'แนบไฟล์',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        Obx(() {
          // ถ้ายังไม่มีไฟล์: แสดงกล่องอัปโหลดใหญ่
          if (controller.pickedFiles.isEmpty) {
            return _buildEmptyPicker();
          }
          // ถ้ามีไฟล์แล้ว: แสดงรายการไฟล์และปุ่มเพิ่ม
          else {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.pickedFiles.length,
                  itemBuilder: (context, index) {
                    final file = controller.pickedFiles[index];
                    return _buildFileListItem(file, index);
                  },
                ),
                const SizedBox(height: 12),
                _buildAddMoreFilesButton(),
              ],
            );
          }
        }),
      ],
    );
  }

  // --- Widget ใหม่: สำหรับแสดงกล่องอัปโหลดเมื่อยังไม่มีไฟล์ ---
  Widget _buildEmptyPicker() {
    return GestureDetector(
      onTap: controller.pickMultipleFiles, // เมื่อแตะ ให้เรียกฟังก์ชันเลือกรูป
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text('อัปโหลดรูปภาพหรือไฟล์', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }


 Widget _buildFileListItem(File file, int index) {
    final fileName = file.path.split('/').last;
    final fileExtension = fileName.contains('.') ? fileName.split('.').last.toLowerCase() : '';

    IconData getIconForFile(String extension) {
      if (['jpg', 'jpeg', 'png'].contains(extension)) {
        return Icons.image_outlined;
      } else if (extension == 'pdf') {
        return Icons.picture_as_pdf_outlined;
      } else if (['doc', 'docx'].contains(extension)) {
        return Icons.description_outlined;
      }
      return Icons.insert_drive_file_outlined;
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(getIconForFile(fileExtension), color: Colors.grey[700]),
        title: Text(
          fileName,
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.close, color: Colors.redAccent, size: 20),
          onPressed: () {
            controller.removeFile(index);
          },
        ),
      ),
    );
  }

  // Widget: ปุ่มสำหรับเพิ่มไฟล์อีก
  Widget _buildAddMoreFilesButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.add_circle_outline, size: 20),
        label: const Text('เพิ่มไฟล์แนบ'),
        onPressed: controller.pickMultipleFiles,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          foregroundColor: Colors.grey[700],
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
    );
  }
}
