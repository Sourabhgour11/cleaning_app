import 'package:cleaning_app/app/modules/auth/login_screen/login_screen.dart';
import 'package:cleaning_app/app/modules/auth/login_screen/login_screen_binding.dart';
import 'package:get/get.dart';
import '../modules/auth/forgot_otp_screen/forgot_otp_screen.dart';
import '../modules/auth/forgot_otp_screen/forgot_otp_screen_binding.dart';
import '../modules/auth/forgot_password/forgot_password_screen.dart';
import '../modules/auth/forgot_password/forgot_password_screen_binding.dart';
import '../modules/auth/otp_screen/otp_screen.dart';
import '../modules/auth/otp_screen/otp_screen_binding.dart';
import '../modules/auth/resate_password_screen/resate_password_screen.dart';
import '../modules/auth/resate_password_screen/resate_password_screen_binding.dart';
import '../modules/auth/sign_up_screen/sign_up_screen.dart';
import '../modules/auth/sign_up_screen/sign_up_screen_binding.dart';
import '../modules/cleaner app/booking screen/booking_screen.dart';
import '../modules/cleaner app/booking screen/booking_screen_binding.dart';
import '../modules/cleaner app/bottom_nav_screen/bottom_nav_screen.dart';
import '../modules/cleaner app/bottom_nav_screen/bottom_nav_screen_binding.dart';
import '../modules/cleaner app/home screen/home_screen.dart';
import '../modules/cleaner app/home screen/home_screen_binding.dart';
import '../modules/cleaner app/inbox screen/inbox_screen.dart';
import '../modules/cleaner app/inbox screen/inbox_screen_binding.dart';
import '../modules/select_user_screen/select_user_screen.dart';
import '../modules/select_user_screen/select_user_screen_binding.dart';
import '../modules/splash_screen/splash_screen.dart';
import '../modules/splash_screen/splash_screen_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
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

    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OtpScreenScreen(),
      binding: OtpScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotOtp,
      page: () => ForgotOtpScreen(),
      binding: ForgotOtpScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.resatePassword,
      page: () => ResatePasswordScreen(),
      binding: ResatePasswordScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.cleanerHome,
      page: () => CleanerHomeScreen(),
      binding: CleanerHomeScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => BookingScreen(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: AppRoutes.inbox,
      page: () => InboxScreen(),
      binding: InboxScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => BottomNavScreen(),
      binding: BottomNavBinding(),
    ),
  ];
}
