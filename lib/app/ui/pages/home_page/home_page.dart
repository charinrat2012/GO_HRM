import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/home_page/widgets/home_body.dart';
import 'package:go_hrm/app/ui/pages/home_page/widgets/home_head.dart';
import 'home_controller.dart';


class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeHead(),
          HomeBody()
        ],
      ),
    );
  }
}
