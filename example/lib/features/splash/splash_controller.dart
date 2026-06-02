import 'package:example/app/routes/app_navigation.dart';
import 'package:get/get.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
       AppNavigation.pushToDashboard();
    });
  }
}
