import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/menu_form.dart';
import 'widgets/menu_head.dart';

class MenuPage extends GetView<MenuController> {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MenuHead(), 
        body: MenuForm()),
    );
  }
}
