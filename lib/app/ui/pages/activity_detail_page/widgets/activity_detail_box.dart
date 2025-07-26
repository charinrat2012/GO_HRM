import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../routes/app_routes.dart';
import '../activity_detail_controller.dart';

class ActivityDetailBox extends GetView<ActivityDetailController> {
  
  const ActivityDetailBox({super.key});

  @override
  Widget build(BuildContext context) {
     final formattedDate = DateFormat('d MMMM yyyy', 'th_TH').format(controller.event.date);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.MEETINGDETAIL, arguments: controller.event),
          child: Container(
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color.fromRGBO(204, 218, 255, 1)),
              boxShadow: const [
                // BoxShadow(
                //   color: Colors.grey.withAlpha(100), //ความทีบ
                //   spreadRadius: 1, //รัศมีของการกระจายของเงา
                //   blurRadius: 5, //รัศมีการเบลอ
                //   offset: const Offset(
                //     0,
                //     3,
                //   ),
                // ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // 'วันก่อตั้งบริษัท',
                      controller.event.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
          
                     Text(
                      controller.event.time ,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                 Text(
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
      ),
    );
  }
}
