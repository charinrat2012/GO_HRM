import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';

import '../../ui/global_widgets/datalist.dart';

enum LeaveStatus { approved, pending, rejected }

class LeaveHistoryModel {
  final String leaveId;
  final String title = 'ออกใบลา';
  final String leaveTypeId;
  final String employeeName;
  // final String leaveCategory;
  final DateTime requestDateTime;
  // final String? note;
  final LeaveStatus status;
  final List<File>? attachedFiles;

  LeaveHistoryModel({
    required this.leaveId,
    required this.leaveTypeId,
    required this.employeeName,
    // required this.leaveCategory,
    required this.requestDateTime,
    // this.note,
    required this.status,
    this.attachedFiles,
  });
    String get leaveCategory {
    final typeMap = DataList.leaveTypes.firstWhereOrNull(
      (element) => element['leaveTypeId'] == leaveTypeId,
    );
    return typeMap?['type'] as String? ?? 'ไม่พบประเภท';
  }
  factory LeaveHistoryModel.fromMap(Map<String, dynamic> map) {
    //  ดึงข้อมูล List จาก map ออกมาเก็บในตัวแปรชั่วคราว
    final filesData = map['attachedFiles'];
    //  ตรวจสอบว่า `filesData` เป็น `List` หรือไม่ ถ้าใช่ ให้แปลงเป็น `List<File>`
    //    ถ้าไม่ใช่ (เช่นเป็น null) ให้ `files` เป็น null
    final List<File>? files = filesData is List
        ? List<File>.from(filesData)
        : null;

    return LeaveHistoryModel(
      leaveId: map['leaveId'] ?? '',
      leaveTypeId: map['leaveTypeId'] ?? '',
      employeeName: map['employeeName'] ?? '',
      // leaveCategory: map['leaveCategory'] ?? '',
      requestDateTime: map['requestDateTime'] ?? DateTime.now(),
      // note: map['note'] ?? '',
      status: map['status'] ?? LeaveStatus.pending,
      //  ใช้ `files` ที่แปลงชนิดข้อมูลแล้ว หรือถ้าเป็น null ให้ใช้ List ว่างแทน
      attachedFiles: files ?? [],
    );
  }
  String get statusText {
    switch (status) {
      case LeaveStatus.approved:
        return 'อนุมัติ';
      case LeaveStatus.pending:
        return 'รออนุมัติ';
      case LeaveStatus.rejected:
        return 'ไม่อนุมัติ';
    }
  }

  Color get statusBadgeColor {
    switch (status) {
      case LeaveStatus.approved:
        return Colors.blue[100]!;
      case LeaveStatus.pending:
        return Colors.grey.withValues(alpha: 0.1);
      case LeaveStatus.rejected:
        return Colors.red;
    }
  }

  Color get statusTextColor {
    switch (status) {
      case LeaveStatus.approved:
        return MyColors.blue2;
      case LeaveStatus.pending:
        return Colors.grey[600]!;
      case LeaveStatus.rejected:
        return Colors.white;
    }
  }
}
