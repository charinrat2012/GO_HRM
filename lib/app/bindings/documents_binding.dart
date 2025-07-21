import 'package:get/get.dart';


import '../ui/pages/document_page/document_controller.dart';

class DocumentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentsController>(() => DocumentsController());
    // Get.put<DocumentsController>(DocumentsController());
  }
}
