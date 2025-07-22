import 'package:get/get.dart';
import '../../../data/models/document_status_model.dart';
import '../../../data/services/auth_service.dart'; // 1. Import AuthService
import '../../global_widgets/datalist.dart'; // 2. Import DataList

class DocumentsController extends GetxController {
  // 3. ดึง AuthService เข้ามาใช้งาน
  final AuthService _authService = Get.find<AuthService>();

  // --- State Variables (ตัวแปรสถานะ) ---
  final RxInt selectedViewIndex = 0.obs;
  final RxList<DocumentHistoryModel> docHistory = <DocumentHistoryModel>[].obs;
  final expandedCardIndex = Rxn<int>();

  // ... (ตัวแปรสำหรับ Dropdown เหมือนเดิม) ...
  final years = ['2025', '2024', '2023'].obs;
  final RxnString selectedYear = RxnString('2025');
  final months = [
    'ทั้งหมด',
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
  ].obs;
  final RxnString selectedMonth = RxnString('ทั้งหมด');
  final RxList<String> docTypes = <String>['ทั้งหมด'].obs;
  // `selectedDocumentType` จะเก็บค่าที่ผู้ใช้เลือกจาก Dropdown
  final RxnString selectedDocTypes = RxnString('ทั้งหมด');
  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

  @override
  void onInit() {
    super.onInit();
    loadDocHistory();
    setupDocumentTypeFilter();
  }

  void setupDocumentTypeFilter() {
    //  ดึงข้อมูลประเภทเอกสาร (ที่เป็น Map) จาก DataList
    final docTypesFromDataList = DataList.docTypes;

    //  แปลง List<Map> ให้เป็น List<String> โดยดึงเฉพาะค่า 'type'
    final types = docTypesFromDataList
        .map((doc) => doc['type'] as String)
        .toList();

    //  เพิ่มประเภทเอกสารทั้งหมดเข้าไปใน `documentTypeOptions` ต่อจาก "ทั้งหมด"
    docTypes.addAll(types);
  }

  void onViewChanged(int? newIndex) {
    if (newIndex != null && selectedViewIndex.value != newIndex) {
      selectedViewIndex.value = newIndex;
      loadDocHistory();
    }
  }

  // --- 🛠️ จุดแก้ไข: ปรับปรุงตรรกะการโหลดข้อมูลทั้งหมด ---
  void loadDocHistory() {
    // ตรวจสอบก่อนว่าผู้ใช้ล็อกอินอยู่หรือไม่
    if (!_authService.isLoggedIn) {
      docHistory.clear(); // ถ้าไม่ ให้เคลียร์ข้อมูล
      return;
    }

    // ดึง ID ของผู้ใช้ที่กำลังล็อกอินอยู่
    final String currentUserId = _authService.currentUser.value!.userId;

    // --- ตรรกะสำหรับมุมมอง "ของตัวเอง" ---
    if (selectedViewIndex.value == 0) {
      // 1. ค้นหา Preference ของผู้ใช้
      final userPrefs = DataList.userPreferData.firstWhere(
        (pref) => pref['userId'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );

      if (userPrefs.isNotEmpty && userPrefs['documentId'] is List) {
        // 2. ดึงรายการ documentId ของผู้ใช้
        final List<String> myDocumentIds = List<String>.from(
          userPrefs['documentId'],
        );

        // 3. กรองเอกสารทั้งหมด ให้เหลือเฉพาะเอกสารที่ ID ตรงกับของผู้ใช้
        final myDocuments = DataList.documentData
            .where((doc) => myDocumentIds.contains(doc['documentId']))
            .map((map) => DocumentHistoryModel.fromMap(map))
            .toList();

        // 4. อัปเดต UI
        docHistory.assignAll(myDocuments);
      } else {
        docHistory.clear(); // ถ้าไม่เจอข้อมูล ให้แสดงเป็นค่าว่าง
      }
    }
    // --- ตรรกะสำหรับมุมมอง "ของพนักงาน" ---
    else {
      // //  ค้นหา Preference ของผู้ใช้ (เพื่อหาว่าเอกสารไหนเป็นของเรา)
      // final userPrefs = DataList.userPreferData.firstWhere(
      //   (pref) => pref['userId'] == currentUserId,
      //   orElse: () => <String, dynamic>{},
      // );

      // final List<String> myDocumentIds = userPrefs.isNotEmpty && userPrefs['documentId'] is List
      //     ? List<String>.from(userPrefs['documentId'])
      //     : [];

      // // กรองเอกสารทั้งหมด ให้เหลือเฉพาะเอกสารที่ "ไม่ใช่" ของเรา
      // final employeeDocuments = DataList.documentData
      //     .where((doc) => !myDocumentIds.contains(doc['documentId']))
      //     .map((map) => DocumentHistoryModel.fromMap(map))
      //     .toList();

      // // 3. อัปเดต UI
      // docHistory.assignAll(employeeDocuments);
      final employeeDocuments = DataList.documentData
          .map((map) => DocumentHistoryModel.fromMap(map))
          .where((doc) => doc.status == DocumentStatus.pending)
          .toList();

      docHistory.assignAll(employeeDocuments);
    }
  }
}
