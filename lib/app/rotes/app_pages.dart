import 'package:cleaning_app/app/modules/contact_us/contact_us_screen.dart';
import 'package:cleaning_app/app/modules/contact_us/contact_us_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step2/book_service_step2_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step2/book_service_step2_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step3/book_service_step3_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step3/book_service_step3_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step4/book_service_step4_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step4/book_service_step4_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_details_screen/booking_details_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_details_screen/booking_details_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_screen/booking_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_screen/booking_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/change_password_screen/change_password_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/change_password_screen/change_password_screen_binding.dart';
import 'package:cleaning_app/app/modules/user%20app/edit_profile_screen/edit_profile_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/edit_profile_screen/edit_profile_screen_binding.dart';
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
      page: () => SignUpScreen(),
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
      name: AppRoutes.userBookingScreen,
      page: () => UserBookingScreen(),
      binding: UserBookingScreenBinding(),
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
      page: () => SignUpScreen(),
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
    GetPage(
      name: AppRoutes.bookingDetails,
      page: () => BookingDetailsScreen(),
      binding: BookingDetailsScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: EditProfileScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.contactUs,
      page: () => ContactUsScreen(),
      binding: ContactUsBinding(),
    ),
  ];
}
