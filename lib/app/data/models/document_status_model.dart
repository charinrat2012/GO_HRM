import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';

import '../../ui/global_widgets/datalist.dart';

enum DocumentStatus { approved, pending, rejected }

class DocumentHistoryModel {
  final String documentId;
  final String title = 'ขอเอกสาร';
  final String documentTypeId;
  final String employeeName;
  // final String docCategory;
  final DateTime requestDateTime;
  final String? note;
  final DocumentStatus status;
  final List<File>? attachedFiles;

  DocumentHistoryModel({
    required this.documentId,
    required this.documentTypeId,
    required this.employeeName,
    // required this.docCategory,
    required this.requestDateTime,
    this.note,
    required this.status,
    this.attachedFiles,
  });

  String get docCategory {
    final typeMap = DataList.docTypes.firstWhereOrNull(
      (element) => element['documentTypeId'] == documentTypeId,
    );
    return typeMap?['type'] as String? ?? 'ไม่พบประเภท';
  }

  factory DocumentHistoryModel.fromMap(Map<String, dynamic> map) {
    //  ดึงข้อมูล List จาก map ออกมาเก็บในตัวแปรชั่วคราว
    final filesData = map['attachedFiles'];
    //  ตรวจสอบว่า `filesData` เป็น `List` หรือไม่ ถ้าใช่ ให้แปลงเป็น `List<File>`
    //    ถ้าไม่ใช่ (เช่นเป็น null) ให้ `files` เป็น null
    final List<File>? files = filesData is List
        ? List<File>.from(filesData)
        : null;

    return DocumentHistoryModel(
      documentId: map['documentId'] ?? '',
      documentTypeId: map['documentTypeId'] ?? '',
      employeeName: map['employeeName'] ?? '',
      // docCategory: map['leaveCategory'] ?? '',
      requestDateTime: map['requestDateTime'] ?? DateTime.now(),
      note: map['note'] ?? '',
      status: map['status'] ?? DocumentStatus.pending,
      //  ใช้ `files` ที่แปลงชนิดข้อมูลแล้ว หรือถ้าเป็น null ให้ใช้ List ว่างแทน
      attachedFiles: files ?? [],
    );
  }
  String get statusText {
    switch (status) {
      case DocumentStatus.approved:
        return 'อนุมัติ';
      case DocumentStatus.pending:
        return 'รออนุมัติ';
      case DocumentStatus.rejected:
        return 'ไม่อนุมัติ';
    }
  }

  Color get statusBadgeColor {
    switch (status) {
      case DocumentStatus.approved:
        return Colors.blue[100]!;
      case DocumentStatus.pending:
        return Colors.grey.withValues(alpha: 0.1);
      case DocumentStatus.rejected:
        return Colors.red;
    }
  }

  Color get statusTextColor {
    switch (status) {
      case DocumentStatus.approved:
        return MyColors.blue2;
      case DocumentStatus.pending:
        return Colors.grey[600]!;
      case DocumentStatus.rejected:
        return Colors.white;
    }
  }
}
