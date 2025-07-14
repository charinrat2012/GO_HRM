import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../splash_controllers.dart';

class HeadLogin extends GetView<SplashController> {
  const HeadLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
              opacity: controller.fadelogoAnimation,
              child: ScaleTransition(
                scale: controller.scalelogoAnimation,
                child: SlideTransition(
                  position: controller.slidelogoAnimation,
                  child: SvgPicture.asset('assets/imgs/go_logo.svg', height: 118),
                ),
              ),
            );
  }
}
