import 'dart:convert';

import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:http/http.dart' as http show MultipartRequest;

import '../../../utils/app_export.dart';
import '../../../utils/app_snackbar.dart';
import '../../../utils/app_url.dart';

class ForgotOtpScreenController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final FocusNode otpFocusNode = FocusNode();
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    userId = AppLocalStorage.getUserId()!;
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
    forgotOtpVerifyApi(otp);
  }

  Future<void> forgotOtpVerifyApi(String otp) async {
    isLoading.value = true;
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppUrl.forgotOtpVerify),
      );
      request.fields.addAll({'user_id': userId, 'otp': otp});

      var response = await request.send();

      // Read response body from StreamedResponse
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(responseBody);

        if (data['status'] == true ||
            data['status'] == 'yes' ||
            data['success'] == true) {
          isLoading.value = false;
          String successMsg = 'OTP verified successfully';
          if (data['msg'][0] != null) {
            successMsg = data['msg'][0].toString();
          }
          AppSnackbar.success(message: successMsg);
          Get.toNamed(AppRoutes.resetPassword);
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

  Future<void> forgotResentOtpApi() async {
    isLoading.value = true;
    try {
      print("========== Verify OTP API ==========");
      print("User ID: $userId");
      print("API URL: ${AppUrl.forgotResentOtp}");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppUrl.forgotResentOtp),
      );
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
}
