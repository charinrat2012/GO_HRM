// lib/app/ui/pages/chat_detail_page/widgets/notes_summary_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart'; // ตรวจสอบเส้นทาง
import 'package:go_hrm/app/routes/app_routes.dart'; // ตรวจสอบเส้นทาง
import 'package:go_hrm/app/ui/pages/chat_detail_page/chat_detail_controller.dart'; // ตรวจสอบเส้นทาง
import 'package:go_hrm/app/data/models/note_model.dart'; // <<< เพิ่ม import NoteModel ที่นี่

class NotesSummaryCard extends GetView<ChatDetailController> {
  const NotesSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ถ้าไม่มีโน้ต ให้ซ่อนส่วนนี้ไปเลย
      if (controller.chat.notes.isEmpty) {
        return const SizedBox.shrink();
      }

      // ดึงโน้ตล่าสุด (เนื่องจากเราเพิ่มโน้ตใหม่ไปที่ตำแหน่ง 0)
      final NoteModel latestNote = controller.chat.notes.first;
      final int noteCount = controller.chat.notes.length;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        margin: const EdgeInsets.only(bottom: 8.0), // เพิ่มระยะห่างด้านล่างเล็กน้อย
        decoration: BoxDecoration(
          color: Colors.white, // สีพื้นหลัง
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200), // เส้นคั่นด้านล่าง
          ),
        ),
        child: InkWell( // ใช้ InkWell เพื่อให้การ์ดทั้งหมดสามารถกดได้และมี feedback
          onTap: () {
            // เมื่อกดที่การ์ด ให้ไปหน้า NotesPage เพื่อดูโน้ตทั้งหมด
            Get.toNamed(AppRoutes.NOTES, arguments: controller.chat);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // เพิ่ม padding ภายใน InkWell
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ไอคอนบ่งบอกว่าเป็นโน้ต
                const Icon(
                  Icons.assignment_outlined, // ไอคอนสำหรับโน้ต
                  color: MyColors.blue2,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // แสดงชื่อโน้ตล่าสุด
                      Text(
                        latestNote.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1, // แสดงแค่บรรทัดเดียว
                        overflow: TextOverflow.ellipsis,
                      ),
                      // แสดงเนื้อหาโน้ตย่อๆ (ถ้ามี)
                      if (latestNote.content.isNotEmpty)
                        Text(
                          latestNote.content,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1, // แสดงแค่บรรทัดเดียว
                          overflow: TextOverflow.ellipsis,
                        ),
                      // แสดงจำนวนโน้ตทั้งหมด
                      Text(
                        '$noteCount โน้ตในแชทนี้',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                // ปุ่ม "ดูทั้งหมด"
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.NOTES, arguments: controller.chat);
                  },
                  child: const Text(
                    'ดูทั้งหมด',
                    style: TextStyle(color: MyColors.blue2),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}