

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/services/theme_service.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'ui/layouts/main/main_layout.dart';
import 'ui/theme/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Go HRM',
      debugShowCheckedModeBanner: false,
      theme: Themes().lightTheme,
      // darkTheme: Themes().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      // translations: Translation(),
      // locale: Locale('en'),
      // fallbackLocale: Locale('en'),
      initialRoute: AppRoutes.NOTIFICATION,
      unknownRoute: AppPages.unknownRoutePage,
      getPages: AppPages.pages,
      builder: (_, child) {
        return MainLayout(child: child!);
      },
    );
  }
}
