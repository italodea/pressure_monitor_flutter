import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class AppStyle {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: false,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: AppColors.backgroundColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        toolbarHeight: 50,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(1),
          fixedSize: MaterialStateProperty.all(const Size(200, 50)),
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme: AppText.getTheme(),
    );
  }
}
