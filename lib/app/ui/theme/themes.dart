import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    iconTheme: const IconThemeData(color: MyColors.blue2,),
    
    textTheme: GoogleFonts.athitiTextTheme(),
   
    
    dividerTheme: const DividerThemeData(
      color: Color.fromRGBO(204, 218, 255, 1),
    ),

    
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      headerBackgroundColor: MyColors.blue,
      headerForegroundColor: Colors.white,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      shape: LinearBorder.none,
      collapsedShape: LinearBorder.none,
      collapsedIconColor: MyColors.blue2,
      
      
    ),
    inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(color: Colors.grey),
            labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,

            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // borderSide: BorderSide(color: Colors.grey[300]!),
              borderSide: BorderSide(color: Color.fromRGBO(204, 218, 255, 1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // borderSide: BorderSide(color: Colors.grey[300]!),
             borderSide: BorderSide(color: Color.fromRGBO(204, 218, 255, 1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // borderSide: BorderSide(color: Colors.grey[300]!),
             borderSide: BorderSide(color: Color.fromRGBO(204, 218, 255, 1)),
            ),
           isDense: true,
           suffixIconColor: MyColors.blue2,
          ),
           
    );
  
  // final darkTheme = ThemeData.dark().copyWith(
  //   primaryColor: Colors.grey[900],
  //   cardColor: Colors.grey[900],
  //   scaffoldBackgroundColor: Colors.grey[800],
  //   shadowColor: Colors.grey,
  // );
}
