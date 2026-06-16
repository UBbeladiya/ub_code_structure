import 'package:get/get.dart';

class DashboardController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() {
    final args = Get.arguments as Map<String, dynamic>?;
    email.value = (args?['email'] as String?) ?? '';
    password.value = (args?['password'] as String?) ?? '';
  }
}
