import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.grey,
      appBarTheme: const AppBarTheme(
          color: AppColors.grey,
          centerTitle: true,
          titleTextStyle: TextStyle(fontFamily: "Indie", fontSize: 32)),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color.fromARGB(255, 8, 52, 128)));

  static TextStyle whiteTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
  );
}
