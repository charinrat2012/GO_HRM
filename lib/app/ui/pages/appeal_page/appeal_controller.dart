import 'package:get/get.dart';
import '../../../data/models/appeal_status_model.dart';
import '../../../data/services/auth_service.dart';
import '../../global_widgets/datalist.dart';

class AppealController extends GetxController {
  // 3. ดึง AuthService เข้ามาใช้งาน
  final AuthService _authService = Get.find<AuthService>();

  // --- State Variables (ตัวแปรสถานะ) ---
  final RxInt selectedViewIndex = 0.obs;
  final RxList<AppealHistoryModel> appealHistory = <AppealHistoryModel>[].obs;
  final expandedCardIndex = Rxn<int>();

  // ... (ตัวแปรสำหรับ Dropdown เหมือนเดิม) ...
  // final years = ['2025', '2024', '2023'].obs;
  // final RxnString selectedYear = RxnString('2025');
  // final months = ['ทั้งหมด', 'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม'].obs;
  // final RxnString selectedMonth = RxnString('ทั้งหมด');
  final RxList<String> appealTypes = <String>['ทั้งหมด'].obs;
  // `selectedappealType` จะเก็บค่าที่ผู้ใช้เลือกจาก Dropdown
  final RxnString selectedappealType = RxnString('ทั้งหมด');
  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

  final months = <String>['ทั้งหมด'].obs;
  final years = <String>[].obs;

  final RxnString selectedYear = RxnString('2025');
  final RxnString selectedMonth = RxnString('ทั้งหมด');

  @override
  void onInit() {
    super.onInit();
    loadAppealHistory();
    setupappealTypeFilter();
    setupFilterData();
  }

  void setupFilterData() {
    // --- ดึงข้อมูลปีและเรียงลำดับ ---
    final yearNumbers = DataList.years.map((y) => y['year'] as String).toList();
    yearNumbers.sort((a, b) => b.compareTo(a)); // เรียงปีล่าสุดขึ้นก่อน
    years.assignAll(yearNumbers);

    // --- ตั้งค่าปีเริ่มต้นที่เลือก ---
    if (years.isNotEmpty) {
      selectedYear.value = years.first;
    }

    // --- ดึงข้อมูลเดือน ---
    final monthNames = DataList.months
        .map((m) => m['month'] as String)
        .toList();
    months.addAll(monthNames);
  }

  void setupappealTypeFilter() {
    final appealTypesFromDataList = DataList.appealTypes;
    final types = appealTypesFromDataList
        .map((appeal) => appeal['type'] as String)
        .toList();
    appealTypes.addAll(types);
  }

  void onViewChanged(int? newIndex) {
    if (newIndex != null && selectedViewIndex.value != newIndex) {
      selectedViewIndex.value = newIndex;
      loadAppealHistory();
    }
  }

  void loadAppealHistory() {
    if (!_authService.isLoggedIn) {
      appealHistory.clear();
      return;
    }

    final String currentUserId = _authService.currentUser.value!.userId;
    List<AppealHistoryModel> filteredAppeal = [];

    // --- กรองข้อมูลตามมุมมอง (ของตัวเอง / ของพนักงาน) ---
    if (selectedViewIndex.value == 0) {
      final userPrefs = DataList.userPreferData.firstWhere(
        (pref) => pref['userId'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );

      if (userPrefs.isNotEmpty && userPrefs['appealId'] is List) {
        final List<String> myappealIds = List<String>.from(
          userPrefs['appealId'],
        );
        filteredAppeal = DataList.appealData
            .where((appeal) => myappealIds.contains(appeal['appealId']))
            .map((map) => AppealHistoryModel.fromMap(map))
            .toList();
      }
    } else {
      filteredAppeal = DataList.appealData
          .map((map) => AppealHistoryModel.fromMap(map))
          .where((appeal) => appeal.status == AppealStatus.pending)
          .toList();
    }

    // ---  กรองข้อมูลตามปีที่เลือก ---
    if (selectedYear.value != null) {
      filteredAppeal = filteredAppeal.where((appeal) {
        return appeal.requestDateTime.year.toString() == selectedYear.value;
      }).toList();
    }

    // ---  กรองข้อมูลตามเดือนที่เลือก ---
    if (selectedMonth.value != null && selectedMonth.value != 'ทั้งหมด') {
      // --- หาเลขเดือนจากชื่อเดือน (เช่น "มกราคม" -> 1) ---
      final monthIndex = DataList.months.indexWhere(
        (m) => m['month'] == selectedMonth.value,
      );
      if (monthIndex != -1) {
        final monthNumber = int.parse(DataList.months[monthIndex]['monthId']!);
        filteredAppeal = filteredAppeal.where((appeal) {
          return appeal.requestDateTime.month == monthNumber;
        }).toList();
      }
    }
      if (selectedappealType.value != null &&
        selectedappealType.value != 'ทั้งหมด') {
      final selectedTypeName = selectedappealType.value;
      // ค้นหา ID จากชื่อประเภทที่เลือกใน dropdown
      final typeMap = DataList.appealTypes.firstWhere(
        (type) => type['type'] == selectedTypeName,
        orElse: () => {},
      );

      if (typeMap.isNotEmpty) {
        // นำ ID ที่ได้ไปใช้กรองข้อมูล
        final selectedTypeId = typeMap['appealtypeId'];
        filteredAppeal = filteredAppeal.where((appeal) {
          return appeal.appealTypeId == selectedTypeId;
        }).toList();
      }
    }

    // --- อัปเดต UI ด้วยข้อมูลที่กรองแล้ว ---
    appealHistory.assignAll(filteredAppeal);
  }
}
