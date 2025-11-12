import 'dart:convert';
import 'package:cleaning_app/app/utils/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http show post;
import '../../../rotes/app_routes.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_local_storage.dart';
import '../../../utils/app_snackbar.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_url.dart';
class SignUpScreenController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var userType = '';
  final isLoading = false.obs;
  final MapController mapController = Get.put(MapController());
  /// NEW: Country code observable (default to India)
  var selectedCountryCode = "+91".obs;
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
  void togglePasswordVisibility(TextEditingController controller) {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility(TextEditingController controller) {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Static mapping of dial codes to country codes
  String getCountryCodeFromDialCode(String dialCode) {
    final countryMap = {
      '+91': 'IN', // India
      '+1': 'US',  // United States
      '+44': 'GB', // United Kingdom
      '+61': 'AU', // Australia
      '+971': 'AE', // UAE
      '+966': 'SA', // Saudi Arabia
      '+65': 'SG', // Singapore
      '+60': 'MY', // Malaysia
      '+81': 'JP', // Japan
      '+82': 'KR', // South Korea
    };

    // Return the country code or default to 'IN' if not found
    return countryMap[dialCode] ?? 'IN';
  }

  void signUpValidation(
      String name,
      String email,
      String phone,
      String address,
      String password,
      String confirmPassword,
      ) {
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      AppSnackbar.error(message: AppStrings.pleaseFillAllFields);
      return;
    }
    if (email.isNotEmpty && !RegExp(AppConstants.emailRegex).hasMatch(email)) {
      AppSnackbar.error(message: AppStrings.invalidEmail);
      return;
    }
    if (phone.isNotEmpty && phone.length < 6) {
      AppSnackbar.error(message: AppStrings.invalidPhoneNumber);
      return;
    }
    if (password.isNotEmpty && password.length < 6) {
      AppSnackbar.error(message: AppStrings.passwordMustBeAtLeast6Characters);
      return;
    }
    if (confirmPassword.isNotEmpty && confirmPassword != password) {
      AppSnackbar.error(message: AppStrings.passwordsDoNotMatch);
      return;
    }
    signUpApi(name, email, phone, address, password, );
  }
  Future<void> signUpApi(
      name,
      email,
      phone,
      address,
      password,

      ) async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse(AppUrl.signUp),
        body: {
          'name': name,
          'email': email,
          'phone_code': selectedCountryCode.value,
          'mobile': phone,
          'address': address,
          'latitude': mapController.selectedPlace.value!.lat.toStringAsFixed(6).toString() ,
          'longitude': mapController.selectedPlace.value!.lng.toStringAsFixed(6).toString(),
          'password': password,
          'user_type': AppConstants.userType,
          'login_type': 'app',
          'social_id': '78',
          'device_type': AppConstants.deviceType,
          'player_id': AppConstants.playerId,
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true || data['status'] == 'yes') {
          isLoading.value = false;
          String? userId;
          String? token;
          Map<String, dynamic>? userDetails;
          if (data['userDataArray'] != null) {

            userDetails = data['userDataArray'];
            userId = userDetails?['user_id']?.toString();
          } else if (data['user_id'] != null) {
            userId = data['user_id'].toString();
          }
          token = data['token']?.toString();

          AppSnackbar.success(
            message: data['msg'][0]?.toString() ?? 'Registration successful',
          );
          Get.offAllNamed(
            AppRoutes.otp,
            arguments: {'userType': userType, 'userId': userId},
          );
        } else {
          isLoading.value = false;
          final errorMsg = (data['msg'] is List && data['msg'].isNotEmpty)
              ? data['msg'][0].toString()
              : 'Registration failed';
          AppSnackbar.error(message: errorMsg);
          print(data["msg"]);
        }
      } else {
        isLoading.value = false;
        final errorMsg = (data['msg'] is List && data['msg'].isNotEmpty)
            ? data['msg'][0].toString()
            : 'An error occurred';
        AppSnackbar.error(message: errorMsg);
      }
    } catch (e) {
      print("Error: $e");
      isLoading.value = false;
      AppSnackbar.error(message: e.toString());
    }
  }
}










