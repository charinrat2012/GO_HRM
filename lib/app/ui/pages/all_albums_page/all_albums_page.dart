import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart'; // เพิ่ม import video_player
import 'package:open_filex/open_filex.dart'; // เพิ่ม import open_filex

import '../../../config/my_colors.dart';
import 'all_albums_controller.dart';
import '../../../data/models/chat_model.dart';
import 'package:url_launcher/url_launcher.dart';


class AllAlbumsPage extends GetView<AllAlbumsController> {
  const AllAlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( // [เพิ่ม] DefaultTabController เพื่อจัดการ TabBar
      initialIndex: controller.selectedTabIndex.value, // ตั้งค่าแท็บเริ่มต้น
      length: 3, // 3 แท็บ: รูป & วิดีโอ, ลิงก์, ไฟล์
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
              'รูปภาพ, วิดีโอ และไฟล์',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
            bottom: TabBar(
              labelColor: MyColors.blue2, // สีของข้อความแท็บที่เลือก
              unselectedLabelColor: Colors.grey, // สีของข้อความแท็บที่ไม่ได้เลือก
              indicatorColor: MyColors.blue2, // สีของเส้นใต้แท็บ
              onTap: (index) => controller.changeTab(index), // เมื่อแตะแท็บ ให้อัปเดต Controller
              tabs: const [
                Tab(text: 'รูป & วิดีโอ'),
                Tab(text: 'ลิงก์'),
                Tab(text: 'ไฟล์'),
              ],
            ),
          ),
          body: TabBarView( // [เพิ่ม] TabBarView สำหรับเนื้อหาแต่ละแท็บ
            children: [
              // แท็บ 1: รูปภาพและวิดีโอ
              Obx(() {
                final mediaPaths = [...controller.allMediaPaths, ...controller.allVideoPaths];
                mediaPaths.sort(); // Sort for consistent display

                if (mediaPaths.isEmpty) {
                  return const Center(
                    child: Text(
                      'ไม่มีรูปภาพหรือวิดีโอ',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: mediaPaths.length,
                  itemBuilder: (context, index) {
                    final path = mediaPaths[index];
                    return _MediaGridItem(path: path);
                  },
                );
              }),

              // แท็บ 2: ลิงก์
              Obx(() {
                if (controller.allLinkPaths.isEmpty) {
                  return const Center(
                    child: Text(
                      'ไม่มีลิงก์',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: controller.allLinkPaths.length,
                  itemBuilder: (context, index) {
                    final link = controller.allLinkPaths[index];
                    return _LinkListItem(link: link);
                  },
                );
              }),

              // แท็บ 3: ไฟล์ (PDF, Doc etc.)
              Obx(() {
                if (controller.allFileMessages.isEmpty) {
                  return const Center(
                    child: Text(
                      'ไม่มีไฟล์เอกสาร',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: controller.allFileMessages.length,
                  itemBuilder: (context, index) {
                    final message = controller.allFileMessages[index];
                    return _FileListItem(filePath: message.filePath!, fileName: message.fileName ?? message.filePath!.split('/').last);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget สำหรับแสดง Grid Item ของสื่อ (รูปภาพ/วิดีโอ)
class _MediaGridItem extends StatefulWidget {
  final String path;
  const _MediaGridItem({Key? key, required this.path}) : super(key: key);

  @override
  State<_MediaGridItem> createState() => _MediaGridItemState();
}

class _MediaGridItemState extends State<_MediaGridItem> {
  VideoPlayerController? _videoController;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    _isVideo =
        widget.path.toLowerCase().endsWith('.mp4') ||
        widget.path.toLowerCase().endsWith('.mov') ||
        widget.path.toLowerCase().endsWith('.webm');

    if (_isVideo) {
      if (widget.path.startsWith('assets/')) {
        _videoController = VideoPlayerController.asset(widget.path);
      } else {
        _videoController = VideoPlayerController.file(File(widget.path));
      }
      _videoController?.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAsset = widget.path.startsWith('assets/');

    return GestureDetector(
      onTap: () {
        // TODO: สามารถเพิ่ม logic เมื่อแตะสื่อ เช่น เปิดดูรูปใหญ่/เล่นวิดีโอ
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: _isVideo
            ? (_videoController != null && _videoController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    )
                  : Container(
                      color: Colors.black54,
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ))
            : (isAsset
                ? Image.asset(
                    widget.path,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  )
                : Image.file(
                    File(widget.path),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  )),
      ),
    );
  }
}

// Widget สำหรับแสดงรายการไฟล์เอกสาร
class _FileListItem extends StatelessWidget {
  final String filePath;
  final String fileName;

  const _FileListItem({
    Key? key,
    required this.filePath,
    required this.fileName,
  }) : super(key: key);

  IconData _getIconForFile(String path) {
    final extension = path.split('.').last.toLowerCase();
    if (extension == 'pdf') {
      return Icons.picture_as_pdf;
    } else if (extension == 'doc' || extension == 'docx') {
      return Icons.description;
    } else if (extension == 'xlsx') {
      return Icons.table_chart;
    } else if (extension == 'pptx') {
      return Icons.slideshow;
    } else if (extension == 'mp3' || extension == 'wav' || extension == 'aac') {
      return Icons.audiotrack;
    }
    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        leading: Icon(_getIconForFile(filePath), color: MyColors.blue2),
        title: Text(
          fileName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          'โหลดไฟล์ได้ถึง ${DateTime.now().add(const Duration(days: 7)).day}.${DateTime.now().add(const Duration(days: 7)).month}.${DateTime.now().add(const Duration(days: 7)).year} ${DateTime.now().hour}:${DateTime.now().minute}', // [แก้ไข] แสดงวันที่/เวลาในอนาคต (ตัวอย่าง)
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        trailing: const Icon(Icons.more_horiz, color: Colors.grey),
        onTap: () async { // [เพิ่ม] เพิ่ม onTap สำหรับเปิดไฟล์
          final result = await OpenFilex.open(filePath);
          if (result.type != ResultType.done) {
            Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถเปิดไฟล์ได้: ${result.message}');
          }
        },
      ),
    );
  }
}

// Widget สำหรับแสดงรายการ Link
class _LinkListItem extends StatelessWidget {
  final String link;

  const _LinkListItem({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        leading: const Icon(Icons.link, color: MyColors.blue2),
        title: Text(
          link,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.blue, // สีฟ้าสำหรับลิงก์
            decoration: TextDecoration.underline, // ขีดเส้นใต้
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () async {
          // เปิดลิงก์เมื่อแตะ
          if (await canLaunchUrl(Uri.parse(link))) {
            await launchUrl(Uri.parse(link));
          } else {
            Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถเปิดลิงก์ได้: $link');
          }
        },
      ),
    );
  }
}