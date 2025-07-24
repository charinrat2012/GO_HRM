// lib/app/data/models/appeal_status_model.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';

import '../../ui/global_widgets/datalist.dart';

enum AppealStatus { approved, pending, rejected }
enum AppealTitle { request, report }

class AppealHistoryModel {
  final String appealId;
  final String title = 'Request';
  // final AppealTitle appealTitle;
  final String appealTypeId;

  final String employeeName;
  // final String appealCategory;
  final DateTime requestDateTime;
  final String? note;
  final AppealStatus status;
  final List<File>? attachedFiles;

  AppealHistoryModel({
    required this.appealId,
    // required this.title,
    // required this.appealTitle,
    required this.appealTypeId,
    required this.employeeName,
    // required this.appealCategory,
    required this.requestDateTime,
    this.note,
    required this.status,
    this.attachedFiles,
  });
 String get appealCategory {
    // ใช้ firstWhereOrNull เพื่อค้นหา Map ที่ตรงกัน ถ้าไม่เจอจะคืนค่า null
    final typeMap = DataList.appealTypes.firstWhereOrNull(
      (element) => element['appealTypeId'] == appealTypeId,
    );
    // ถ้าเจอ Map (typeMap ไม่ใช่ null) ให้ดึงค่า 'type' ออกมา, ถ้าไม่เจอ ให้ใช้ค่าเริ่มต้น 'ไม่พบประเภท'
    return typeMap?['type'] as String? ?? 'ไม่พบประเภท';
  }
  factory AppealHistoryModel.fromMap(Map<String, dynamic> map) {
    //  ดึงข้อมูล List จาก map ออกมาเก็บในตัวแปรชั่วคราว
    final filesData = map['attachedFiles'];
    //  ตรวจสอบว่า `filesData` เป็น `List` หรือไม่ ถ้าใช่ ให้แปลงเป็น `List<File>`
    //    ถ้าไม่ใช่ (เช่นเป็น null) ให้ `files` เป็น null
    final List<File>? files = filesData is List
        ? List<File>.from(filesData)
        : null;

    return AppealHistoryModel(
      appealId: map['appealId'] ?? '',
      // title: map['title'] ?? '',
      // appealTitle: map['appealTitle'] ?? AppealTitle.request,
      appealTypeId: map['appealTypeId'] ?? '', // <--- **แก้ไขจุดนี้**
      employeeName: map['employeeName'] ?? '',
      // appealCategory: map['appealCategory'] ?? '',
      requestDateTime: map['requestDateTime'] ?? DateTime.now(),
      note: map['note'] ?? '',
      status: map['status'] ?? AppealStatus.pending,
      //  ใช้ `files` ที่แปลงชนิดข้อมูลแล้ว หรือถ้าเป็น null ให้ใช้ List ว่างแทน
      attachedFiles: files ?? [],
    );
  }
  // String get titleText {
  //   switch (appealTitle) {
  //     case AppealTitle.request:
  //       return 'ร้องเรียน';
  //     case AppealTitle.report:
  //       return 'ถูกร้องเรียน';
  //   }
  // }
  String get statusText {
    switch (status) {
      case AppealStatus.approved:
        return 'อนุมัติ';
      case AppealStatus.pending:
        return 'รออนุมัติ';
      case AppealStatus.rejected:
        return 'ไม่อนุมัติ';
    }
  }

  Color get statusBadgeColor {
    switch (status) {
      case AppealStatus.approved:
        return Colors.blue[100]!;
      case AppealStatus.pending:
        return Colors.grey.withValues(alpha: 0.1);
      case AppealStatus.rejected:
        return Colors.red;
    }
  }

  Color get statusTextColor {
    switch (status) {
      case AppealStatus.approved:
        return MyColors.blue2;
      case AppealStatus.pending:
        return Colors.grey[600]!;
      case AppealStatus.rejected:
        return Colors.white;
    }
  }
}