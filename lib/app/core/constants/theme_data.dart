import 'package:flutter/material.dart';

import '../confiq/app_colors.dart';
import 'app_text_style.dart';

class AppThemeData {
  static ThemeData lightThemeData = ThemeData(

    primaryColor: Color(0xFF676BD0),

    primarySwatch: Colors.blue,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgColor,
      titleTextStyle: AppTextStyle.headerTextStyle(),
    ),

  );
}