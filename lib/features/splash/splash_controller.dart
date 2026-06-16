import 'package:get/get.dart';

import '../../app/routes/app_navigation.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      AppNavigation.pushToLogin();
    });
  }
}
