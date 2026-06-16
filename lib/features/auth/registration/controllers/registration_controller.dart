import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/services/permission_service.dart';
import '../../../../app/utils/validators.dart';


class RegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final selectedGender = ''.obs;
  final selectedRole = RxnString();
  final selectedDob = Rxn<DateTime>();
  final profileImage = Rxn<File>();
  final isSubmitting = false.obs;

  final _picker = ImagePicker();
  final PermissionService _permissionService =
      Get.isRegistered<PermissionService>()
          ? Get.find<PermissionService>()
          : Get.put(PermissionService());

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  String? validateName(String? value) {
    return Validators.callFunction(ValidatorType.name, value?.trim());
  }

  String? validateEmail(String? value) {
    return Validators.callFunction(ValidatorType.email, value?.trim());
  }

  String? validateMobile(String? value) {
    return Validators.callFunction(ValidatorType.mobile, value?.trim());
  }

  String? validatePassword(String? value) {
    return Validators.callFunction(ValidatorType.password, value);
  }

  String? validateConfirmPassword(String? value) {
    final passwordError = Validators.callFunction(ValidatorType.password, value);
    if (passwordError != null) return passwordError;
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  Future<void> pickBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = selectedDob.value ?? DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked == null) return;

    selectedDob.value = picked;
    final dd = picked.day.toString().padLeft(2, '0');
    final mm = picked.month.toString().padLeft(2, '0');
    dobController.text = '$dd/$mm/${picked.year}';
  }

  Future<void> pickProfileImage() async {
    final isGranted = await _permissionService.requestGallery();
    if (!isGranted) {
      Get.snackbar(
        'Permission needed',
        'Please allow gallery access to choose a profile picture.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1024,
    );

    if (file == null) return;
    profileImage.value = File(file.path);
  }

  void setGender(String? value) {
    selectedGender.value = value ?? '';
  }

  void setRole(String? value) {
    selectedRole.value = value;
  }

  Future<void> submit() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    if (selectedGender.value.isEmpty) {
      Get.snackbar('Validation', 'Please select a gender', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (selectedRole.value == null) {
      Get.snackbar('Validation', 'Please select a role', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (selectedDob.value == null) {
      Get.snackbar('Validation', 'Please select your birth date', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isSubmitting.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isSubmitting.value = false;

    Get.snackbar(
      'Success',
      'Registration form submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
