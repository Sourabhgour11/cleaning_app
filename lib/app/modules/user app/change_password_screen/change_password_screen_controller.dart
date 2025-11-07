import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_snackbar.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var isOldPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  var isLoading = false.obs;

  final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<void> changePasswordApi() async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // --- Validation ---
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'New passwords do not match');
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }

    isLoading(true);

    try {
      String? rawToken = AppLocalStorage.getToken();
      String? userId = AppLocalStorage.getUserId();

      if (rawToken == null || rawToken.isEmpty) {
        Get.snackbar('Error', 'Token not found. Please login again.');
        isLoading(false);
        return;
      }

      // ✅ Ensure correct Bearer format
      String token = rawToken.startsWith('Bearer ') ? rawToken : 'Bearer $rawToken';

      print('🔹 TOKEN SENT: $token');
      print('🔹 USER ID: $userId');

      final response = await dio.post(
        AppUrl.changePassword,
        data: {
          'user_id': userId,
          'old_password': oldPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': 'application/json',
          },
        ),
      );

      print('🔹 RESPONSE: ${response.data}');

      // ✅ Safely extract message whether it's a String or List
      final rawMsg = response.data['msg'];
      final message = (rawMsg is List)
          ? rawMsg.join(', ')
          : rawMsg?.toString() ?? 'No message received';

      if (response.statusCode == 200 && response.data['success'] == true) {
        AppSnackbar.success(message: message);
        Get.toNamed(AppRoutes.login);
        // AppLocalStorage.clearAll();
        AppLocalStorage.remove('user_id');
        AppLocalStorage.remove('token');
        AppLocalStorage.remove('user_details');
        clearFields();
      } else {
        AppSnackbar.error(message: message);
      }
    } on DioException catch (e) {
      print('❌ DIO ERROR: ${e.response?.data}');
      final data = e.response?.data;

      String message = 'Failed to change password';

      if (data is Map && data.containsKey('msg')) {
        final msg = data['msg'];
        message = (msg is List) ? msg.join(', ') : msg.toString();
      } else if (data is Map && data.containsKey('message')) {
        final msg = data['message'];
        message = (msg is List) ? msg.join(', ') : msg.toString();
      }

      Get.snackbar('Error', message);
    } catch (e) {
      print('❌ Unexpected error: $e');
      Get.snackbar('Error', 'Unexpected error occurred');
    } finally {
      isLoading(false);
    }
  }


  void clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
