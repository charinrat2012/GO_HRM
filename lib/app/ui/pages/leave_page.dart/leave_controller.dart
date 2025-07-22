import 'package:get/get.dart';
import '../../../data/models/leave_status_model.dart';
import '../../../data/services/auth_service.dart';
import '../../global_widgets/datalist.dart';

class LeavePageController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final RxInt selectedViewIndex = 0.obs;
  final RxList<LeaveHistoryModel> leaveHistory = <LeaveHistoryModel>[].obs;
  final expandedCardIndex = Rxn<int>();

  final years = ['2025', '2024', '2023'].obs;
  final RxnString selectedYear = RxnString('2025');
  final months = [
    'ทั้งหมด',
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
  ].obs;
  final RxnString selectedMonth = RxnString('ทั้งหมด');
  final RxList<String> leaveTypes = <String>['ทั้งหมด'].obs;

  final RxnString selectedLeaveTypes = RxnString('ทั้งหมด');
  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

  @override
  void onInit() {
    super.onInit();
    loadLeaveHistory();
    setupleaveTypeFilter();
  }

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

    if (selectedViewIndex.value == 0) {
      final userPrefs = DataList.userPreferData.firstWhere(
        (pref) => pref['userId'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );

      if (userPrefs.isNotEmpty && userPrefs['leaveId'] is List) {
        final List<String> myLeaveIds = List<String>.from(userPrefs['leaveId']);

        final myLeaves = DataList.leaveData
            .where((leave) => myLeaveIds.contains(leave['leaveId']))
            .map((map) => LeaveHistoryModel.fromMap(map))
            .toList();

        leaveHistory.assignAll(myLeaves);
      } else {
        leaveHistory.clear();
      }
    } else {
      // final userPrefs = DataList.userPreferData.firstWhere(
      //   (pref) => pref['userId'] == currentUserId,
      //   orElse: () => <String, dynamic>{},
      // );

      // final List<String> myLeaveIds =
      //     userPrefs.isNotEmpty && userPrefs['leaveId'] is List
      //     ? List<String>.from(userPrefs['leaveId'])
      //     : [];

      final employeeleaves = DataList.leaveData
          .map((map) => LeaveHistoryModel.fromMap(map))
          // .where((leave) => !myLeaveIds.contains(leave['leaveId']))
          .where((leave) => leave.status == LeaveStatus.pending)
          // .map((map) => LeaveHistoryModel.fromMap(map))
          .toList();

      leaveHistory.assignAll(employeeleaves);
    }
  }
}
