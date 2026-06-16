import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard View', style: textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text('Email: ${controller.email.value}', style: textTheme.bodyLarge),
              const SizedBox(height: 8),
              Text('Password: ${controller.password.value}', style: textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
