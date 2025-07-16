import 'package:get/get.dart';

class SalaryController extends GetxController {
  final years = <String>[].obs;
  final selectedYear = RxnString();

  @override
  void onInit() {
    super.onInit();

    _populateYears();

    selectedYear.value = years.isNotEmpty ? years.first : null;
    loadSalaryData();
  }

  void _populateYears() {
    final currentYear = DateTime.now().year;
    for (int i = 0; i < 4; i++) {
      years.add((currentYear - i).toString());
    }
  }

  void loadSalaryData() {
    // TODO: เพิ่ม logic สำหรับโหลดข้อมูลเงินเดือนตาม selectedYear.value
  }
}
