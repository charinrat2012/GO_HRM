import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/chats_page/chats_controller.dart';

import '../ui/pages/calender_page/calender_controller.dart';
import '../ui/pages/home_page/home_controller.dart';
import '../ui/pages/login_page/login_controller.dart';
import '../ui/pages/menu_page/menu_controller.dart';
import '../ui/pages/navigation_page/navigation_controller.dart';
import '../ui/pages/news_page/news_controller.dart';

class NavigationBinding implements Bindings {
  @override
  void dependencies() {
    // ฉีด NavigationController เข้าไปใน memory
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<NewsController>(() => NewsController(), fenix: true);
    Get.lazyPut<CalenderController>(() => CalenderController(), fenix: true);
    Get.lazyPut<MenuController>(() => MenuController(), fenix: true);
    Get.lazyPut<ChatsController>(() => ChatsController(), fenix: true);

    // Controller ของแต่ละหน้าใน Bottom Bar
    // ใช้ fenix: true เพื่อให้ controller ถูกสร้างใหม่ทุกครั้งที่เรียกใช้หน้านั้นๆ
    // เหมาะสำหรับหน้าที่ต้องการโหลดข้อมูลใหม่เสมอ
  }
}
