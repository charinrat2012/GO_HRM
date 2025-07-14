import 'package:flutter/material.dart';

abstract final class MyColors {
    static const MaterialColor blue = MaterialColor(_bluePrimaryValue, <int, Color>{
    // 50: Color(0xFFFAFAFA),
    // 100: Color(0xFFF5F5F5),
    // 200: Color(0xFFEEEEEE),
    // 300: Color(0xFFE0E0E0),
    // 350: Color(0xFFD6D6D6),
    // 400: Color(0xFFBDBDBD),
    500: Color(_bluePrimaryValue),
    // 600: Color(0xFF757575),
    // 700: Color(0xFF616161),
    // 800: Color(0xFF424242),
    // 850: Color(0xFF303030),
    // 900: Color(0xFF212121),
  });
  static const int _bluePrimaryValue = 0xFF1F87FF;

    static const Color blue2 = Color.fromRGBO(21, 112, 239, 1); 
  // --------------------


}