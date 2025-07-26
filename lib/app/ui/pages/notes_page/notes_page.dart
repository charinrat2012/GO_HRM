// lib/app/ui/pages/notes_page/notes_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/note_model.dart';
import '../../../routes/app_routes.dart';
import 'notes_controller.dart';
import '../../../data/services/auth_service.dart';
import '../../../ui/utils/assets.dart';
import 'package:intl/intl.dart';

class NotesPage extends GetView<NotesController> {
  const NotesPage({super.key});

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
            'โน้ต',
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
          if (controller.chat.notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ยังไม่มีโน้ต',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Removed the centered "เพิ่มโน้ต" button, FAB will handle this
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            itemCount: controller.chat.notes.length,
            itemBuilder: (context, index) {
              final note = controller.chat.notes[index];
              return _buildNoteItem(note);
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.CREATE_NOTE, arguments: controller.chat);
          },
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNoteItem(NoteModel note) {
    final AuthService _authService = Get.find<AuthService>();
    final currentUser = _authService.currentUser.value;

    final bool isCurrentUserNote = currentUser != null && note.senderId == currentUser.userId;

    final String displayName = isCurrentUserNote ? currentUser!.userName : note.senderName;
    final String displayImageUrl = isCurrentUserNote && currentUser!.imgProfile.isNotEmpty
        ? currentUser.imgProfile
        : note.senderImageUrl;
    String _formatNoteCreationDate(String noteId) {
      try {
        final int milliseconds = int.parse(noteId);
        final DateTime creationDateTime =
            DateTime.fromMillisecondsSinceEpoch(milliseconds);
        return DateFormat('dd/MM/yyyy HH:mm').format(creationDateTime);
      } catch (e) {
        return 'Invalid Date';
      }
    }
    ImageProvider avatarImage;
    if (displayImageUrl.startsWith('assets/')) {
      avatarImage = AssetImage(displayImageUrl);
    } else {
      final File imageFile = File(displayImageUrl);
      if (imageFile.existsSync()) {
        avatarImage = FileImage(imageFile);
      } else {
        avatarImage = const AssetImage(Assets.assetsImgsProfile);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: Color.fromRGBO(204, 218, 255, 1),
            width: 1.0,
          ),
        ),
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.NOTE_DETAIL, arguments: {'note': note});
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: avatarImage,
                      onBackgroundImageError: (exception, stackTrace) {
                        // Fallback to default if there's an error loading the image
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatNoteCreationDate(note.id),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                      onPressed: () {
                        Get.bottomSheet(
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('แก้ไขโน้ต'),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(AppRoutes.EDIT_NOTE, arguments: {'note': note, 'chat': controller.chat});
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete, color: Colors.red),
                                  title: const Text('ลบโน้ต', style: TextStyle(color: Colors.red)),
                                  onTap: () {
                                    Get.back();
                                    controller.deleteNote(note.id);
                                  },
                                ),
                              ],
                            ),
                          )
                        );
                      },
                    ),
                  ],
                ),
                if (note.imagePaths.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: note.imagePaths.first.startsWith('assets/')
                          ? Image.asset(
                              note.imagePaths.first,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 120, // [แก้ไข] กำหนดความสูงให้เป็น 120
                              errorBuilder: (context, error, stackTrace) {
                                return Container(color: Colors.grey[200], child: const Icon(Icons.broken_image));
                              },
                            )
                          : Image.file(
                              File(note.imagePaths.first),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 120, // [แก้ไข] กำหนดความสูงให้เป็น 120
                              errorBuilder: (context, error, stackTrace) {
                                return Container(color: Colors.grey[200], child: const Icon(Icons.broken_image));
                              },
                            ),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (note.content.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        note.content,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}