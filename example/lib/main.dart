import 'package:example/app/routes/app_pages.dart';
import 'package:example/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/routes/app_routes.dart';
import 'app/services/storage_service.dart';
import 'features/splash/splash_bindings.dart';

void main() async {
  // Ensures Flutter engine and plugin bindings are ready before async startup.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app-level services before rendering UI.
  await initServices();

  // Launch root application widget.
  runApp(const MyApp());
}

/// Root application widget that wires routing, bindings, and themes.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Outfit App',
      debugShowCheckedModeBanner: false,
      // Registers initial dependency bindings for the startup module.
      initialBinding: SplashBinding(),
      // Starts app from splash route.
      initialRoute: AppRoutes.splash,
      // Central route table for GetX navigation.
      getPages: AppPages.pages,
      // App theming configuration.
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      // translations: MyTranslations(),
    );
  }
}

Future<void> initServices() async {
  // Shared preferences must be initialized before read/write access.
  await AppPreference.initMySharedPreferences();
  // Get.put(NetworkService());
}
