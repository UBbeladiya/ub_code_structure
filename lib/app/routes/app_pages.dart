import 'package:get/get.dart';

import '../../features/auth/login/bindings/login_binding.dart';
import '../../features/auth/login/views/login_view.dart';
import '../../features/auth/registration/bindings/registration_binding.dart';
import '../../features/auth/registration/views/registration_view.dart';
import '../../features/dashboard/dashboard_binding.dart';
import '../../features/dashboard/dashboard_view.dart';
import '../../features/splash/splash_bindings.dart';
import '../../features/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView(), binding: SplashBinding()),

    GetPage(name: AppRoutes.dashboard, page: () => const DashboardView(), binding: DashboardBinding()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
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