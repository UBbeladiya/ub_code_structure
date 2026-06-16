
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_navigation.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/utils/validators.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isSubmitting = false.obs;

  String? validateEmail(String? value) {
    return Validators.callFunction(ValidatorType.email, value?.trim());
  }

  String? validatePassword(String? value) {
    return Validators.callFunction(ValidatorType.password, value);
  }

  Future<void> login() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    isSubmitting.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isSubmitting.value = false;

    AppNavigation.pushToDashboard(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  void goToSignup() {
    Get.toNamed(AppRoutes.registration);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() {
    // TODO: Load initial data.
  }
}
