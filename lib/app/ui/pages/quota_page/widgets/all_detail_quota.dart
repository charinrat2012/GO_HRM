import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';

import '../quota_controller.dart';


class AllDetailQuota extends GetView<QuotaController> {
  const AllDetailQuota ({super.key});

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
             
             
              const SizedBox(height: 8),

              Column(
                children: controller.quotaitemsall.map((quota) {
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
                            RichText(text: TextSpan(
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
                            ))
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
