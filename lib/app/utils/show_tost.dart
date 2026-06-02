// dart
// File: lib/app/utils/show_tost.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';




/// Shows a floating success snackbar at the bottom.
void showSuccessSnack({
  String title = 'Success',
  required String message,
  Duration duration = const Duration(seconds: 2),
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.successColor,
    colorText: Colors.white,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    snackStyle: SnackStyle.FLOATING,
    duration: duration,
    titleText: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    icon: const Icon(Icons.check_circle, color: Colors.white),
  );
}



/// Shows a floating error snackbar at the bottom.
void showErrorSnack({
  String title = 'Error',
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withOpacity(0.95),
    colorText: Colors.white,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    snackStyle: SnackStyle.FLOATING,
    duration: duration,
    titleText: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    icon: const Icon(Icons.error, color: Colors.white),
  );
}
