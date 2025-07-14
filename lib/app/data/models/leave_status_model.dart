
import 'package:flutter/material.dart';

enum LeaveStatus { approved, pending, rejected }


class LeaveHistoryModel {
  final String title = 'ออกใบลา';
  final String leaveType;
  final String employeeName;
  final String leaveCategory;
  final DateTime requestDateTime;
  final String? note;
  final LeaveStatus status;

  LeaveHistoryModel({
    required this.leaveType,
    required this.employeeName,
    required this.leaveCategory,
    required this.requestDateTime,
    this.note,
    required this.status,
  });

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
        return Colors.green[800]!;
      case LeaveStatus.pending:
        return Colors.grey.withValues(alpha: 0.1);
      case LeaveStatus.rejected:
        return Colors.red;
    }
  }

  Color get statusTextColor {
    switch (status) {
      case LeaveStatus.approved:
        return Colors.white;
      case LeaveStatus.pending:
        return Colors.grey[600]!;
      case LeaveStatus.rejected:
        return Colors.white;
    }
  }
}