import 'dart:async'; // เพิ่ม import นี้
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // เพิ่ม import นี้

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

  // เพิ่มตัวแปร Reactive สำหรับแสดงเวลา
  final currentTime = DateTime.now().obs;
  final elapsedWorkDuration = Duration.zero.obs;
  final remainingWorkDuration = Duration.zero.obs;

  // กำหนดเวลาทำงานมาตรฐาน
  late final DateTime workStartTime;
  late final DateTime workEndTime;

  // String ที่จัดรูปแบบแล้วสำหรับ UI
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
    // กำหนด workStartTime และ workEndTime โดยใช้วันที่ปัจจุบัน
    final now = DateTime.now();
    workStartTime = DateTime(now.year, now.month, now.day, 8, 30);
    workEndTime = DateTime(now.year, now.month, now.day, 17, 30);

    _updateTime(); // อัปเดตเวลาทันทีที่เริ่มต้น Controller
    // ตั้งเวลาให้ Timer อัปเดตเวลาทุกวินาที
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
    _timer?.cancel(); // ยกเลิก Timer เมื่อ Controller ถูกปิด
    super.onClose();
  }

  void _updateTime() {
    currentTime.value = DateTime.now();
    currentDateFormatted.value = DateFormat('EEEEที่ d MMMM yyyy', 'th_TH').format(currentTime.value);

    _calculateWorkDurations();
    _formatWorkDurations();
  }

  void _calculateWorkDurations() {
    final now = currentTime.value;

    // คำนวณชั่วโมงเวลาการทำงานที่ผ่านไป
    if (now.isAfter(workStartTime)) {
      if (now.isBefore(workEndTime)) {
        elapsedWorkDuration.value = now.difference(workStartTime);
      } else {
        // หากเลยเวลาเลิกงานแล้ว ให้แสดงระยะเวลาทำงานเต็มวัน
        elapsedWorkDuration.value = workEndTime.difference(workStartTime);
      }
    } else {
      elapsedWorkDuration.value = Duration.zero; // ยังไม่ถึงเวลาเริ่มงาน
    }

    // คำนวณเวลาที่เหลือในการทำงาน
    if (now.isBefore(workEndTime)) {
      remainingWorkDuration.value = workEndTime.difference(now);
    } else {
      remainingWorkDuration.value = Duration.zero; // หมดเวลาทำงานแล้ว
    }
  }

  void _formatWorkDurations() {
    // จัดรูปแบบ "8 ชม. 32 นาที"
    final int hours = elapsedWorkDuration.value.inHours;
    final int minutes = elapsedWorkDuration.value.inMinutes.remainder(60);
    // final int seconds = elapsedWorkDuration.value.inSeconds.remainder(60); // ไม่ได้ใช้ในส่วนนี้

    elapsedHoursMinutes.value = '$hours ชม. $minutes นาที';

    // จัดรูปแบบ "08:32:52" สำหรับชั่วโมงเวลาการทำงานปัจจุบัน
    final currentHours = (elapsedWorkDuration.value.inSeconds ~/ 3600).toString().padLeft(2, '0');
    final currentMinutes = ((elapsedWorkDuration.value.inSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final currentSeconds = (elapsedWorkDuration.value.inSeconds % 60).toString().padLeft(2, '0');
    currentWorkTimeFormatted.value = '$currentHours:$currentMinutes:$currentSeconds';


    // จัดรูปแบบ "คงเหลือ 24:58"
    final int remainingHours = remainingWorkDuration.value.inHours;
    final int remainingMinutes = remainingWorkDuration.value.inMinutes.remainder(60);
    remainingWorkTimeFormatted.value =
        '${remainingHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';

    // เวลาเข้างานและเลิกงานตามที่ผู้ใช้กำหนด (8.30 และ 17.30)
    workInTimeFormatted.value = DateFormat('HH:mm:ss').format(workStartTime);
    workOutTimeFormatted.value = DateFormat('HH:mm:ss').format(workEndTime);
  }

  void loadData() {
    // ---  ดึง userId จาก AuthService ---
    
    if (authService.isLoggedIn) { 
      final String currentUserId = authService.currentUser.value!.userId;

      // 3. ดึง ID เมนูโปรดล่าสุดจาก Service
      final List<String> favoriteIds = preferenceService.getFavoriteMenuIds(currentUserId);

      // 4. กรองและแสดงผลเมนูตาม ID ที่ได้มา
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
    // --- ส่วนของ Logic การลงเวลาของคุณ ---
    bool success = true;

    // --- หลังจากลงเวลาสำเร็จ ---
    if (success) {
      showSuccessDialog(); // เรียกใช้ Dialog ที่เราสร้างไว้
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