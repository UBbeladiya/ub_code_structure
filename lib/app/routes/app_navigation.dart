

import 'package:get/get.dart';

import 'app_routes.dart';

class AppNavigation {
  static void getBackWithValue(dynamic result) {
    Get.back(result: result);
  }

  static void getBack() {
    Get.back();
  }


  static void pushToDashboard({String? email, String? password}) {
    Get.offAllNamed(
      AppRoutes.dashboard,
      arguments: {
        'email': email,
        'password': password,
      },
    );
  }
  static void pushToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void pushToRegistration() {
    Get.offAllNamed(AppRoutes.registration);
  }

  // static void getBackWithValue(dynamic result) {
  //   Get.back(result: result);
  // }
  //
  // static void getBack() {
  //   Get.back();
  // }
  //
  // static void pushToLogin() {
  //   Get.toNamed(AppRoutes.login);
  // }
  //
  // static void pushToAuthSelection() {
  //   Get.offAllNamed(AppRoutes.authSelection);
  // }
  //
  // static void pushToWebView(String url, String title) {
  //   Get.toNamed(AppRoutes.webView, arguments: {'url': url, 'title': title});
  // }
}
