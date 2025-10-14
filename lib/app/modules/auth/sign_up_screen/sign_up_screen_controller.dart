import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenController extends GetxController {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var userType = '';

  @override
  void onInit() {
    super.onInit();
    userType = Get.arguments ?? '';
    print("SignUp userType: $userType");
  }

  @override
  void onClose() {
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
}
