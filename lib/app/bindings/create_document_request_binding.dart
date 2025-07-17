import 'package:get/get.dart';

import '../ui/pages/create_documents_request_page/create_documents_request_controller.dart';

class CreateDocumentRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateDocumentRequestController>(
      () => CreateDocumentRequestController(),
    );
    Get.put<CreateDocumentRequestController>(CreateDocumentRequestController());
  }
}
