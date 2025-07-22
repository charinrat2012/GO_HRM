import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/menu_model.dart';
import '../../../data/models/quota_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/user_preference_service.dart';
import '../../global_widgets/datalist.dart';
import 'widgets/dia_test.dart';

class HomeController extends GetxController {
  final RxList<MenuModel> menuitems = <MenuModel>[].obs;
  final RxList<QuotaModel> quotaitems = <QuotaModel>[].obs;
  final RxList<QuotaModel> quotaitemsall = <QuotaModel>[].obs;
  final AuthService authService = Get.find<AuthService>();
  final UserPreferenceService preferenceService = Get.find<UserPreferenceService>();

  final currentTime = DateTime.now().obs;
  final elapsedWorkDuration = Duration.zero.obs;
  final remainingWorkDuration = Duration.zero.obs;
  final RxDouble workProgressPercentage = 0.00.obs; // เพิ่มตัวแปรนี้

  late final DateTime workStartTime;
  late final DateTime workEndTime;

  RxString currentDateFormatted = ''.obs;
  RxString elapsedHoursMinutes = ''.obs;
  RxString currentWorkTimeFormatted = ''.obs;
  RxString remainingWorkTimeFormatted = ''.obs;
  RxString workInTimeFormatted = ''.obs;
  RxString workOutTimeFormatted = ''.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    workStartTime = DateTime(now.year, now.month, now.day, 8, 30);
    workEndTime = DateTime(now.year, now.month, now.day, 17, 30);

    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
    ever(preferenceService.favoriteMenu, (_) => loadData());
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _updateTime() {
    currentTime.value = DateTime.now();
    currentDateFormatted.value = DateFormat('EEEEที่ d MMMM yyyy', 'th_TH').format(currentTime.value);

    _calculateWorkDurations();
    _formatWorkDurations();
    _calculateWorkProgress(); // เรียกใช้ฟังก์ชันใหม่นี้
  }

  void _calculateWorkDurations() {
    final now = currentTime.value;

    if (now.isAfter(workStartTime)) {
      if (now.isBefore(workEndTime)) {
        elapsedWorkDuration.value = now.difference(workStartTime);
      } else {
        elapsedWorkDuration.value = workEndTime.difference(workStartTime);
      }
    } else {
      elapsedWorkDuration.value = Duration.zero;
    }

    if (now.isBefore(workEndTime)) {
      remainingWorkDuration.value = workEndTime.difference(now);
    } else {
      remainingWorkDuration.value = Duration.zero;
    }
  }

  void _formatWorkDurations() {
    final int hours = elapsedWorkDuration.value.inHours;
    final int minutes = elapsedWorkDuration.value.inMinutes.remainder(60);

    elapsedHoursMinutes.value = '$hours  $minutes นาที';

    final currentHours = (elapsedWorkDuration.value.inSeconds ~/ 3600).toString().padLeft(2, '0');
    final currentMinutes = ((elapsedWorkDuration.value.inSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final currentSeconds = (elapsedWorkDuration.value.inSeconds % 60).toString().padLeft(2, '0');
    currentWorkTimeFormatted.value = '$currentHours:$currentMinutes:$currentSeconds';

    final int remainingHours = remainingWorkDuration.value.inHours;
    final int remainingMinutes = remainingWorkDuration.value.inMinutes.remainder(60);
    remainingWorkTimeFormatted.value =
        '${remainingHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';

    workInTimeFormatted.value = DateFormat('HH:mm:ss').format(workStartTime);
    workOutTimeFormatted.value = DateFormat('HH:mm:ss').format(workEndTime);
  }

  // ฟังก์ชันใหม่สำหรับคำนวณเปอร์เซ็นต์ความคืบหน้า
  void _calculateWorkProgress() {
    final totalWorkDuration = workEndTime.difference(workStartTime);
    if (totalWorkDuration.inSeconds > 0) {
      final now = currentTime.value;
      if (now.isAfter(workStartTime)) {
        if (now.isBefore(workEndTime)) {
          workProgressPercentage.value = elapsedWorkDuration.value.inSeconds / totalWorkDuration.inSeconds;
        } else {
          workProgressPercentage.value = 1.00; // หากเลยเวลาเลิกงาน ถือว่าครบ 100%
        }
      } else {
        workProgressPercentage.value = 0.00; // ยังไม่ถึงเวลาเริ่มงาน
      }
    } else {
      workProgressPercentage.value = 0.00; // ป้องกันหารด้วยศูนย์
    }
  }

  void loadData() {
    if (authService.isLoggedIn) {
      final String currentUserId = authService.currentUser.value!.userId;
      final List<String> favoriteIds = preferenceService.getFavoriteMenuIds(currentUserId);
      final List<MenuModel> favoriteMenuData = DataList.allMenus
          .where((menu) => favoriteIds.contains(menu['iconId']))
          .map((map) => MenuModel.fromMap(map))
          .toList();
      menuitems.assignAll(favoriteMenuData);
    } else {
      menuitems.clear();
    }

    final List<QuotaModel> quotaData = DataList.quotasData.map((map) {
      return QuotaModel.fromMap(map);
    }).toList();

    quotaitems.assignAll(quotaData);
    quotaitemsall.assignAll(quotaData);

    final quotasToShow = quotaitems.take(4).toList();
    quotaitems.assignAll(quotasToShow);
  }

  void handleClockIn() async {
    bool success = true;
    if (success) {
      showSuccessDialog();
    } else {
      // จัดการกรณีที่ลงเวลาไม่สำเร็จ
    }
  }

  void showSuccessDialog() {
    Get.dialog(
      ClockInSuccessDialog(
        dateTime: DateTime.now(),
        location: 'Absolute HQ Tower',
      ),
      barrierDismissible: false,
    );
  }
}