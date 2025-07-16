import 'dart:io';

import 'package:get/get.dart';

import '../../../data/models/document_status_model.dart';


class DocumentsController extends GetxController {
  // 0 = ของตัวเอง, 1 = ของพนักงาน
  final RxInt selectedViewIndex = 0.obs;

  // Dropdown data
  final years = ['2025', '2024', '2023'].obs;
  final RxnString selectedYear = RxnString('2025');

  final months = ['ทั้งหมด', 'มกราคม', 'กุมภาพันธ์', 'มีนาคม'].obs;
  final RxnString selectedMonth = RxnString('ทั้งหมด');

  final leaveTypes = ['ทั้งหมด', 'โอทีล่วงหน้า', 'ลาป่วย', 'ลาพักร้อน'].obs;
  final RxnString selectedLeaveType = RxnString('ทั้งหมด');

  final other = ['ค้นหาแบบละเอียด', '1', '2', '3'].obs;
  final RxnString selectedOther = RxnString('ค้นหาแบบละเอียด');

  final RxList<DocumentHistoryModel> leaveHistory = <DocumentHistoryModel>[].obs;
final expandedCardIndex = Rxn<int>();


  // ข้อมูลสำหรับมุมมอง "ของตัวเอง"
  final List<DocumentHistoryModel> _myLeaveData = [
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'ณัฐดนย์ วัฒนวงศ์ศรีสุข',
      leaveCategory: 'โอทีล่วงหน้า',
      requestDateTime: DateTime(2025, 6, 25, 12, 6),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.approved,
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'ณัฐดนย์ วัฒนวงศ์ศรีสุข',
      leaveCategory: 'โอทีล่วงหน้า',
      requestDateTime: DateTime(2025, 6, 24, 10, 30),
      status: DocumentStatus.rejected,
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'ณัฐดนย์ วัฒนวงศ์ศรีสุข',
      leaveCategory: 'โอทีล่วงหน้า',
      requestDateTime: DateTime(2025, 6, 25, 12, 6),
      note: '',
      status: DocumentStatus.approved,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'ณัฐดนย์ วัฒนวงศ์ศรีสุข',
      leaveCategory: 'ลาป่วย',
      requestDateTime: DateTime(2025, 6, 24, 10, 30),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.rejected,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'ณัฐดนย์ วัฒนวงศ์ศรีสุข',
      leaveCategory: 'โอทีล่วงหน้า',
      requestDateTime: DateTime(2025, 6, 25, 12, 6),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.approved,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'ณัฐดนย์ วัฒนวงศ์ศรีสุข',
      leaveCategory: 'ลาป่วย',
      requestDateTime: DateTime(2025, 6, 24, 10, 30),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.rejected,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
  ];

  // ข้อมูลสำหรับมุมมอง "ของพนักงาน"
  final List<DocumentHistoryModel> _employeeLeaveData = [
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'สมชาย ใจดี',
      leaveCategory: 'โอทีล่วงหน้า',
      requestDateTime: DateTime(2025, 7, 1, 9, 0),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.pending,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
        File('/mock/path/ใบรับรองแพทย์.jpg'),
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'สมหญิง มุ่งมั่น',
      leaveCategory: 'ลาป่วย',
      requestDateTime: DateTime(2025, 6, 30, 14, 20),
      note: '',
      status: DocumentStatus.pending,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'มานะ อดทน',
      leaveCategory: 'ลาพักร้อน',
      requestDateTime: DateTime(2025, 6, 28, 16, 5),
      note: '',
      status: DocumentStatus.pending,
      attachedFiles: [
        File('/mock/path/ใบรับรองแพทย์.jpg'),
      ],
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'สมชาย ใจดี',
      leaveCategory: 'โอทีล่วงหน้า',
      requestDateTime: DateTime(2025, 7, 1, 9, 0),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.pending,
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'สมหญิง มุ่งมั่น',
      leaveCategory: 'ลาป่วย',
      requestDateTime: DateTime(2025, 6, 30, 14, 20),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.pending,
    ),
    DocumentHistoryModel(
      leaveType: 'ขอลาพักงาน',
      employeeName: 'มานะ อดทน',
      leaveCategory: 'ลาพักร้อน',
      requestDateTime: DateTime(2025, 6, 28, 16, 5),
      note: 'ต้องการเงินล่วงหน้า',
      status: DocumentStatus.pending,
    ),
  ];


  @override
  void onInit() {
    super.onInit();
    // โหลดข้อมูลเริ่มต้นตามมุมมองที่ถูกเลือกไว้ (คือ "ของตัวเอง")
    loadLeaveHistory();
  }

  void onViewChanged(int? newIndex) {
    if (newIndex != null && selectedViewIndex.value != newIndex) {
      selectedViewIndex.value = newIndex;
      // เมื่อมีการเปลี่ยนมุมมอง ให้โหลดข้อมูลชุดใหม่
      loadLeaveHistory();
    }
  }


  void loadLeaveHistory() {
    // ตรวจสอบค่าของ selectedViewIndex
    if (selectedViewIndex.value == 0) {
      // ถ้าเป็นมุมมอง "ของตัวเอง" ให้โหลดข้อมูล _myLeaveData
      leaveHistory.assignAll(_myLeaveData);
    } else {
      // ถ้าเป็นมุมมอง "ของพนักงาน" ให้โหลดข้อมูล _employeeLeaveData
      leaveHistory.assignAll(_employeeLeaveData);
    }
  }
}
