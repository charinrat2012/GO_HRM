import 'package:flutter/material.dart';

import '../../config/my_colors.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: MyColors.blue,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.grey[200],
    shadowColor: Colors.grey,
     highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      headerBackgroundColor: MyColors.blue,
      headerForegroundColor: Colors.white,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      shape: LinearBorder.none,
      collapsedShape: LinearBorder.none,
      
    ),
  );
  // final darkTheme = ThemeData.dark().copyWith(
  //   primaryColor: Colors.grey[900],
  //   cardColor: Colors.grey[900],
  //   scaffoldBackgroundColor: Colors.grey[800],
  //   shadowColor: Colors.grey,
  // );
}
