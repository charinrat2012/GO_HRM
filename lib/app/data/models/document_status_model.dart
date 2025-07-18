import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_hrm/app/config/my_colors.dart';

enum DocumentStatus { approved, pending, rejected }

class DocumentHistoryModel {
  final String title = 'ออกใบลา';
  final String leaveType;
  final String employeeName;
  final String leaveCategory;
  final DateTime requestDateTime;
  final String? note;
  final DocumentStatus status;
  final List<File>? attachedFiles;

  DocumentHistoryModel({
    required this.leaveType,
    required this.employeeName,
    required this.leaveCategory,
    required this.requestDateTime,
    this.note,
    required this.status,
    this.attachedFiles,
  });
  factory DocumentHistoryModel.fromMap(Map<String, dynamic> map) {
    return DocumentHistoryModel(
      leaveType: map['leaveType'] ?? '',
      employeeName: map['employeeName'] ?? '',
      leaveCategory: map['leaveCategory'] ?? '',
      requestDateTime: map['requestDateTime'] ?? '',
      note: map['note'] ?? '',
      status: map['status'] ?? '',
      attachedFiles: map['attachedFiles'] ?? [],
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
