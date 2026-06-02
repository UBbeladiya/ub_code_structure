import 'package:example/features/dashboard/dashboard_view.dart';
import 'package:example/features/splash/splash_bindings.dart';
import 'package:example/features/splash/splash_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView(), binding: SplashBinding()),

    GetPage(name: AppRoutes.dashboard, page: () => const DashboardView(), binding: SplashBinding()),

    /* GetPage(
      name: AppRoutes.webView,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final url = args?['url'] as String? ?? 'https://mada.com';
        final title = args?['title'] as String? ?? 'Mada';
        return AppWebView(url: url, title: title);
      },
    ),*/
  ];
}
