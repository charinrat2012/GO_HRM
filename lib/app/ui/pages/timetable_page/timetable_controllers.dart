import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/timetable_model.dart';

class TimetableController extends GetxController {
  final years = ['2025', '2024', '2023', '2022'].obs;
  final RxnString selectedYear = RxnString(
    '2025',
  ); //กำหนดเป็นค่าเริ่มต้นไว้ปี2025

  final months = [
    'ทั้งหมด',
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ].obs;
  final RxnString selectedMonth = RxnString('กรกฎาคม');
  //ถ้ามีข้อมูลมีการเปลี่ยนเมื่อไหร่ อัปเดตตามทันทีโดยอัตโนมัติ
  final RxList<TimetableModel> schedules = <TimetableModel>[].obs;

  // ตัวแปรสำหรับติดตาม index ของการ์ดที่กำลังขยายอยู่ (เริ่มต้นที่ -1 คือไม่มีการ์ดใดขยาย)
  final RxInt _currentlyExpandedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadTimetableData();
  }

  void loadTimetableData() {
    // จำลองการดึงข้อมูลตามปีและเดือนที่เลือก
    List<TimetableModel> dummyData = [];
    //ไม่ว่าผู้ใช้จะเลือกปีอะไรมันก็จะนำมาแปลงเป็นตัวเลขเเละปี2025เป็นตัวสำรองถ้าผู้ใช้ไม่ได้เลือกก็จะแสดงปี2025
    int currentYear = int.parse(selectedYear.value ?? '2025');
    //ถ้าผู้ใช้เลือกเดือนทั้งหมด ทั้งหมดคือ0 ก็จะแสดงทั้งหมด แต่ถ้าเลือกกรกฎาคม ก็จะแสดงแค่เดือนกรกฎาคมเท่านั้นเดือนิื่นจะไม่มี
    int currentMonth = selectedMonth.value == 'ทั้งหมด'
        ? 0
        : months.indexOf(selectedMonth.value ?? 'กรกฎาคม');

    // สร้างข้อมูลจำลอง 7 รายการ
    if (currentYear == 2025 && (currentMonth == 0 || currentMonth == 7)) {
      // 7 คือเดือนกรกฎาคม
    
      DateTime startDate = DateTime(
        2025,
        6,
        25, // เริ่มต้นวันที่ 25 มิถุนายน 2025
      );

      for (int i = 0; i < 7; i++) {
        // ลบวันออกไปทีละวันเพื่อให้ได้ 7 วันย้อนหลัง
        DateTime date = startDate.subtract(
          Duration(days: i),
        );
        String dayOfWeek = DateFormat('EEEE', 'th').format(date); // แสดงวันที่ในภาษาไทย
        String formattedDate = DateFormat('dd/MM/yyyy').format(date);
//สร้าง ข้อมูลตารางเวลา 1 รายการ และเพิ่มเข้าไปใน dummyData
        dummyData.add(
          TimetableModel(
            date: '$dayOfWeek $formattedDate',
            checkInTime: '08.06 น.',
            checkOutTime: '17.38 น.',
            status: 'วันทำงานปกติ',
            note: '',
            isExpanded: false, // ทุกการ์ดปิดอยู่เริ่มต้นเสมอ
          ),
        );
      }
    }
    // ไม่ต้องเรียงลำดับใหม่แล้ว เพราะตอนสร้างก็สร้างจากวันที่มากไปน้อยแล้ว
    schedules.assignAll(dummyData); 
  }

  // เมธอดสำหรับสลับสถานะการขยายการ์ด (เพื่อให้ขยายได้ทีละหนึ่ง)
  void toggleCardExpansion(int tappedIndex) {
    if (_currentlyExpandedIndex.value == tappedIndex) {
      // ถ้ากดการ์ดที่กำลังขยายอยู่ ให้ยุบการ์ดนั้น
      schedules[tappedIndex].isExpanded.value = false; // อัปเดตสถานะในโมเดล
      _currentlyExpandedIndex.value = -1; // ไม่มีใครขยาย
    } else {
      // ถ้ากดการ์ดอื่น หรือกดการ์ดที่ยุบอยู่
      //สั่งยุบการ์ดที่เคยขยายอยู่ (ถ้ามี)
      if (_currentlyExpandedIndex.value != -1 &&
          _currentlyExpandedIndex.value < schedules.length) {
        schedules[_currentlyExpandedIndex.value].isExpanded.value =
            false; // อัปเดตสถานะในโมเดล
      }
      //  สั่งขยายการ์ดที่เพิ่งถูกกด
      schedules[tappedIndex].isExpanded.value = true; // อัปเดตสถานะในโมเดล
      _currentlyExpandedIndex.value =
          tappedIndex; // บันทึก index ของการ์ดที่ขยายอยู่
    }
  }

  // เช็คว่าการ์ดไหนกำลังขยายอยู่
  bool isCardExpanded(int index) {
    return _currentlyExpandedIndex.value == index;
  }
}