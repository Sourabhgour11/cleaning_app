import 'package:cleaning_app/app/modules/auth/login_screen/login_screen.dart';
import 'package:cleaning_app/app/modules/auth/login_screen/login_screen_binding.dart';
import 'package:cleaning_app/app/modules/home_screen/home_screen.dart';
import 'package:cleaning_app/app/modules/home_screen/home_screen_binding.dart';
import 'package:cleaning_app/app/modules/select_user_screen/select_user_screen.dart';
import 'package:cleaning_app/app/modules/select_user_screen/select_user_screen_binding.dart';
import 'package:cleaning_app/app/modules/splash_screen/splash_screen.dart';
import 'package:cleaning_app/app/modules/splash_screen/splash_screen_binding.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding:LoginScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.selectUserScreen,
      page: () => const SelectUserScreen(),
      binding: SelectUserScreenBinding(),
    ),
  ];
}
