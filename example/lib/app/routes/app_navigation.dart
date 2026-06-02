



import 'package:example/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppNavigation {
  static void getBackWithValue(dynamic result) {
    Get.back(result: result);
  }

  static void getBack() {
    Get.back();
  }

  static void pushToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

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
