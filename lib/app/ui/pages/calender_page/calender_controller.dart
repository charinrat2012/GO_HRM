import 'dart:collection';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

// --- Event Model ---
class Event {
  final String title;
  final String? description;
  final String time;

  const Event({required this.title, this.description, required this.time});

  @override
  String toString() => title;
}

class CalenderController extends GetxController {
  // --- State Variables ---
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxList<Event> selectedEvents = <Event>[].obs;

  // --- Event Data ---
  late final LinkedHashMap<DateTime, List<Event>> kEvents;

  @override
  void onInit() {
    super.onInit();

    // กำหนดวันเริ่มต้นที่ถูกเลือก
    selectedDay.value = focusedDay.value;

    // --- สร้างข้อมูลกิจกรรมตัวอย่าง ---
    _initializeEvents();

    // โหลดกิจกรรมสำหรับวันที่ถูกเลือก
    selectedEvents.value = getEventsForDay(selectedDay.value!);
  }

  void _initializeEvents() {
    final events = {
      // วันที่ 1 มกราคม 2025
      DateTime.utc(2025, 1, 1): [
        const Event(
            title: 'วันขึ้นปีใหม่',
            description: 'วันหยุดนักขัตฤกษ์',
            time: 'ทั้งวัน'),
      ],
      // วันที่ 10 มกราคม 2025 (ตามรูปภาพ)
      DateTime.utc(2025, 1, 10): [
        const Event(
            title: 'ประชุมกับผู้บริหาร',
            description: 'ประชุมกับผู้บริหารระดับสูงเพื่อรายงานความคืบหน้าของงาน',
            time: '10.30 - 11.30'),
        const Event(
            title: 'วันก่อตั้งบริษัท',
            description: 'เป็นวันที่ก่อตั้งบริษัทเป็นมาวันแรก ให้เป็นวันหยุดงานทุกคน',
            time: 'ทั้งวัน'),
        const Event(
            title: 'วันตรวจสุขภาพของบริษัท',
            description: 'ตรวจสุขภาพประจำปีของพนักงาน มาตรา 3 โดยหมอผู้เชี่ยวชาญด้านต่างๆ',
            time: 'ทั้งวัน'),
        const Event(
            title: 'วันเกิดเจ้านายตัวเอง',
            description: 'วันนี้ต้องซื้อของขวัญ HBD เจ้านาย',
            time: 'ทั้งวัน'),
      ],
      // วันที่ 30 มกราคม 2025
      DateTime.utc(2025, 1, 30): [
        const Event(
            title: 'จ่ายเงินเดือน',
            description: 'รอบจ่ายเงินเดือนมกราคม',
            time: 'ทั้งวัน'),
      ],
      DateTime.utc(2025, 7, 4): [
        const Event(
            title: 'วันหยุดครึ่งปีธนาคาร',
            description: 'ธนาคารหยุดทำการ',
            time: 'ทั้งวัน'),
      ],

      // --- วันที่ 17 กรกฎาคม 2025 (วันนี้) ---
      DateTime.utc(2025, 7, 17): [
        const Event(
            title: 'ประชุมทีม Marketing',
            description: 'ประชุมวางแผนแคมเปญไตรมาสที่ 3',
            time: '14:00 - 15:30'),
      ],

      // --- วันที่ 25 กรกฎาคม 2025 ---
      DateTime.utc(2025, 7, 25): [
        const Event(
            title: 'ส่งโปรเจกต์ลูกค้า',
            description: 'เดดไลน์ส่งงานโปรเจกต์ ABC',
            time: '17:00'),
        const Event(
            title: 'เลี้ยงปิดโปรเจกต์',
            description: 'ที่ร้านอาหาร ABCDE',
            time: '18:30'),
      ],

       // --- วันที่ 28 กรกฎาคม 2025 ---
      DateTime.utc(2025, 7, 28): [
        const Event(
            title: 'วันเฉลิมพระชนมพรรษา',
            description: 'วันหยุดนักขัตฤกษ์',
            time: 'ทั้งวัน'),
      ],



    };

    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(events);
  }

  // --- Methods ---

  List<Event> getEventsForDay(DateTime day) {
    // Implementation for fetching events
    return kEvents[day] ?? [];
  }

  void onDaySelected(DateTime newSelectedDay, DateTime newFocusedDay) {
    if (!isSameDay(selectedDay.value, newSelectedDay)) {
      selectedDay.value = newSelectedDay;
      focusedDay.value = newFocusedDay;
      selectedEvents.value = getEventsForDay(newSelectedDay);
    }
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat.value != format) {
      calendarFormat.value = format;
    }
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDay.value = newFocusedDay;
  }
}

/// Helper method to get the hash code for a DateTime object.
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}