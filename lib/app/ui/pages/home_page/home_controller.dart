import 'package:get/get.dart';

import '../../../data/models/menu_model.dart';
import '../../../data/models/quota_model.dart';
import '../../../data/services/auth_service.dart';
import '../../global_widgets/datalist.dart';
import 'widgets/dia_test.dart';

class HomeController extends GetxController {
  final RxList<MenuModel> menuitems = <MenuModel>[].obs;
  final RxList<QuotaModel> quotaitems = <QuotaModel>[].obs;
  final RxList<QuotaModel> quotaitemsall = <QuotaModel>[].obs;
  final AuthService authService= Get.find<AuthService>();
  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() {
    // ---  ดึง userId จาก AuthService ---
    
    if (authService.isLoggedIn) {
      // ดึง userId จากข้อมูลผู้ใช้ที่เก็บไว้ใน AuthService
      final String currentUserId = authService.currentUser.value!.userId;

      final userFavoritesData = DataList.favoriteMenu.firstWhere(
        (fav) => fav['userId'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );

      if (userFavoritesData.isNotEmpty && userFavoritesData['iconId'] is List) {
        final List<String> favoriteIds = List<String>.from(userFavoritesData['iconId']);
        final List<MenuModel> favoriteMenuData = DataList.allMenus
            .where((menu) => favoriteIds.contains(menu['iconId']))
            .map((map) => MenuModel.fromMap(map))
            .toList();
        menuitems.assignAll(favoriteMenuData);
      } else {
        menuitems.clear();
      }
    } else {
      // กรณีไม่มีใครล็อกอิน (อาจจะเกิดขึ้นได้ถ้าเข้ามาหน้านี้โดยตรง)
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
