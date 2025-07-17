import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calender_controller.dart';

class CalenderPage extends GetView<CalenderController> {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: false,
              floating: false,
      
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'ปฏิทิน',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        MenuAnchor(
                          
                          builder: (context, controller, child) {
                            return IconButton(
                              onPressed: () {
                                // เช็คว่าเมนูกำลังเปิดอยู่หรือไม่
                                if (controller.isOpen) {
                                  controller.close(); // ถ้าเปิดอยู่ให้ปิด
                                } else {
                                  controller.open(); // ถ้าปิดอยู่ให้เปิด
                                }
                              },
                              icon: const Icon(Icons.more_horiz),
                              tooltip: 'เปิดเมนู',
                            );
                          },
                    
                         //คือรายการเมนูที่จะแสดง
                          menuChildren: [
                            MenuItemButton(
                              onPressed: () {},
                              leadingIcon: const Icon(Icons.person_outline),
                              child: const Text('โปรไฟล์'),
                            ),
                            MenuItemButton(
                              onPressed: () {},
                              leadingIcon: const Icon(Icons.settings_outlined),
                              child: const Text('ตั้งค่า'),
                            ),
                           
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey[400],),
                  ],
                ),
              ),
            ),
      
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(
                          () => TableCalendar<Event>(
                            availableGestures: AvailableGestures.horizontalSwipe,
                            locale: 'th_TH',
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: controller.focusedDay.value,
                            selectedDayPredicate: (day) =>
                                isSameDay(controller.selectedDay.value, day),
                            calendarFormat: controller.calendarFormat.value,
                            eventLoader: controller.getEventsForDay,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            onDaySelected: controller.onDaySelected,
                            onFormatChanged: controller.onFormatChanged,
                            onPageChanged: controller.onPageChanged,
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              leftChevronIcon: const Icon(
                                Icons.chevron_left,
                                color: Colors.grey,
                              ),
                              rightChevronIcon: const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              ),
                              titleTextFormatter: (date, locale) =>
                                  DateFormat.yMMMM(locale).format(date),
                            ),
                            calendarStyle: CalendarStyle(
                              markersAnchor: 1.3,
                              markersMaxCount: 1,
                              todayDecoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
      
                              selectedDecoration: const BoxDecoration(
                                color: MyColors.blue,
                                shape: BoxShape.circle,
                              ),
                              markerDecoration: const BoxDecoration(
                                color: MyColors.blue,
                                shape: BoxShape.circle,
                              ),
                              markerSize: 6.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildEventList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'กิจกรรม',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          Obx(() {
            if (controller.selectedEvents.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('ไม่มีกิจกรรมในวันที่เลือก'),
                ),
              );
            }
            return ListView.builder(
              itemCount: controller.selectedEvents.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final event = controller.selectedEvents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2,
                  shadowColor: Colors.grey.withValues(alpha: 0.2),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: event.description != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(event.description!),
                          )
                        : null,
                    trailing: Text(
                      event.time,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
