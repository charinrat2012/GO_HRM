import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';

class MenuController extends GetxController {
  UserModel? get currentUser => Get.find<AuthService>().currentUser.value;
}
