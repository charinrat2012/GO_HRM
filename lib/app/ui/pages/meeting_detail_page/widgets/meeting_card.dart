import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../meeting_detail_controller.dart';

class MeetingCard extends GetView<MeetingDetailController> {
  const MeetingCard({super.key});

  @override
  Widget build(BuildContext context) {
     final formattedDate = DateFormat('d MMMM yyyy', 'th_TH').format(controller.event.date);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(22.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color.fromRGBO(204, 218, 255, 1)),
            boxShadow: const [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    // 'ประชุมกับผู้บริหาร',
                    controller.event.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                   Text(
                    // '10.30 - 11.00 ',
                    controller.event.time,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8),
               Text(
                // 'วันศุกร์ที่ 25/06/2025',
                formattedDate,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'หมายเหตุ :',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                   Text(
                    // 'นัดประชุมกสำคัญ',
                     controller.event.note ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
