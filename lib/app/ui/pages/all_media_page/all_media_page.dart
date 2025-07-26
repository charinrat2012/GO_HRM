import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'all_media_controller.dart';

class AllMediaPage extends GetView<AllMediaController> {
  const AllMediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            'รูปภาพและวิดีโอทั้งหมด',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Obx(() {
          if (controller.allMediaPaths.isEmpty) {
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
            ),
            itemCount: controller.allMediaPaths.length,
            itemBuilder: (context, index) {
              final path = controller.allMediaPaths[index];
              return _MediaGridItem(
                path: path,
              ); // ใช้ Widget ย่อยสำหรับแสดงรูปภาพ
            },
          );
        }),
      ),
    );
  }
}

class _MediaGridItem extends StatefulWidget {
  final String path; //เส้นทางของรู)ภาพ
  const _MediaGridItem({Key? key, required this.path})
    : super(key: key); //เส้นทางของรูปภาพ และนำรูปภาพนั้นๆไปแสดง

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
    return GestureDetector(
      onTap: () {},
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
            : Image.file(
                File(widget.path),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
      ),
    );
  }
}
