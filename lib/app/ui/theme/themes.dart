import 'package:flutter/material.dart';

import '../../config/my_colors.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: MyColors.blue,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[100]),
    scaffoldBackgroundColor: Colors.grey[100],
    shadowColor: Colors.grey,
  );
  // final darkTheme = ThemeData.dark().copyWith(
  //   primaryColor: Colors.grey[900],
  //   cardColor: Colors.grey[900],
  //   scaffoldBackgroundColor: Colors.grey[800],
  //   shadowColor: Colors.grey,
  // );
}
