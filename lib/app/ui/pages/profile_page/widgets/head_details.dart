import 'package:flutter/material.dart';

class HeadDetails extends StatelessWidget {
  const HeadDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Align( 
        alignment: Alignment.centerLeft, 
        child: Text(
          'ข้อมูลพนักงาน',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}