
import 'package:get/get.dart';


import '../../../data/models/favourite_model.dart';
import '../../../data/models/quota_model.dart';
import '../../global_widgets/datalist.dart';


class HomeController extends GetxController {
 final RxList<FavoriteItemModel> favoriteitems = <FavoriteItemModel>[].obs;
 final RxList<QuotaModel> quotaitems = <QuotaModel>[].obs;


 @override
  void onReady() {

    super.onReady();
    loadData();
  }


 void loadData(){
final List<FavoriteItemModel> favoriteData =
        DataList.favouriteData.map((map) {
      // หมายเหตุ: ต้องมีการสร้าง fromMap ใน FavoriteItemModel ด้วย
      return FavoriteItemModel.fromMap(map);
    }).toList();

    favoriteitems.assignAll(favoriteData);

    final List<QuotaModel> quotaData = DataList.quotasData.map((map) {
      return QuotaModel.fromMap(map);
    }).toList();

    quotaitems.assignAll(quotaData);

 }
}
