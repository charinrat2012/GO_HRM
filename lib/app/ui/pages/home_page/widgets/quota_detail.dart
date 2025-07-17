import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../routes/app_routes.dart';
import '../home_controller.dart';

class QuotaDetail extends GetView<HomeController> {
  const QuotaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Text(
                  'โควต้าการลา',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.QUOTA);
                  },
                  icon: Icon(Icons.navigate_next, color: MyColors.blue2),
                ),
              ),
              Divider(),
              const SizedBox(height: 8),

              Column(
                children: controller.quotaitems.map((quota) {
                  final progress = quota.total > 0
                      ? quota.remaining / quota.total
                      : 0.0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              quota.type,
                              style: const TextStyle(fontSize: 14),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '${quota.remaining} วัน',
                                style: TextStyle(
                                  color: MyColors.blue2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' / ${quota.total} วัน',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Text.rich(
                            //   TextSpan(
                            //     children: [
                            //       TextSpan(
                            //         text: '${quota.remaining} วัน',
                            //         style: TextStyle(
                            //           color: MyColors.blue2,
                            //           fontWeight: FontWeight.bold,

                            //         ),
                            //       ),
                            //       TextSpan(
                            //         text: ' / ${quota.total} วัน',
                            //         style: const TextStyle(
                            //           color: Colors.grey,

                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 3,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            MyColors.blue2,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
