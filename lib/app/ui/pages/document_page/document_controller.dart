

import 'package:get/get.dart';
import '../../../data/models/document_status_model.dart';
import '../../../data/services/auth_service.dart'; 
import '../../global_widgets/datalist.dart';    

class DocumentsController extends GetxController {
  // 3. ดึง AuthService เข้ามาใช้งาน
  final AuthService _authService = Get.find<AuthService>();

  // --- State Variables (ตัวแปรสถานะ) ---
  final RxInt selectedViewIndex = 0.obs;
  final RxList<DocumentHistoryModel> docHistory = <DocumentHistoryModel>[].obs;
  final expandedCardIndex = Rxn<int>();

  // ... (ตัวแปรสำหรับ Dropdown เหมือนเดิม) ...
  // final years = ['2025', '2024', '2023'].obs;
  // final RxnString selectedYear = RxnString('2025');
  // final months = ['ทั้งหมด', 'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม'].obs;
  // final RxnString selectedMonth = RxnString('ทั้งหมด');
  final RxList<String> docTypes = <String>['ทั้งหมด'].obs;
  // `selectedDocumentType` จะเก็บค่าที่ผู้ใช้เลือกจาก Dropdown
  final RxnString selectedDocTypes = RxnString('ทั้งหมด');
  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

    final months = <String>['ทั้งหมด'].obs;
  final years = <String>[].obs;

    final RxnString selectedYear = RxnString('2025');
  final RxnString selectedMonth = RxnString('ทั้งหมด');


  @override
  void onInit() {
    super.onInit();
    loadDocHistory();
    setupDocumentTypeFilter();
    setupFilterData();
  }
void setupFilterData() {
    // --- ดึงข้อมูลปีและเรียงลำดับ ---
    final yearNumbers = DataList.years.map((y) => y['year'] as String).toList();
    yearNumbers.sort((a, b) => b.compareTo(a)); // เรียงปีล่าสุดขึ้นก่อน
    years.assignAll(yearNumbers);

    // --- ตั้งค่าปีเริ่มต้นที่เลือก ---
    if (years.isNotEmpty) {
      selectedYear.value = years.first;
    }

    // --- ดึงข้อมูลเดือน ---
    final monthNames = DataList.months.map((m) => m['month'] as String).toList();
    months.addAll(monthNames);
  }
  
  void setupDocumentTypeFilter() {
    final docTypesFromDataList = DataList.docTypes;
    final types = docTypesFromDataList.map((doc) => doc['type'] as String).toList();
    docTypes.addAll(types);
  }
  void onViewChanged(int? newIndex) {
    if (newIndex != null && selectedViewIndex.value != newIndex) {
      selectedViewIndex.value = newIndex;
      loadDocHistory();
    }
  }

  void loadDocHistory() {
    if (!_authService.isLoggedIn) {
      docHistory.clear();
      return;
    }

    final String currentUserId = _authService.currentUser.value!.userId;
    List<DocumentHistoryModel> filteredDocuments = [];

    // --- กรองข้อมูลตามมุมมอง (ของตัวเอง / ของพนักงาน) ---
    if (selectedViewIndex.value == 0) {
      final userPrefs = DataList.userPreferData.firstWhere(
        (pref) => pref['userId'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );

      if (userPrefs.isNotEmpty && userPrefs['documentId'] is List) {
        final List<String> myDocumentIds = List<String>.from(userPrefs['documentId']);
        filteredDocuments = DataList.documentData
            .where((doc) => myDocumentIds.contains(doc['documentId']))
            .map((map) => DocumentHistoryModel.fromMap(map))
            .toList();
      }
    } else {
      filteredDocuments = DataList.documentData
          .map((map) => DocumentHistoryModel.fromMap(map))
          .where((doc) => doc.status == DocumentStatus.pending)
          .toList();
    }

    // ---  กรองข้อมูลตามปีที่เลือก ---
    if (selectedYear.value != null) {
      filteredDocuments = filteredDocuments.where((doc) {
        return doc.requestDateTime.year.toString() == selectedYear.value;
      }).toList();
    }

    // ---  กรองข้อมูลตามเดือนที่เลือก ---
    if (selectedMonth.value != null && selectedMonth.value != 'ทั้งหมด') {
      // --- หาเลขเดือนจากชื่อเดือน (เช่น "มกราคม" -> 1) ---
      final monthIndex = DataList.months.indexWhere((m) => m['month'] == selectedMonth.value);
      if (monthIndex != -1) {
        final monthNumber = int.parse(DataList.months[monthIndex]['monthId']!);
        filteredDocuments = filteredDocuments.where((doc) {
          return doc.requestDateTime.month == monthNumber;
        }).toList();
      }
    }

    // --- อัปเดต UI ด้วยข้อมูลที่กรองแล้ว ---
    docHistory.assignAll(filteredDocuments);
  }
}