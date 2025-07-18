import 'package:get/get.dart';

class NotificationModel {
  final String type;
  final String title;
  final String date;
  final RxBool isExpanded; // ตัวแปรสถานะการขยาย/ยุบของการ์ดแจ้งเตือน

  NotificationModel({
    required this.type,
    required this.title,
    required this.date,
    bool isExpanded = false,
  }) : isExpanded = isExpanded.obs;

  NotificationModel copyWith({
    String? type,
    String? title,
    String? date,
    bool? isExpanded,
  }) {
    return NotificationModel(
      type: type ?? this.type,
      title: title ?? this.title,
      date: date ?? this.date,
      isExpanded: isExpanded ?? this.isExpanded.value,
    );
  }
}
