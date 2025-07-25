// Path: lib/app/ui/pages/menu_chat-page/menu_chat_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io'; // Import dart:io for File

import '../../../routes/app_routes.dart'; // เพิ่ม import นี้
import 'menu_chat_controller.dart';

class MenuChatPage extends GetView<MenuChatController> {
  const MenuChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
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
              title: Text(
                // No Obx here as controller.chat.name is not reactive
                controller
                    .chat
                    .name, // Use the chat name from the controller directly
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              pinned: true,
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionColumn(
                        icon: Icons.volume_off,
                        label: 'ปิดแจ้งเตือน',
                        onPressed: () {},
                      ),
                      if (controller.chat.isGroup == true)
                        _buildActionColumn(
                          icon: Icons.group,
                          label: 'กลุ่ม',
                          onPressed: () {},
                        ),

                      _buildActionColumn(
                        icon: Icons.person_add,
                        label: 'เชิญ',
                        onPressed: () {},
                      ),
                      _buildActionColumn(
                        icon: Icons.logout,
                        label: 'ออก',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Combined "รูปภาพและวิดีโอ" section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('รูปภาพและวิดีโอ', () {
                        // TODO: Navigate to a page showing all images and videos
                        Get.toNamed(
                          AppRoutes.ALL_MEDIA,
                          arguments: {
                            'imagePaths': controller.imagePaths,
                            'videoPaths': controller.videoPaths,
                          },
                        );
                      }),
                      const SizedBox(height: 12.0),
                      Obx(() {
                        // Combine both lists for display
                        final List<String> allMediaPaths = [
                          ...controller.imagePaths,
                          ...controller.videoPaths,
                        ];
                        // Sort them, perhaps by path to ensure consistent order
                        allMediaPaths.sort();
                        // แสดงเพียง 3 รายการแรก
                        final displayMediaPaths = allMediaPaths
                            .take(3)
                            .toList();
                        return _buildHorizontalMediaThumbnails(
                          displayMediaPaths, // ใช้ displayMediaPaths
                          isSmall: true,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            // Restore "อัลบั้ม" section with its original hardcoded content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('อัลบั้ม', () {
                        Get.toNamed(
                          AppRoutes.ALL_ALBUMS,
                          arguments: [
                            'assets/imgs/pic1.jpg',
                            'assets/imgs/pic2.jpg',
                            'assets/imgs/pic3.jpg',
                            'assets/imgs/pic4.jpg',
                            'assets/imgs/pic5.jpg',
                          ],
                        );
                      }),
                      const SizedBox(height: 12.0),

                      _buildHorizontalMediaThumbnails(
                        [
                          'assets/imgs/pic1.jpg',
                          'assets/imgs/pic2.jpg',
                          'assets/imgs/pic3.jpg',
                        ].take(3).toList(), // แสดงเพียง 3 รายการแรก
                        isSmall: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildMenuItemTile('กิจกรรม', () {
                    /* handle tap */
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('โหมด', () {
                    /* handle tap */
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ลิงก์', () {
                    /* handle tap */
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ไฟล์', () {
                    /* handle tap */
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ตั้งค่า', () {
                    /* handle tap */
                  }),
                  const SizedBox(height: 60.0),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method สำหรับสร้าง Column ของไอคอนพร้อมข้อความ
  Widget _buildActionColumn({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.black, size: 28),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 12)),
      ],
    );
  }

  // Helper method สำหรับสร้างส่วนหัวที่มีชื่อและลูกศร
  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Modified Helper method สำหรับแสดงรูปภาพและวิดีโอแบบแนวนอน
  Widget _buildHorizontalMediaThumbnails(
    List<String> mediaPaths, {
    bool isSmall = true,
  }) {
    if (mediaPaths.isEmpty) {
      // Determine what type of media is expected for the empty message
      String emptyMessage;
      if (isSmall) {
        // This is typically for combined images/videos from chat
        emptyMessage = 'ไม่มีรูปภาพหรือวิดีโอ';
      } else {
        // This is typically for "อัลบั้ม" (which was originally just images)
        emptyMessage = 'ไม่มีอัลบั้ม';
      }

      return Container(
        height: isSmall ? 120 : 120, // Consistent height for empty state
        alignment: Alignment.center,
        child: Text(
          emptyMessage,
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: mediaPaths.map((path) {
          return Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // Pass mediaType dynamically based on file extension
              child: _buildMediaWidget(path, isSmall),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper method สำหรับตัดสินใจว่าจะแสดงรูปภาพจาก asset หรือจากไฟล์ และแสดง placeholder สำหรับวิดีโอ
  Widget _buildMediaWidget(String path, bool isSmall) {
    final bool isAsset = path.startsWith('assets/');
    final double width = isSmall ? 120 : 200;
    final double height = 120; // ความสูงคงที่

    // Determine if it's a video based on extension
    final isVideo =
        path.toLowerCase().endsWith('.mp4') ||
        path.toLowerCase().endsWith('.mov') ||
        path.toLowerCase().endsWith('.webm');

    if (isVideo) {
      return Container(
        width: width,
        height: height,
        color: Colors.black54, // Dark background for video thumbnail
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
            Text('Video', style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
      );
    } else {
      // It's an image
      if (isAsset) {
        return Image.asset(
          path,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
          },
        );
      } else {
        final File file = File(path);
        if (file.existsSync()) {
          return Image.file(
            file,
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              );
            },
          );
        } else {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
        }
      }
    }
  }

  // Menu item tile (no change)
  Widget _buildMenuItemTile(String title, VoidCallback onTap) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
