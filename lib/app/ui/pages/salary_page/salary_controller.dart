import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../global_widgets/datalist.dart';

class SalaryController extends GetxController {
  final years = <String>[].obs;
  final selectedYear = RxnString();
  final allSalaryData = <Map<String, dynamic>>[].obs;
  final filteredSalaryData = <Map<String, dynamic>>[].obs;
  final currentSalary = Rxn<Map<String, dynamic>>();
  final salaryHistory = <Map<String, dynamic>>[].obs;
  final AuthService _authService = Get.find<AuthService>();
  @override
  void onInit() {
    super.onInit();
   
    _loadUserSalaryData();
    // --- เรียกใช้ฟังก์ชันเพื่อสร้างรายการปีสำหรับฟิลเตอร์ ---
    _populateYears();
    // --- กำหนดค่าเริ่มต้นให้ปีที่เลือกเป็นปีล่าสุด ---
    selectedYear.value = years.isNotEmpty ? years.first : null;
    // --- โหลดข้อมูลเงินเดือนตามปีที่เลือกเป็นค่าเริ่มต้น ---
    loadSalaryData();
  }

  // ---  ฟังก์ชันสำหรับดึงปีทั้งหมดจากข้อมูลเงินเดือนที่มี ---
    void _loadUserSalaryData() {
    // --- ตรวจสอบว่ามีการล็อกอินหรือไม่ ---
    if (_authService.isLoggedIn) {
      // --- ดึง ID ของผู้ใช้ปัจจุบัน ---
      final String currentUserId = _authService.currentUser.value!.userId;
      
      // --- ค้นหาข้อมูลสิทธิ์ (preferences) ของผู้ใช้ ---
      final userPrefs = DataList.userPreferData.firstWhere(
        (pref) => pref['userId'] == currentUserId,
        orElse: () => <String, dynamic>{}, // ถ้าไม่เจอ ให้คืนค่าว่าง
      );

      // --- ตรวจสอบว่า user มีสิทธิ์ดู salaryId หรือไม่ ---
      if (userPrefs.isNotEmpty && userPrefs['salaryId'] is List) {
        final List<String> mySalaryIds = List<String>.from(userPrefs['salaryId']);
        
        // --- กรอง salaryData ทั้งหมด ให้เหลือเฉพาะรายการที่ user มีสิทธิ์ ---
        final userSalaryData = DataList.salaryData
            .where((salary) => mySalaryIds.contains(salary['salaryId']))
            .toList();
        
        // --- นำข้อมูลที่กรองแล้วมาใช้งานต่อใน Controller ---
        allSalaryData.assignAll(userSalaryData);
      } else {
        // --- ถ้า user ไม่มีสิทธิ์ ให้เคลียร์ข้อมูลทั้งหมด ---
        allSalaryData.clear();
      }
    } else {
      // --- หากยังไม่ได้ล็อกอิน ก็ไม่มีข้อมูลจะแสดง ---
      allSalaryData.clear();
    }
  }


  // --- ฟังก์ชันสำหรับดึงปีทั้งหมดจากข้อมูลเงินเดือนที่มี (เฉพาะของผู้ใช้ที่ login) ---
  void _populateYears() {
    final List<String> allYears = allSalaryData
        .map<String>((e) => e['datePaid']!.split('/')[2].split(' ')[0])
        .toSet()
        .toList();

    allYears.sort((a, b) => b.compareTo(a));
    years.assignAll(allYears);
  }

  // --- ฟังก์ชันสำหรับโหลดและกรองข้อมูลเงินเดือน (ตามปี) ---
  void loadSalaryData() {
    if (selectedYear.value == null) {
      filteredSalaryData.clear();
      currentSalary.value = null;
      salaryHistory.clear();
      return;
    }

    final filteredList = allSalaryData
        .where((e) => e['datePaid']!.contains(selectedYear.value!))
        .toList();

    if (filteredList.isNotEmpty) {
      currentSalary.value = filteredList.first;
      salaryHistory.assignAll(filteredList.sublist(1));
    } else {
      currentSalary.value = null;
      salaryHistory.clear();
    }
    filteredSalaryData.assignAll(filteredList);
  }
}