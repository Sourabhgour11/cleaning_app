import 'package:cleaning_app/app/utils/app_export.dart';

class AppUrl {

  static const String baseUrl = 'https://turningindia.com/CleanPro/server';
  static const String imageUrl = 'https://turningindia.com/CleanPro/server/images/';

  static const String login = '$baseUrl/login';
  static const String signUp = '$baseUrl/sign_up';
  static const String otpVerify = '$baseUrl/otp_verify';
  static const String resendOtp = '$baseUrl/resend_otp';
  static const String forgotPassword = '$baseUrl/forgot_password';
  static const String forgotOtpVerify = '$baseUrl/forgot_password_otp_verify';
  static const String forgotOtp = '$baseUrl/forgotOtp';
  static const String forgotResentOtp = '$baseUrl/forgot_password_resend_otp';

  //DONE BY RAM
  static const String resetPassword = '$baseUrl/resetPassword';

  //SOURABH
  static const String changePassword = '$baseUrl/change_password';

  static String homeDetailsApi(String userId) =>
      '$baseUrl/get_home_page_api?user_id=$userId';

  static String walletDetailsApi(String userId) =>
      '$baseUrl/get_wallet?user_id=$userId';

  static const String contactUs = '$baseUrl/contact_us';
  static const String deleteAccount = '$baseUrl/delete_account';
  static const String getNotification = '$baseUrl/get_notification';
  static const String deleteSingleNotification = '$baseUrl/delete_single_notification';
  static const String deleteAllNotification = '$baseUrl/delete_all_notification';
  static const String getContent = '$baseUrl/get_content';

  static String getSubCatByCatId(int categoryId) =>
      '$baseUrl/get_sub_category_by_category_id?category_id=$categoryId';
  static const String editProfile = '$baseUrl/edit_profile';

  static String getUserBookingApi(String userId) =>
      '$baseUrl/get_wallet?user_id=$userId';

  static String getSubSubCategoryApi(int catSubCatId, int categoryId) =>
      '$baseUrl/get_service_by_subcategory?cat_sub_cat_id=${catSubCatId}&category_id=${categoryId}';

}
