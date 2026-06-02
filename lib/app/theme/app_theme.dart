import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';



class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.lightBorder,
    hintColor: AppColors.placeholderText,
    iconTheme: const IconThemeData(color: AppColors.black),
    colorScheme: .new(
      brightness: .light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryPink,
      onSecondary: AppColors.onPrimary,
      surfaceContainer: AppColors.variantBackground,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
      tertiary: AppColors.textSecondary,
      onTertiaryContainer: AppColors.textTertiary,
      onTertiary: AppColors.tertiaryButtonText,

      // background: AppColors.background,
      // onBackground: AppColors.textPrimary,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightBorder,
      thickness: 0.7,
      space: 24,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: AppColors.textPrimary,
    ),
  );

  static ThemeData get dark => light;
}
