import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'meeting_detail_page_controller.dart';

class MeetingDetailPage extends GetView<MeetingDetailPageController> {
  const MeetingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: false,
              pinned: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 14.0,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              title: const Text(
                'รายละเอียดกิจกรรม',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),

            // 1. ส่วนของกรอบสีขาวแรกสุด ("ประชุมกับผู้บริหาร")
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Card(
                  // เปลี่ยนจาก Container มาใช้ Card
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ), // ลด padding เพื่อให้เหมาะสมกับ ListTile
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          // ใช้ ListTile สำหรับหัวข้อและเวลา
                          title: const Text(
                            'ประชุมกับผู้บริหาร',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16, // ปรับขนาดฟอนต์ให้เหมาะสม
                            ),
                          ),
                          trailing: const Text(
                            '10.30 - 11.30',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ), // ปรับขนาดฟอนต์ให้เหมาะสม
                          ),
                          contentPadding: EdgeInsets
                              .zero, // ลบ padding เริ่มต้นของ ListTile
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ), // เพิ่ม padding เพื่อให้เนื้อหาจัดแนว
                          child: Text(
                            // ใช้ Text สำหรับวันที่
                            'วันศุกร์ที่ 25/06/2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ), // ปรับขนาดและสีฟอนต์
                          ),
                        ),
                        ListTile(
                          // ใช้ ListTile สำหรับหมายเหตุ
                          title: const Text(
                            'หมายเหตุ :',
                            style: TextStyle(
                              fontSize: 14, // ปรับขนาดฟอนต์ให้เหมาะสม
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          trailing: const Text(
                            'นัดประชุมสำคัญ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ), // ปรับขนาดฟอนต์ให้เหมาะสม
                          ),
                          contentPadding: EdgeInsets
                              .zero, // ลบ padding เริ่มต้นของ ListTile
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 2. ส่วนของ "อีเมล"
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'อีเมล',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/ics/gmail.png',
                          height: 24,
                          width: 24,
                        ),
                        title: const Text(
                          'Natthatoddrill@gmail.com',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. ส่วนของ "ประเภทการเข้าประชุม"
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ประเภทการเข้าประชุม',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/ics/meet.png',
                            height: 24,
                            width: 24,
                          ),
                          title: const Text(
                            'เข้าร่วมโดย Google Meet',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          trailing: const Icon(Icons.link, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. ส่วนของ "เริ่มเวลา"
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'เริ่มเวลา',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.zero,
                      child: const ListTile(
                        title: Text(
                          'เข้าร่วมการประชุมก่อน 10 นาที',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        trailing: Icon(
                          Icons.notifications_none,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 5. ส่วนของ "อัปเดต"
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'อัปเดต',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      // เปลี่ยนจาก Container มาใช้ Card
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUpdateItem(
                            '1.สร้างหน้าโปรไฟล์ใหม่ (มีการค้นหาที่มากขึ้น) และแสดงการตอบกลับ ตั้งค่าหน้าใหม่ อีกครั้ง (เพิ่มเติมของเดิม)',
                          ),
                          _buildUpdateItem(
                            '2.ปรับแบบฟอร์มการเข้าและการเวลา งานใหม่',
                          ),
                          _buildUpdateItem(
                            '3.รื้อหน้าบัญชีและการโอนเงิน (สลิปโอนเงิน)',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 6. ส่วนของ "แนบไฟล์"
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
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
            ),

            // 7. ส่วนของ "ผู้เข้าร่วม"
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ผู้เข้าร่วม',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      // เปลี่ยนจาก Container มาใช้ Card
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _buildAttendeeTile(
                            'Natthadol Thavachpongsri',
                            'Natthatoddrill@gmail.com',
                            'assets/imgs/pic1.jpg',
                          ),
                          _buildAttendeeTile(
                            'Treesa Wattanakosol',
                            'Wattanakosol@gmail.com',
                            'assets/imgs/pic2.jpg',
                          ),
                          _buildAttendeeTile(
                            'Suthida Kittipattra',
                            'Kittipattra.burnd@gmail.com',
                            'assets/imgs/pic3.jpg',
                          ),
                          _buildAttendeeTile(
                            'Chanoknan Prangsueb',
                            'Chanoknan.look@gmail.com',
                            'assets/imgs/pic4.jpg',
                          ),
                          _buildAttendeeTile(
                            'Weerapol Udomaek',
                            'Weerapol.pungsith@gmail.com',
                            'assets/imgs/pic5.jpg',
                          ),
                          _buildAttendeeTile(
                            'Thammika Pichaiyuthasak',
                            'Pichaiyuthasak.kula@gmail.com',
                            'assets/imgs/pic6.jpg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String text) {
    return ListTile(
      // เปลี่ยนจาก Padding(Text) มาใช้ ListTile
      title: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 0.0,
      ), // ปรับ padding
      dense: true, // ทำให้ ListTile กระชับขึ้น
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
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'อัปโหลดรูปภาพหรือไฟล์',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildAttendeeTile(String name, String email, String avatarPath) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            radius: 20,
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          subtitle: Text(email, style: const TextStyle(color: Colors.grey)),
          trailing: const Icon(Icons.mail_outline, color: Colors.grey),
        ),
      ],
    );
  }
}
