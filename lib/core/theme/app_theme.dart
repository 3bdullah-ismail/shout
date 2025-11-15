import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 24,
        color: AppColors.blackPrimary,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        fontSize: 24,
        color: AppColors.blackPrimary,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.blackPrimary,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.blackPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      backgroundColor: AppColors.white,
    ),
    tabBarTheme: TabBarThemeData(
      overlayColor: WidgetStateColor.transparent,
      tabAlignment: TabAlignment.start,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,

      labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16),
      labelColor: AppColors.white,
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelColor: AppColors.purplePrimary,
    ),
  );
}
