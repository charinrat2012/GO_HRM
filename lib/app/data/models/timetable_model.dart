
import 'package:get/get.dart';

class TimetableModel {
  final String date;
  final String checkInTime;
  final String checkOutTime;
  final String status;
  final String note;
  final RxBool isExpanded;

  TimetableModel({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.status,
    required this.note,
    bool isExpanded = false,
  }) : isExpanded = isExpanded.obs;
}