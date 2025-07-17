import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../routes/app_routes.dart';
import '../home_controller.dart';

class HomeMenu extends GetView<HomeController> {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        // color: Colors.tealAccent,
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
                  'รายการโปรด',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: ()  => Get.toNamed(AppRoutes.FAVOURITE_SETTINGS),
                  icon: Icon(Icons.navigate_next, color: MyColors.blue2),
                ),
              ),

              Divider(),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       'รายการโปรด',
              //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              //     ),
              //     Text('>', style: TextStyle(color: Colors.grey[600])),
              //   ],
              // ),
              GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.menuitems.map((favorite) {
                  return Column(
                    children: [
                      IconButton(
                        onPressed: favorite.onPressed,
                        icon: Icon(
                          favorite.icon,
                          color: MyColors.blue2,
                          size: 21.75,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          // shape: CircleBorder(side: BorderSide(color: MyColors.blue, width: 1.5,),),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        favorite.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       favorite['icon'] as IconData,
                  //       color: MyColors.blue,
                  //       size: 30,
                  //     ),
                  //     const SizedBox(height: 8),
                  //     Text(
                  //       favorite['title'] as String,
                  //       textAlign: TextAlign.center,
                  //       style: const TextStyle(fontSize: 12),
                  //     ),
                  //   ],
                  // );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}