import 'package:cleaning_app/app/modules/auth/login_screen/login_screen.dart';
import 'package:cleaning_app/app/modules/auth/login_screen/login_screen_binding.dart';
import 'package:cleaning_app/app/modules/auth/reset_password_screen/reset_password_screen.dart';
import 'package:cleaning_app/app/modules/auth/reset_password_screen/reset_password_screen_binding.dart';
import 'package:cleaning_app/app/modules/delete%20account/delete_screen_binding.dart';
import 'package:cleaning_app/app/modules/get%20content/get_content_binding.dart';
import 'package:cleaning_app/app/modules/get%20content/get_content_screen.dart';
import 'package:cleaning_app/app/modules/help%20&%20support/help_and_support_screen.dart';
import 'package:cleaning_app/app/modules/help%20&%20support/help_and_support_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step1/book_service_step1_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step1/book_service_step1_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step2/book_service_step2_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step2/book_service_step2_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step3/book_service_step3_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step3/book_service_step3_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step_4/book_service_step4_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step_4/book_service_step4_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_details_screen/booking_details_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_details_screen/booking_details_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_screen/booking_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_screen/booking_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/bottom_nav_screen/bottom_nav_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/favourites_screen/favourites_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/favourites_screen/favourites_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/sub_categories_screen/sub_categories_screen.dart';
import 'package:get/get.dart';
import '../modules/auth/forgot_otp_screen/forgot_otp_screen.dart';
import '../modules/auth/forgot_otp_screen/forgot_otp_screen_binding.dart';
import '../modules/auth/forgot_password/forgot_password_screen.dart';
import '../modules/auth/forgot_password/forgot_password_screen_binding.dart';
import '../modules/auth/otp_screen/otp_screen.dart';
import '../modules/auth/otp_screen/otp_screen_binding.dart';
import '../modules/auth/sign_up_screen/sign_up_screen.dart';
import '../modules/auth/sign_up_screen/sign_up_screen_binding.dart';
import '../modules/cleaner app/booking screen/booking_screen.dart';
import '../modules/cleaner app/booking screen/booking_screen_binding.dart';
import '../modules/cleaner app/bottom_nav_screen/bottom_nav_screen.dart';
import '../modules/cleaner app/bottom_nav_screen/bottom_nav_screen_binding.dart';
import '../modules/cleaner app/edit profile/edit_profile_screen.dart';
import '../modules/cleaner app/edit profile/edit_profile_screen_binding.dart';
import '../modules/cleaner app/home screen/home_screen.dart';
import '../modules/cleaner app/home screen/home_screen_binding.dart';
import '../modules/cleaner app/inbox screen/inbox_screen.dart';
import '../modules/cleaner app/inbox screen/inbox_screen_binding.dart';
import '../modules/cleaner app/incentive/incentive_screen.dart';
import '../modules/cleaner app/incentive/incentive_screen_binding.dart';
import '../modules/delete account/delete_screen.dart';
import '../modules/partner app/bottom_nav_screen/bottom_nav_screen.dart';
import '../modules/partner app/bottom_nav_screen/bottom_nav_screen_binding.dart';
import '../modules/select_user_screen/select_user_screen.dart';
import '../modules/select_user_screen/select_user_screen_binding.dart';
import '../modules/splash_screen/splash_screen.dart';
import '../modules/splash_screen/splash_screen_binding.dart';
import '../modules/user app/sub_categories_screen/sub_categories_screen_binding.dart';
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
      name: AppRoutes.resetPassword,
      page: () => ResetPassword(),
      binding: ResetPasswordScreenBinding(),
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
      name: AppRoutes.userBookingScreen,
      page: () => UserBookingScreen(),
      binding: UserBookingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.inbox,
      page: () => InboxScreen(),
      binding: InboxScreenBinding(),
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
      name: AppRoutes.cleanerbottomNav,
      page: () => CleanerBottomNavScreen(),
      binding: CleanerBottomNavBinding(),
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
      name: AppRoutes.partnerbottomNav,
      page: () => PartnerBottomNavScreen(),
      binding: PartnerBottomNavBinding(),
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
    GetPage(
      name: AppRoutes.bookingDetails,
      page: () => BookingDetailsScreen(),
      binding: BookingDetailsScreenBinding(),
    ),
  ];
}
