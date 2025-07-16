import 'package:flutter/cupertino.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'รายการ',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
