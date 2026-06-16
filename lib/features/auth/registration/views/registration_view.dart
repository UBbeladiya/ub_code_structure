
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/app_primary_button.dart';
import '../../../../widget/app_text_input.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Obx(() {
                    final image = controller.profileImage.value;
                    return GestureDetector(
                      onTap: controller.pickProfileImage,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundImage: image != null ? FileImage(image) : null,
                            child: image == null
                                ? const Icon(Icons.person, size: 38)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Upload profile picture',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                PrimaryTextField(
                  placeholder: 'Full name',
                  controller: controller.nameController,
                  validator: controller.validateName,
                ),
                const SizedBox(height: 12),
                PrimaryTextField(
                  placeholder: 'Email',
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: 12),
                Text('Gender', style: textTheme.bodyMedium),
                const SizedBox(height: 4),
                Obx(
                  () => RadioGroup<String>(
                    groupValue: controller.selectedGender.value,
                    onChanged: (value) => controller.setGender(value),
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'Male',
                            title: const Text('Male'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'Female',
                            title: const Text('Female'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryTextField(
                  placeholder: 'Date of birth',
                  controller: controller.dobController,
                  readOnly: true,
                  onTap: () => controller.pickBirthDate(context),
                  trailing: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.calendar_month_outlined, size: 20),
                  ),
                  validator: (value) => controller.validateRequired(value, 'Date of birth'),
                ),
                const SizedBox(height: 12),
                PrimaryTextField(
                  placeholder: 'Mobile number',
                  controller: controller.mobileController,
                  keyboardType: TextInputType.phone,
                  validator: controller.validateMobile,
                ),
                const SizedBox(height: 12),
                PrimaryPasswordTextField(
                  placeholder: 'Password',
                  controller: controller.passwordController,
                  validator: controller.validatePassword,
                ),
                const SizedBox(height: 12),
                PrimaryPasswordTextField(
                  placeholder: 'Confirm password',
                  controller: controller.confirmPasswordController,
                  validator: controller.validateConfirmPassword,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: controller.selectedRole.value,
                  decoration: InputDecoration(
                    hintText: 'Select role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'user', child: Text('user')),
                  ],
                  onChanged: controller.setRole,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Role is required' : null,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => PrimaryButton.infinity(
                    'Submit',
                    isLoading: controller.isSubmitting.value,
                    onPressed: controller.submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
