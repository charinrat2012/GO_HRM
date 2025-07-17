

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      locale: const Locale('th', 'TH'),
      supportedLocales: const [
        Locale('th', 'TH'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // initialRoute: AppRoutes.NAVIGATION,
      
      // initialRoute: AppRoutes.SALARY,
      initialRoute: AppRoutes.SPLASH,
      unknownRoute: AppPages.unknownRoutePage,
      getPages: AppPages.pages,
      builder: (_, child) {
        return MainLayout(child: child!);
      },
    );
  }
}
