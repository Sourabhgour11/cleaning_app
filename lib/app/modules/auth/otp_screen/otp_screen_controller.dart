import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/app_export.dart';
import '../../../utils/app_local_storage.dart';
import '../../../utils/app_snackbar.dart';
import '../../../utils/app_url.dart';

class OtpScreenController extends GetxController {
  var isLoading = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final FocusNode otpFocusNode = FocusNode();
  var userType = '';
  var userId = '';

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments ?? {};
    userType = arguments['userType'] ?? '';
    userId = arguments['userId'] ?? '';
    print("OTP userType: $userType");
    print("OTP userId: $userId");
  }

  @override
  void onClose() {
    otpController.value.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  void verifyOtp(String otp) {
    if (otp.isEmpty) {
      AppSnackbar.error(message: AppStrings.otplength);
      return;
    }
    if (otp.length < 6) {
      AppSnackbar.error(message: AppStrings.otplength);
      return;
    }
    if (userId.isEmpty) {
      AppSnackbar.error(
        message: 'User ID not found. Please try signing up again.',
      );
      return;
    }
    // Call OTP verify API
    verifyOtpApi(otp);
  }

  Future<void> verifyOtpApi(String otp) async {
    isLoading.value = true;
    try {
      print("========== Verify OTP API ==========");
      print("User ID: $userId");
      print("OTP: $otp");
      print("API URL: ${AppUrl.otpVerify}");

      var request = http.MultipartRequest('POST', Uri.parse(AppUrl.otpVerify));
      request.fields.addAll({'user_id': userId, 'otp': otp});

      var response = await request.send();
      print("Response status: ${response.statusCode}");

      // Read response body from StreamedResponse
      var responseBody = await response.stream.bytesToString();
      print("Full Response: $responseBody");
      print("===================================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(responseBody);
        print("Data: $data");

        if (data['status'] == true ||
            data['status'] == 'yes' ||
            data['success'] == true) {
          isLoading.value = false;
          String successMsg = 'OTP verified successfully';
          if (data['msg'][0] != null) {
            successMsg = data['msg'][0].toString();
          }
          AppSnackbar.success(message: successMsg);

          // Update user data if token or other details are returned
          if (data['token'] != null) {
            String? token = data['token'].toString();
            Map<String, dynamic>? userDetails;

            if (data['userDataArray'] != null &&
                data['userDataArray'].length > 0) {
              if (data['userDataArray'] is List &&
                  data['userDataArray'].isNotEmpty) {
                userDetails = data['userDataArray'][0];
              }
            }

            bool saved = await AppLocalStorage.saveUserData(
              userId: userId,
              token: token,
              userDetails: userDetails,
            );
            if (saved) {
              print("Updated user data in local storage");
            }
          }

          // Show success popup
          showLottiePopup(Get.context!);
        } else {
          isLoading.value = false;
          String errorMsg = 'OTP verification failed';
          if (data['msg'] != null) {
            if (data['msg'] is List && data['msg'].isNotEmpty) {
              errorMsg = data['msg'][0].toString();
            } else {
              errorMsg = data['msg'].toString();
            }
          }
          AppSnackbar.error(message: errorMsg);
        }
      } else {
        print("Error: ${response.statusCode}");
        isLoading.value = false;
        AppSnackbar.error(message: 'OTP verification failed');
      }
    } catch (e) {
      print("Exception: $e");
      isLoading.value = false;
      AppSnackbar.error(message: e.toString());
    }
  }

  Future<void> resentOtpApi() async {
    isLoading.value = true;
    try {
      print("========== Verify OTP API ==========");
      print("User ID: $userId");
      print("API URL: ${AppUrl.resendOtp}");

      var request = http.MultipartRequest('POST', Uri.parse(AppUrl.resendOtp));
      request.fields.addAll({'user_id': userId});

      var response = await request.send();
      print("Response status: ${response.statusCode}");

      // Read response body from StreamedResponse
      var responseBody = await response.stream.bytesToString();
      print("Full Response: $responseBody");
      print("===================================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(responseBody);
        print("Data: $data");

        if (data['status'] == true ||
            data['status'] == 'yes' ||
            data['success'] == true) {
          isLoading.value = false;
          String successMsg = 'OTP verified successfully';
          if (data['msg'] != null) {
            successMsg = data['msg'][0].toString();
          }
          AppSnackbar.success(message: successMsg);
          AppSnackbar.success(message: data['userDataArray']['otp']);
        } else {
          isLoading.value = false;
          String errorMsg = 'OTP verification failed';
          if (data['msg'] != null) {
            if (data['msg'] is List && data['msg'].isNotEmpty) {
              errorMsg = data['msg'][0].toString();
            } else {
              errorMsg = data['msg'][0].toString();
            }
          }
          AppSnackbar.error(message: errorMsg);
        }
      } else {
        print("Error: ${response.statusCode}");
        isLoading.value = false;
        AppSnackbar.error(message: 'OTP verification failed');
      }
    } catch (e) {
      print("Exception: $e");
      isLoading.value = false;
      AppSnackbar.error(message: e.toString());
    }
  }

  void otpValidation(otp) {
    if (otp.length < 6) {
      AppSnackbar.error(message: AppStrings.otplength);
    }
  }

  void showLottiePopup(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie Animation Container
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    color: Colors.grey[50],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.asset('lib/assets/icons/checkMark.gif'),
                  ),
                ),

                const SizedBox(height: 20),

                // Success Text
                const Text(
                  'Your account has been successfully verified!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                const Text(
                  'Please waiting for admin approval',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // OK Button
                SizedBox(
                  width: double.infinity,
                  height: AppStyle.heightPercent(context, 6),
                  child: AppButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.login);
                    },
                    title: "OK",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
