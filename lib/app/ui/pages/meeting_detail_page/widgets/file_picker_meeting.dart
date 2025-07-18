import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/my_colors.dart';
import '../meeting_detail_controller.dart';

class FilePickerMeeting extends GetView<MeetingDetailController> {
  const FilePickerMeeting({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'แนบไฟล์',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (controller.pickedFiles.isEmpty) {
                return _buildEmptyPicker();
              } else {
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
        ),
      ),
    );
  }

  Widget _buildEmptyPicker() {
    return GestureDetector(
      onTap: controller.pickMultipleFiles,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color.fromRGBO(204, 218, 255, 1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 30, color: MyColors.blue),
            const SizedBox(height: 8),
            Text(
              'อัปโหลดรูปภาพหรือไฟล์',
              style: TextStyle(fontSize: 12, color: MyColors.blue),
            ),
          ],
        ),
      ),
    );
  }

  //ตรวจดูว่าไฟล์นั้นมีจุดหรือไม่ถ้ามีก็แยกจุดออกมาและแปลนามสกุลไฟล์ จากตัวใหญ่ให้เป็นตัวเล็ก
  Widget _buildFileListItem(File file, int index) {
    final fileName = file.path.split('/').last;
    final fileExtension = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : '';

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
      color: Colors.white, //สีพื้นหลังของการ์ด
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]!), //เส้นกรอบ
      ),
      margin: const EdgeInsets.only(bottom: 8), //ระยะห่างระหว่างการ์ด
      child: ListTile(
        leading: Icon(
          getIconForFile(fileExtension),
          color: Colors.grey[700],
        ), //lีicon แล้วเปลี่ยนiconจากนามสกุลไฟล์นั้นๆ
        title: Text(
          fileName,
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.ellipsis, //ชื่อยาวเกินแสดงจุด
        ),
        trailing: IconButton(
          visualDensity: VisualDensity.compact, //ปุ่มมีขนาดพอดี
          icon: const Icon(Icons.close, color: Colors.redAccent, size: 20),
          onPressed: () {
            // ปุ่มลบไฟล์
            controller.removeFile(index);
          },
        ),
      ),
    );
  }

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
