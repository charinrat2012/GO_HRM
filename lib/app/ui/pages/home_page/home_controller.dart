import 'package:get/get.dart';

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
  final AuthService authService= Get.find<AuthService>();
  final UserPreferenceService preferenceService = Get.find<UserPreferenceService>();

  @override
  void onReady() {
    super.onReady();
    loadData();
    ever(preferenceService.favoriteMenu, (_) => loadData());
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
