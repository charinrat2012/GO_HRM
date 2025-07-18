
import 'package:get/get.dart';

import '../../ui/pages/main_page/main_controller.dart';
import '../../ui/pages/navigation_page/navigation_controller.dart';
import 'auth_service.dart';
import 'user_preference_service.dart';

class DependecyInjection {
  static void init() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<UserPreferenceService>(UserPreferenceService(), permanent: true);
    Get.put<NavigationController>(NavigationController());
    Get.put<MainController>(MainController());
  }
}