import 'package:get/get.dart';

import '../../../data/models/quota_model.dart';
import '../../global_widgets/datalist.dart';

class QuotaController extends GetxController {
  final years = ['2025', '2024', '2023'].obs;
  final RxnString selectedYear = RxnString('2025');

  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

  final RxList<QuotaModel> quotaitemsall = <QuotaModel>[].obs;
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() {
    final List<QuotaModel> quotaData = DataList.quotasData.map((map) {
      return QuotaModel.fromMap(map);
    }).toList();

    quotaitemsall.assignAll(quotaData);
  }
}
