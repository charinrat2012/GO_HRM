import 'package:get/get.dart';

import '../../../data/models/menu_model.dart';
import '../../../data/models/quota_model.dart';
import '../../global_widgets/datalist.dart';

class HomeController extends GetxController {
  final RxList<MenuModel> menuitems = <MenuModel>[].obs;
  final RxList<QuotaModel> quotaitems = <QuotaModel>[].obs;
  final RxList<QuotaModel> quotaitemsall = <QuotaModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() {
    final List<MenuModel> menuData = DataList.menuData.map((map) {
      // หมายเหตุ: ต้องมีการสร้าง fromMap ใน FavoriteItemModel ด้วย
      return MenuModel.fromMap(map);
    }).toList();

    menuitems.assignAll(menuData);

    final List<QuotaModel> quotaData = DataList.quotasData.map((map) {
      return QuotaModel.fromMap(map);
    }).toList();

    quotaitems.assignAll(quotaData);
    quotaitemsall.assignAll(quotaData);

    final quotasToShow = quotaitems.take(4).toList();
    quotaitems.assignAll(quotasToShow);
  }
}
