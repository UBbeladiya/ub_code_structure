
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/app_primary_button.dart';
import '../../../../widget/app_text_input.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  PrimaryTextField(
                    placeholder: 'Email id',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 12),
                  PrimaryPasswordTextField(
                    placeholder: 'Password',
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => PrimaryButton.infinity(
                      'Log In',
                      onPressed: controller.login,
                      isLoading: controller.isSubmitting.value,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton.infinity(
                    'Sign Up',
                    onPressed: controller.goToSignup,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
