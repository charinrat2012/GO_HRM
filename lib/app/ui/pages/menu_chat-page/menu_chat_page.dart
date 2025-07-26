import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../../routes/app_routes.dart';
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
              title: Obx(
                () => Text(
                  controller.chat.value.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
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
                      if (controller.chat.value.isGroup == true)
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
                        Get.toNamed(
                          AppRoutes.ALL_ALBUMS,
                          arguments: {
                            'chat': controller.chat.value, // Pass the entire Chat object
                            'initialTab': 0,
                          },
                        );
                      }),
                      const SizedBox(height: 12.0),
                      Obx(() {
                        final List<String> allMediaPaths = [
                          ...controller.imagePaths,
                          ...controller.videoPaths,
                        ];
                        allMediaPaths.sort();
                        final displayMediaPaths = allMediaPaths
                            .take(3)
                            .toList();
                        return _buildHorizontalMediaThumbnails(
                          displayMediaPaths,
                          isSmall: true,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
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
                          AppRoutes.ALBUMS_OVERVIEW,
                          arguments: controller.chat.value,
                        );
                      }),
                      const SizedBox(height: 12.0),

                      Obx(() {
                        if (controller.albums.isEmpty) {
                          return Container(
                            height: 120,
                            alignment: Alignment.center,
                            child: Text(
                              'ไม่มีอัลบั้ม',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                          );
                        }
                        final displayAlbums = controller.albums
                            .take(3)
                            .toList();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: displayAlbums.map((album) {
                              final String thumbnailPath =
                                  album.imagePaths.isNotEmpty
                                  ? album.imagePaths.first
                                  : '';
                              return Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.ALBUM_DETAIL,
                                        arguments: album,
                                      );
                                    },
                                    child: _buildMediaWidget(
                                      thumbnailPath,
                                      isSmall: true,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
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
                  _buildMenuItemTile('โน็ต', () {
                    Get.toNamed(
                      AppRoutes.NOTES,
                      arguments: controller.chat.value,
                    );
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ลิงก์', () {
                    Get.toNamed(
                      AppRoutes.ALL_ALBUMS,
                      arguments: {
                        'chat': controller.chat.value, // Pass the entire Chat object
                        'initialTab': 1,
                      },
                    );
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ไฟล์', () {
                    Get.toNamed(
                      AppRoutes.ALL_ALBUMS,
                      arguments: {
                        'chat': controller.chat.value, // Pass the entire Chat object
                        'initialTab': 2,
                      },
                    );
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

  // Helper methods of MenuChatPage (no changes in these methods)
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

  Widget _buildHorizontalMediaThumbnails(
    List<String> mediaPaths, {
    required bool isSmall, // กำหนด isSmall ชัดเจน
  }) {
    if (mediaPaths.isEmpty) {
      String emptyMessage = 'ไม่มีรูปภาพหรือวิดีโอ';
      // 'ไม่มีอัลบั้ม' จะถูกจัดการในส่วนของอัลบั้มโดยตรง ไม่ได้มาจากตรงนี้
      return Container(
        height: isSmall ? 120 : 120, // ใช้ isSmall กำหนดความสูง
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
              child: _buildMediaWidget(path, isSmall: isSmall), // แก้ไขตรงนี้
            ),
          );
        }).toList(),
      ),
    );
  }

  // แก้ไข signature ของ _buildMediaWidget ให้ isSmall เป็น named parameter
  Widget _buildMediaWidget(String path, {required bool isSmall}) {
    // *** แก้ไขตรงนี้ ***
    // กำหนดขนาดตาม isSmall
    final double width = isSmall ? 120 : 200;
    final double height = 120;

    if (path.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    }

    final bool isAsset = path.startsWith('assets/');
    final bool isVideo =
        path.toLowerCase().endsWith('.mp4') ||
        path.toLowerCase().endsWith('.mov') ||
        path.toLowerCase().endsWith('.webm');

    if (isVideo) {
      // แสดง Video placeholder หากเป็นวิดีโอ
      return Container(
        width: width,
        height: height,
        color: Colors.black54,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
            Text('Video', style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
      );
    } else {
      // แสดงรูปภาพ (Asset หรือ File)
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
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            );
          },
        );
      } else {
        // ตรวจสอบว่าไฟล์มีอยู่จริงก่อนพยายามโหลด
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
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              );
            },
          );
        } else {
          // หากไฟล์ไม่มีอยู่จริง ให้แสดง placeholder
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
          );
        }
      }
    }
  }

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