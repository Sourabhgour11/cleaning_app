import 'package:cleaning_app/app/modules/auth/login_screen/login_screen.dart';
import 'package:cleaning_app/app/modules/auth/login_screen/login_screen_binding.dart';
import 'package:cleaning_app/app/modules/home_screen/home_screen.dart';
import 'package:cleaning_app/app/modules/home_screen/home_screen_binding.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding:LoginScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
  ];
}
