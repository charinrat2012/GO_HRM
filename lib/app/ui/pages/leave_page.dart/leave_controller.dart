import 'package:get/get.dart';
import '../../../data/models/leave_status_model.dart';
import '../../../data/services/auth_service.dart';
import '../../global_widgets/datalist.dart';

class LeavePageController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final RxInt selectedViewIndex = 0.obs;
  final RxList<LeaveHistoryModel> leaveHistory = <LeaveHistoryModel>[].obs;
  final expandedCardIndex = Rxn<int>();

  // final years = ['2025', '2024', '2023'].obs;
  // final RxnString selectedYear = RxnString('2025');
  // final months = [
  //   'ทั้งหมด',
  //   'มกราคม',
  //   'กุมภาพันธ์',
  //   'มีนาคม',
  //   'เมษายน',
  //   'พฤษภาคม',
  //   'มิถุนายน',
  //   'กรกฎาคม',
  // ].obs;
  // final RxnString selectedMonth = RxnString('ทั้งหมด');
  final RxList<String> leaveTypes = <String>['ทั้งหมด'].obs;

  final RxnString selectedLeaveTypes = RxnString('ทั้งหมด');
  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

  final months = <String>['ทั้งหมด'].obs;
  final years = <String>[].obs;

  final RxnString selectedYear = RxnString('2025');
  final RxnString selectedMonth = RxnString('ทั้งหมด');

  @override
  void onInit() {
    super.onInit();
    loadLeaveHistory();
    setupleaveTypeFilter();
    setupFilterData();
  }

  void setupFilterData() {
    // --- ดึงข้อมูลปีและเรียงลำดับ ---
    final yearNumbers = DataList.years.map((y) => y['year'] as String).toList();
    yearNumbers.sort((a, b) => b.compareTo(a));
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

  // --- [แก้ไข] ปรับปรุงให้ฟังก์ชันนี้ตั้งค่าเฉพาะประเภทการลา ---
  void setupleaveTypeFilter() {
    final leaveTypesFromDataList = DataList.leaveTypes;
    final types = leaveTypesFromDataList
        .map((leave) => leave['type'] as String)
        .toList();
    leaveTypes.addAll(types);
  }

  void onViewChanged(int? newIndex) {
    if (newIndex != null && selectedViewIndex.value != newIndex) {
      selectedViewIndex.value = newIndex;
      loadLeaveHistory();
    }
  }

  void loadLeaveHistory() {
    if (!_authService.isLoggedIn) {
      leaveHistory.clear();
      return;
    }

    final String currentUserId = _authService.currentUser.value!.userId;
    List<LeaveHistoryModel> filteredLeaves = [];

    // --- กรองข้อมูลตามมุมมอง (ของตัวเอง / ของพนักงาน) ---
    if (selectedViewIndex.value == 0) {
      final userPrefs = DataList.userPreferData.firstWhere(
        (pref) => pref['userId'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );

      if (userPrefs.isNotEmpty && userPrefs['leaveId'] is List) {
        final List<String> myLeaveIds = List<String>.from(userPrefs['leaveId']);
        filteredLeaves = DataList.leaveData
            .where((leave) => myLeaveIds.contains(leave['leaveId']))
            .map((map) => LeaveHistoryModel.fromMap(map))
            .toList();
      }
    } else {
      filteredLeaves = DataList.leaveData
          .map((map) => LeaveHistoryModel.fromMap(map))
          .where((leave) => leave.status == LeaveStatus.pending)
          .toList();
    }

    // --- กรองข้อมูลตามปีที่เลือก ---
    if (selectedYear.value != null) {
      filteredLeaves = filteredLeaves.where((leave) {
        return leave.requestDateTime.year.toString() == selectedYear.value;
      }).toList();
    }

    // ---  กรองข้อมูลตามเดือนที่เลือก ---
    if (selectedMonth.value != null && selectedMonth.value != 'ทั้งหมด') {
      final monthIndex = DataList.months.indexWhere(
        (m) => m['month'] == selectedMonth.value,
      );
      if (monthIndex != -1) {
        final monthNumber = int.parse(DataList.months[monthIndex]['monthId']!);
        filteredLeaves = filteredLeaves.where((leave) {
          return leave.requestDateTime.month == monthNumber;
        }).toList();
      }
    }
    if (selectedLeaveTypes.value != null && selectedLeaveTypes.value != 'ทั้งหมด') {
            final selectedTypeName = selectedLeaveTypes.value;
            final typeMap = DataList.leaveTypes.firstWhere(
                (type) => type['type'] == selectedTypeName,
                orElse: () => {},
            );

            if (typeMap.isNotEmpty) {
                final selectedTypeId = typeMap['leaveTypeId']; 
                filteredLeaves = filteredLeaves.where((leave) {
                    return leave.leaveTypeId == selectedTypeId;
                }).toList();
            }
        }

    // --- อัปเดต UI ด้วยข้อมูลที่กรองแล้ว ---
    leaveHistory.assignAll(filteredLeaves);
  }
}
