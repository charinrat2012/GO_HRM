
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
              // [แก้ไข] เข้าถึง chat.value.name
              title: Obx(
                () => Text(
                  // [เพิ่ม Obx] เพื่อให้ AppBar อัปเดตชื่อแชทได้หากมีการเปลี่ยนแปลง
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
                      // [แก้ไข] เข้าถึง chat.value.isGroup
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
                        Get.toNamed(
                          AppRoutes
                              .ALL_ALBUMS, // [แก้ไข] เปลี่ยนเป็น ALL_ALBUMS
                          arguments: {
                            // [แก้ไข] เข้าถึง controller.imagePaths และ controller.videoPaths
                            'imagePaths': controller.imagePaths,
                            'videoPaths': controller.videoPaths,
                            'fileMessages': controller
                                .fileMessages, // [เพิ่ม] ส่ง fileMessages ไป
                            'links': controller.links, // [เพิ่ม] ส่ง links ไป
                            'initialTab':
                                0, // [เพิ่ม] กำหนดแท็บเริ่มต้นเป็น "รูป & วิดีโอ"
                          },
                        );
                      }),
                      const SizedBox(height: 12.0),
                      Obx(() {
                        // [แก้ไข] เข้าถึง controller.imagePaths และ controller.videoPaths
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
                          isSmall:
                              true, // isSmall เป็น true สำหรับรูปภาพและวิดีโอทั่วไป
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            // "อัลบั้ม" section: ปรับปรุงส่วนนี้เพื่อแสดงรายการอัลบั้ม
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
                      // ส่วนหัว "อัลบั้ม" - นำทางไป AlbumsOverviewPage
                      _buildSectionHeader('อัลบั้ม', () {
                        // เมื่อกด "อัลบั้ม" จะนำทางไปยังหน้าแสดงรายการอัลบั้มทั้งหมด
                        Get.toNamed(
                          AppRoutes.ALBUMS_OVERVIEW,
                          // [แก้ไข] ส่ง controller.chat.value ไป
                          arguments: controller.chat.value,
                        );
                      }),
                      const SizedBox(height: 12.0),

                      // แสดง Thumbnail ของอัลบั้ม (หรือข้อความ "ไม่มีอัลบั้ม")
                      Obx(() {
                        // [แก้ไข] เข้าถึง controller.albums
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
                        // แสดงเฉพาะ 3 อัลบั้มแรก หรือน้อยกว่า (เพื่อใช้เป็น preview)
                        // [แก้ไข] เข้าถึง controller.albums
                        final displayAlbums = controller.albums
                            .take(3)
                            .toList();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: displayAlbums.map((album) {
                              // ใช้รูปแรกของแต่ละอัลบั้มเป็น thumbnail
                              final String thumbnailPath =
                                  album.imagePaths.isNotEmpty
                                  ? album.imagePaths.first
                                  : '';
                              return Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    // เมื่อแตะ thumbnail ของอัลบั้ม ให้ไปหน้า AlbumsOverviewPage
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.ALBUMS_OVERVIEW,
                                        // [แก้ไข] ส่ง controller.chat.value ไป
                                        arguments: controller.chat.value,
                                      );
                                    },
                                    child: _buildMediaWidget(
                                      thumbnailPath,
                                      isSmall: true, // [แก้ไข] เปลี่ยนเป็น true
                                    ), // isSmall เป็น false สำหรับ Thumbnail อัลบั้ม
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
                    // [แก้ไข] ส่ง controller.chat.value ไป
                    Get.toNamed(
                      AppRoutes.NOTES,
                      arguments: controller.chat.value,
                    );
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ลิงก์', () {
                    Get.toNamed(
                      // [เพิ่ม] นำทางไป AllAlbumsPage พร้อมส่งข้อมูล Link
                      AppRoutes.ALL_ALBUMS,
                      arguments: {
                        'imagePaths': controller.imagePaths,
                        'videoPaths': controller.videoPaths,
                        'fileMessages': controller.fileMessages,
                        'links': controller.links, // [เพิ่ม] ส่ง links ไป
                        'initialTab':
                            1, // [เพิ่ม] กำหนดแท็บเริ่มต้นเป็น "ลิงก์"
                      },
                    );
                  }),
                  const SizedBox(height: 8.0),
                  _buildMenuItemTile('ไฟล์', () {
                    Get.toNamed(
                      // [แก้ไข] นำทางไป AllAlbumsPage พร้อมส่งข้อมูลไฟล์
                      AppRoutes.ALL_ALBUMS,
                      arguments: {
                        'imagePaths': controller.imagePaths,
                        'videoPaths': controller.videoPaths,
                        'fileMessages': controller
                            .fileMessages, // [เพิ่ม] ส่ง fileMessages ไป
                        'links': controller.links, // [เพิ่ม] ส่ง links ไป
                        'initialTab': 2, // [เพิ่ม] กำหนดแท็บเริ่มต้นเป็น "ไฟล์"
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

  // Helper methods ของ MenuChatPage (ไม่มีการเปลี่ยนแปลงในส่วนนี้)
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
