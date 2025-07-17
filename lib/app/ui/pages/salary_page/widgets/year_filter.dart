import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../salary_controller.dart';
import '../../../../config/my_colors.dart';

class YearFilter extends GetView<SalaryController> {
  const YearFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Obx(() {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: controller.years.map((year) {
                final isSelected = controller.selectedYear.value == year;
                return GestureDetector(
                  onTap: () {
                    controller.selectedYear.value = year;
                    controller.loadSalaryData();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15, // <-- ลดค่า padding แนวนอน
                      vertical: 4, // <-- ลดค่า padding แนวตั้ง
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ), // เว้นระยะระหว่างปุ่ม
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : Colors
                                .grey[100], // สีพื้นหลังสีขาวเมื่อเลือก  และโปร่งใส่เมื่อไม่เลือก
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: isSelected
                            ? MyColors
                                  .blue //ถ้าปุ่มถูกเลือก เส้นขอบจะเป็น สีฟ้า
                            : Colors
                                  .grey[300]!, //ถ้าปุ่มไม่ได้ถูกเลือก เส้นขอบจะเป็น สีเทาอ่อน
                      ),
                    ),
                    child: Text(
                      year,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? MyColors.blue
                            : Colors
                                  .black, // สีข้อความเป็นสีฟ้าเมื่อปุ่มถูกเลือก
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
