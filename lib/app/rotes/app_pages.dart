import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step2/book_service_step2_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step2/book_service_step2_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step3/book_service_step3_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step3/book_service_step3_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step_4/book_service_step4_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step_4/book_service_step4_screen_binding.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

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
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: EditProfileScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.incentive,
      page: () => IncentiveScreen(),
      binding: IncentiveScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.helpAndSupport,
      page: () => HelpAndSupportScreen(),
      binding: HelpAndSupportScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.getContent,
      page: () => GetContentScreen(),
      binding: GetContentBinding(),
    ),
    GetPage(
      name: AppRoutes.deleteAccount,
      page: () => DeleteScreen(),
      binding: DeleteScreenBinding(),
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
      name: AppRoutes.resetPassword,
      page: () => ResetPassword(),
      binding: ResetPasswordScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => BottomNavScreen(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: AppRoutes.subCategory,
      page: () => SubCategoriesScreen(),
      binding: SubCategoriesScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.bookServiceStep1,
      page: () => BookServiceStep1Screen(),
      binding: BookServiceStep1ScreenBinding(),
    ),
   GetPage(
      name: AppRoutes.bookServiceStep2,
      page: () => BookServiceStep2Screen(),
      binding: BookServiceStep2ScreenBinding(),
    ),
   GetPage(
      name: AppRoutes.bookServiceStep3,
      page: () => BookServiceStep3Screen(),
      binding: BookServiceStep3ScreenBinding(),
    ),
   GetPage(
      name: AppRoutes.bookServiceStep4,
      page: () => BookServiceStep4Screen(),
      binding: BookServiceStep4ScreenBinding(),
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
      name: AppRoutes.userBottomNav,
      page: () => UserBottomNavScreen(),
      binding: UserBottomNavBinding(),
    ),
    GetPage(
      name: AppRoutes.favourite,
      page: () => FavouritesScreen(),
      binding: FavouritesScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.deleteAccount,
      page: () => DeleteScreen(),
      binding: DeleteScreenBinding(),
    ),
  ];
}
