import 'package:flutter/material.dart';

class MenuHead extends StatelessWidget implements PreferredSizeWidget {
  const MenuHead({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'เมนู',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
