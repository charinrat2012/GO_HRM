import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import '../../../data/models/note_model.dart'; // สำหรับ File

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteModel note = Get.arguments['note']; // รับ NoteModel ที่ส่งมา

    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดโน้ต'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงชื่อโน้ต
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // แสดงเนื้อหาโน้ต
            if (note.content.isNotEmpty)
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            if (note.content.isNotEmpty) const SizedBox(height: 16),

            // แสดงรูปภาพทั้งหมดใน GridView
            if (note.imagePaths.isNotEmpty)
              GridView.builder(
                shrinkWrap: true, // ทำให้ GridView ใช้พื้นที่เท่าที่จำเป็น
                physics: const NeverScrollableScrollPhysics(), // ปิดการเลื่อนของ GridView
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // แสดง 2 คอลัมน์ (ปรับได้ตามต้องการ)
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0, // อัตราส่วนของแต่ละช่องใน Grid (ทำให้เป็นสี่เหลี่ยมจัตุรัส)
                ),
                itemCount: note.imagePaths.length,
                itemBuilder: (context, index) {
                  final imagePath = note.imagePaths[index];
                  final bool isAsset = imagePath.startsWith('assets/');
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: isAsset
                        ? Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(color: Colors.grey[200], child: const Icon(Icons.broken_image));
                            },
                          )
                        : Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(color: Colors.grey[200], child: const Icon(Icons.broken_image));
                            },
                          ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}