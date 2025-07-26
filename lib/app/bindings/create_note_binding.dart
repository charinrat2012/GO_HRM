import 'package:get/get.dart';

import '../ui/pages/create_note_page/create_note_controller.dart';


class CreateNoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNoteController>(() => CreateNoteController());
    Get.lazyPut<CreateNoteController>(() => CreateNoteController());
  }
}