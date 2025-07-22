import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';

class SalaryDetailController extends GetxController {
  // ---  สร้างตัวแปรสำหรับเก็บค่าเดือนและวันที่จ่าย ---
  late final String month;
  late final String datePaid;

  // ---  สร้าง getter เพื่อให้เข้าถึงข้อมูลผู้ใช้ที่ล็อกอินอยู่ได้ง่ายขึ้น ---
  UserModel? get currentUser => Get.find<AuthService>().currentUser.value;

  // ---  onInit() จะถูกเรียกใช้งานอัตโนมัติเมื่อ Controller ถูกสร้างขึ้น ---
  @override
  void onInit() {
    super.onInit();
    // ---  Logic การดึง arguments มาไว้ที่นี่ ---
    final Map<String, dynamic> args = Get.arguments ?? {};
    month = args['month'] ?? 'ไม่ระบุเดือน';
    datePaid = args['datePaid'] ?? 'ไม่ระบุวันที่จ่าย';
  }
}