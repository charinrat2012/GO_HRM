import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'splash_controllers.dart';
import 'widgets/box_login.dart';
import 'widgets/head_login.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SlideTransition(
              position: controller.slidehead1Animation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 100),
                      Center(
                        child: SvgPicture.asset(
                          'assets/imgs/hrm_logo.svg',
                          height: 82,
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: SlideTransition(
                      position: controller.slidecontentAnimation,
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.shade50,
                            width: 2,
                          ),
                          color: Colors.grey.shade50,
                        ),
                      ),
                    ),
                  ),
                  HeadLogin(),
                  FadeTransition(
                    opacity: controller.fadeboxAnimation,
                    child: Column(
                      children: [
                        SizedBox(height: 470),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: BoxLogin(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
