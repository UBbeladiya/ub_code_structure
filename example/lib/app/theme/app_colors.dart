import 'package:flutter/material.dart';

/// Light theme palette used across widgets and app surfaces.
class AppColors {
  /// Accent pink used for secondary emphasis.
  static const primaryPink = Color(0xFFf2c0de);

  /// Primary brand color.
  static const primary = Color(0xFF000000);

  /// Foreground color rendered on top of [primary].
  static const onPrimary = Color(0xFFFFFFFF);

  /// Default high-emphasis text color.
  static const textPrimary = Color(0xFF000000);

  /// Default medium-emphasis text color.
  static const textSecondary = Color(0xFF9E9E9E);

  /// Tertiary text color used for low-emphasis text.
  static final textTertiary = AppColors.black.withValues(alpha: 0.6);

  /// Placeholder text color in input controls.
  static const placeholderText = Color(0xFF9E9E9E);

  /// Main app background color.
  static const background = Color(0xFFFFFFFF);

  /// Alternate background used by cards and grouped areas.
  static const variantBackground = Color(0xFFefefef);

  /// Semantic error color.
  static const red = Color(0xFFFF0000);

  /// Pure white convenience color.
  static const white = Color(0xFFFFFFFF);

  /// Pure black convenience color.
  static const black = Color(0xFF000000);

  /// Filled primary button background.
  static const primaryButton = Color(0xFFf2c0de);

  /// Filled primary button foreground.
  static const primaryButtonText = Color(0xFF000000);

  /// Outlined secondary button background.
  static const secondaryButton = Color(0xFFFFFFFF);

  /// Outlined secondary button foreground.
  static const secondaryButtonText = Color(0xFFFFFFFF);

  /// Text color used in tertiary buttons.
  static const tertiaryButtonText = Color(0xFF9E9E9E);

  /// Default border color.
  static const border = Color(0x889E9E9E);

  /// Light border color for dividers and subtle outlines.
  static const lightBorder = Color(0x449E9E9E);

  /// Success feedback color for snackbars and badges.
  static const successColor = Color(0x99007B0C);
}

/// Minimal dark theme palette overrides.
class AppDarkColors {
  /// Primary brand color in dark mode.
  static const primary = Color(0xFF000000);

  /// Main scaffold background in dark mode.
  static const background = Color(0xFF000000);
}
