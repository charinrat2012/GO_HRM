import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_hrm/app/config/my_colors.dart';

enum LeaveStatus { approved, pending, rejected }

class LeaveHistoryModel {
  final String title = 'ออกใบลา';
  final String leaveType;
  final String employeeName;
  final String leaveCategory;
  final DateTime requestDateTime;
  // final String? note;
  final LeaveStatus status;
  final List<File>? attachedFiles;

  LeaveHistoryModel({
    required this.leaveType,
    required this.employeeName,
    required this.leaveCategory,
    required this.requestDateTime,
    // this.note,
    required this.status,
    this.attachedFiles,
  });
  factory LeaveHistoryModel.fromMap(Map<String, dynamic> map) {
    return LeaveHistoryModel(
      leaveType: map['leaveType'] ?? '',
      employeeName: map['employeeName'] ?? '',
      leaveCategory: map['leaveCategory'] ?? '',
      requestDateTime: map['requestDateTime'] ?? '',
      status: map['status'] ?? '',
      attachedFiles: map['attachedFiles'] ?? [],
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
