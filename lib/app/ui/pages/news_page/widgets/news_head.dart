import 'package:flutter/material.dart';

class NewsHead extends StatelessWidget {
  const NewsHead({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text(
        'ข่าวสาร',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      floating: false,
      pinned: false,
      elevation: 1.0,
    );
  }
}
